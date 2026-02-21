"""
Veterinary service — procedure act business logic.
Handles act creation, EDS signing workflow, ISZH vaccination sync.
"""
from typing import Optional
from uuid import UUID, uuid4
from datetime import datetime, timezone
import logging
import json

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_, func
from sqlalchemy.orm import selectinload

from app.models.veterinary import ProcedureAct, ProcedureActAnimal
from app.models.document import DigitalSignature
from app.integrations.smart_bridge.client import smart_bridge, SmartBridgeError
from app.core.exceptions import NotFoundError, ForbiddenError, ExternalServiceError
from app.core.permissions import Permission
from app.utils.pdf_generator import generate_procedure_act_pdf

logger = logging.getLogger(__name__)


class VeterinaryService:

    async def get_procedure_acts(
        self,
        db: AsyncSession,
        *,
        page: int = 1,
        page_size: int = 20,
        status: Optional[str] = None,
        procedure_type: Optional[str] = None,
        specialist_id: Optional[UUID] = None,
        organization_id: Optional[UUID] = None,
        species_id: Optional[str] = None,
        date_from: Optional[datetime] = None,
        date_to: Optional[datetime] = None,
    ) -> tuple[list[ProcedureAct], int]:
        q = select(ProcedureAct)

        if status:
            q = q.where(ProcedureAct.status == status)
        if procedure_type:
            q = q.where(ProcedureAct.procedure_type == procedure_type)
        if specialist_id:
            q = q.where(ProcedureAct.specialist_id == specialist_id)
        if organization_id:
            q = q.where(ProcedureAct.organization_id == organization_id)
        if species_id:
            q = q.where(ProcedureAct.species_id == species_id)
        if date_from:
            q = q.where(ProcedureAct.act_date >= date_from)
        if date_to:
            q = q.where(ProcedureAct.act_date <= date_to)

        count_q = select(func.count()).select_from(q.subquery())
        total = (await db.execute(count_q)).scalar_one()

        q = q.offset((page - 1) * page_size).limit(page_size)
        q = q.order_by(ProcedureAct.act_date.desc())

        result = await db.execute(q)
        acts = result.scalars().all()
        return list(acts), total

    async def get_procedure_act(
        self, db: AsyncSession, act_id: UUID
    ) -> ProcedureAct:
        result = await db.execute(
            select(ProcedureAct)
            .where(ProcedureAct.id == act_id)
            .options(selectinload(ProcedureAct.act_animals))
        )
        act = result.scalar_one_or_none()
        if not act:
            raise NotFoundError(f"Procedure act {act_id} not found")
        return act

    async def create_procedure_act(
        self, db: AsyncSession, data: dict, created_by: UUID
    ) -> ProcedureAct:
        """
        Create a new procedure act from API data.
        Matches all fields from Excel template (Без названия (4).xls):
        - act_number, act_date, procedure_type, disease_name
        - region_kato, settlement, specialist_id
        - participants_json (list of names)
        - owner_iin, owner_name
        - species_id, male_count, female_count, young_count, total_vaccinated
        - vaccine_name/allergen_name, manufacturer, production_date, series
        - state_control_no, injection_method, dose_adult_ml, dose_young_ml
        - materials_json (expendable materials from Без названия (3).xls)
        """
        animals_data = data.pop("animals", [])

        act = ProcedureAct(
            id=uuid4(),
            created_by=created_by,
            status="draft",
            **{k: v for k, v in data.items() if hasattr(ProcedureAct, k)},
        )
        db.add(act)
        await db.flush()  # get act.id

        # Add animal records (from Без названия (5).xls table)
        for a in animals_data:
            act_animal = ProcedureActAnimal(
                id=uuid4(),
                act_id=act.id,
                **{k: v for k, v in a.items() if hasattr(ProcedureActAnimal, k)},
            )
            db.add(act_animal)

        await db.commit()
        await db.refresh(act)
        logger.info(f"Created procedure act {act.act_number} (id={act.id})")
        return act

    async def initiate_signing(
        self,
        db: AsyncSession,
        act_id: UUID,
        signer_id: UUID,
        signer_name: str,
        signer_iin: str,
    ) -> dict:
        """
        Initiate EDS signing via eGov Mobile QR flow.
        Returns QR data URL and challenge token.
        Phase 5: Real NCALayer/eGov Mobile integration.
        """
        act = await self.get_procedure_act(db, act_id)
        if act.status == "signed":
            raise ForbiddenError("Act is already signed")

        # Build document hash for signing
        doc_hash = self._compute_document_hash(act)

        # Phase 5: Send to NCALayer for QR generation
        # For now, return mock QR data
        challenge_token = str(uuid4())

        # Update status to pending
        act.status = "pending_signature"
        await db.commit()

        return {
            "act_id": str(act_id),
            "challenge_token": challenge_token,
            "document_hash": doc_hash,
            "qr_data": f"egov://sign?doc={doc_hash}&token={challenge_token}",
            "expires_in": 300,  # 5 minutes
        }

    async def complete_signing(
        self,
        db: AsyncSession,
        act_id: UUID,
        challenge_token: str,
        signature_data: str,
        signer_id: UUID,
        signer_name: str,
        signer_iin: str,
    ) -> ProcedureAct:
        """Complete EDS signing after eGov Mobile callback."""
        act = await self.get_procedure_act(db, act_id)

        # Store digital signature
        sig = DigitalSignature(
            id=uuid4(),
            document_type="procedure_act",
            document_id=act_id,
            signer_id=signer_id,
            signer_name=signer_name,
            signer_iin=signer_iin,
            signature_data=signature_data,
            signed_at=datetime.now(timezone.utc),
            is_valid=True,
        )
        db.add(sig)

        # Update act status
        act.status = "signed"
        act.signed_at = datetime.now(timezone.utc)
        await db.commit()
        await db.refresh(act)

        # Trigger async ISZH sync
        await self._sync_to_iszh(act)

        logger.info(f"Act {act.act_number} signed by {signer_name} ({signer_iin})")
        return act

    async def generate_pdf(
        self, db: AsyncSession, act_id: UUID
    ) -> str:
        """Generate PDF for procedure act and return MinIO URL."""
        act = await self.get_procedure_act(db, act_id)
        pdf_url = await generate_procedure_act_pdf(act)
        if pdf_url:
            act.pdf_url = pdf_url
            await db.commit()
        return pdf_url or ""

    async def _sync_to_iszh(self, act: ProcedureAct) -> bool:
        """Push signed vaccination act to ISZH via Smart Bridge."""
        if act.procedure_type != "vaccination":
            return True

        vaccination_data = {
            "act_number": act.act_number,
            "act_date": act.act_date.isoformat() if act.act_date else None,
            "disease_name": act.disease_name,
            "vaccine_name": act.vaccine_name,
            "series": act.series,
            "total_vaccinated": act.total_vaccinated,
            "species_id": act.species_id,
            "region_kato": act.region_kato,
        }

        try:
            success = await smart_bridge.sync_vaccination(vaccination_data)
            if success:
                logger.info(f"Vaccination act {act.act_number} synced to ISZH")
            return success
        except SmartBridgeError as e:
            logger.error(f"ISZH sync failed for act {act.act_number}: {e}")
            return False

    def _compute_document_hash(self, act: ProcedureAct) -> str:
        """Compute deterministic hash of act data for signing."""
        import hashlib
        doc_str = f"{act.act_number}|{act.act_date}|{act.total_vaccinated}|{act.disease_name}"
        return hashlib.sha256(doc_str.encode()).hexdigest()


# Singleton service instance
veterinary_service = VeterinaryService()

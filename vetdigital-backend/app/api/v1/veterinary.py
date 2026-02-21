from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from datetime import datetime, timezone

from app.database import get_db
from app.dependencies import CurrentUser
from app.core.pagination import PaginationParams, PagedResponse
from app.models.veterinary import ProcedureAct, ProcedureActAnimal
from app.schemas.veterinary import (
    ProcedureActCreate, ProcedureActResponse, SignDocumentRequest
)

router = APIRouter()


@router.get("", response_model=PagedResponse[ProcedureActResponse], summary="List procedure acts")
async def list_procedures(
    current_user: CurrentUser,
    page: int = Query(default=1, ge=1),
    size: int = Query(default=20, ge=1, le=100),
    status_filter: Optional[str] = Query(None, alias="status"),
    region_id: Optional[int] = None,
    species_id: Optional[int] = None,
    procedure_type: Optional[str] = None,
    veterinarian_id: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
):
    query = select(ProcedureAct)

    if status_filter:
        query = query.where(ProcedureAct.status == status_filter)
    if region_id:
        query = query.where(ProcedureAct.region_id == region_id)
    if species_id:
        query = query.where(ProcedureAct.species_id == species_id)
    if procedure_type:
        query = query.where(ProcedureAct.procedure_type == procedure_type)
    if veterinarian_id:
        query = query.where(ProcedureAct.veterinarian_id == veterinarian_id)

    count_result = await db.execute(select(func.count()).select_from(query.subquery()))
    total = count_result.scalar_one()

    params = PaginationParams(page=page, size=size)
    result = await db.execute(
        query.offset(params.offset).limit(params.size).order_by(ProcedureAct.act_date.desc())
    )
    acts = result.scalars().all()

    return PagedResponse.create(
        items=[ProcedureActResponse.model_validate(a) for a in acts],
        total=total, page=page, size=size,
    )


@router.post("", response_model=ProcedureActResponse, status_code=status.HTTP_201_CREATED,
             summary="Create procedure act (vaccination/allergy test/etc)")
async def create_procedure(
    current_user: CurrentUser,
    data: ProcedureActCreate,
    db: AsyncSession = Depends(get_db),
):
    # Check for duplicate act number
    existing = await db.execute(
        select(ProcedureAct).where(ProcedureAct.act_number == data.act_number)
    )
    if existing.scalar_one_or_none():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Procedure act '{data.act_number}' already exists",
        )

    # Build act data
    act_data = data.model_dump(exclude={"participants", "materials", "act_animals"})
    act_data["veterinarian_id"] = current_user.id
    act_data["participants_json"] = [p.model_dump() for p in data.participants] if data.participants else None
    act_data["materials_json"] = [m.model_dump() for m in data.materials] if data.materials else None

    act = ProcedureAct(**act_data)
    db.add(act)
    await db.flush()

    # Add animals to act (File 5 animal registry table)
    if data.act_animals:
        for i, animal_data in enumerate(data.act_animals):
            act_animal = ProcedureActAnimal(
                procedure_act_id=act.id,
                sort_order=i,
                **animal_data.model_dump()
            )
            db.add(act_animal)

    await db.commit()
    await db.refresh(act)
    return ProcedureActResponse.model_validate(act)


@router.get("/{act_id}", response_model=ProcedureActResponse)
async def get_procedure(
    current_user: CurrentUser,
    act_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(ProcedureAct).where(ProcedureAct.id == act_id))
    act = result.scalar_one_or_none()
    if not act:
        raise HTTPException(status_code=404, detail="Procedure act not found")
    return ProcedureActResponse.model_validate(act)


@router.get("/{act_id}/animals", summary="Get animal registry list for act (File 5)")
async def get_act_animals(
    current_user: CurrentUser,
    act_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(ProcedureActAnimal)
        .where(ProcedureActAnimal.procedure_act_id == act_id)
        .order_by(ProcedureActAnimal.sort_order)
    )
    animals = result.scalars().all()
    return {"act_id": act_id, "count": len(animals), "animals": [
        {
            "id": a.id, "animal_id": a.animal_id, "owner_id": a.owner_id,
            "identification_no": a.identification_no, "sex": a.sex,
            "age_description": a.age_description, "color_kk": a.color_kk, "color_ru": a.color_ru,
            "vaccination_date": str(a.vaccination_date) if a.vaccination_date else None,
            "allergy_result": a.allergy_result, "allergy_skin_measurement_mm": a.allergy_skin_measurement_mm,
            "allergy_difference_mm": a.allergy_difference_mm,
        }
        for a in animals
    ]}


@router.post("/{act_id}/sign", summary="EDS sign the procedure act")
async def sign_procedure(
    current_user: CurrentUser,
    act_id: str,
    request: SignDocumentRequest,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(ProcedureAct).where(ProcedureAct.id == act_id))
    act = result.scalar_one_or_none()
    if not act:
        raise HTTPException(status_code=404, detail="Procedure act not found")
    if act.status == "signed":
        raise HTTPException(status_code=400, detail="Already signed")
    if act.veterinarian_id != current_user.id:
        raise HTTPException(status_code=403, detail="Only the creating veterinarian can sign")

    # TODO: Phase 5 - Verify EDS signature via NCALayer
    # For now, store signature and mark as signed
    from app.models.document import DigitalSignature
    sig = DigitalSignature(
        document_type="procedure_act",
        document_id=act_id,
        signer_id=current_user.id,
        signer_iin=current_user.iin,
        signer_name=request.signer_name,
        signature_data=request.signature_data,
        certificate_sn=request.certificate_sn,
        signed_at=datetime.now(timezone.utc).isoformat(),
    )
    db.add(sig)

    act.status = "signed"
    act.signed_at = datetime.now(timezone.utc).isoformat()

    await db.commit()
    return {"message": "Procedure act signed successfully", "act_id": act_id, "status": "signed"}


@router.get("/{act_id}/pdf", summary="Download signed PDF of procedure act")
async def get_procedure_pdf(
    current_user: CurrentUser,
    act_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(ProcedureAct).where(ProcedureAct.id == act_id))
    act = result.scalar_one_or_none()
    if not act:
        raise HTTPException(status_code=404, detail="Procedure act not found")

    if act.signed_document_url:
        return {"download_url": act.signed_document_url}

    # TODO: Phase 3 - Generate PDF from template
    return {"message": "PDF generation available in Phase 3", "act_id": act_id}

"""
Animal service layer — business logic between API and models.
Handles ISZH sync, RFID lookup, GPS data aggregation.
"""
from typing import Optional
from uuid import UUID, uuid4
from datetime import datetime, timezone
import logging

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_, or_, func
from sqlalchemy.orm import selectinload

from app.models.animal import Animal, AnimalSpecies, AnimalBreed
from app.models.owner import Owner
from app.models.gps import GPSDevice, GPSReading
from app.integrations.smart_bridge.client import smart_bridge, SmartBridgeError
from app.integrations.animalid.client import animalid_client, AnimalIDError
from app.core.exceptions import NotFoundError, ConflictError, ExternalServiceError

logger = logging.getLogger(__name__)


class AnimalService:

    async def get_animals(
        self,
        db: AsyncSession,
        *,
        page: int = 1,
        page_size: int = 20,
        species_id: Optional[str] = None,
        status: Optional[str] = None,
        owner_iin: Optional[str] = None,
        search: Optional[str] = None,
        region_kato: Optional[str] = None,
        organization_id: Optional[str] = None,
    ) -> tuple[list[Animal], int]:
        """Get paginated animal list with optional filters."""
        q = select(Animal).where(Animal.deleted_at.is_(None))

        if species_id:
            q = q.where(Animal.species_id == species_id)
        if status:
            q = q.where(Animal.status == status)
        if region_kato:
            q = q.where(Animal.region_kato.startswith(region_kato))
        if organization_id:
            q = q.where(Animal.organization_id == organization_id)
        if owner_iin:
            owner_sub = select(Owner.id).where(Owner.iin == owner_iin)
            q = q.where(Animal.owner_id.in_(owner_sub))
        if search:
            q = q.where(
                or_(
                    Animal.identification_no.ilike(f"%{search}%"),
                    Animal.microchip_no.ilike(f"%{search}%"),
                    Animal.rfid_tag_no.ilike(f"%{search}%"),
                )
            )

        # Total count
        count_q = select(func.count()).select_from(q.subquery())
        total = (await db.execute(count_q)).scalar_one()

        # Paginate
        q = q.offset((page - 1) * page_size).limit(page_size)
        q = q.options(selectinload(Animal.species), selectinload(Animal.owner))
        q = q.order_by(Animal.created_at.desc())

        result = await db.execute(q)
        animals = result.scalars().all()

        return list(animals), total

    async def get_animal(self, db: AsyncSession, animal_id: UUID) -> Animal:
        result = await db.execute(
            select(Animal)
            .where(and_(Animal.id == animal_id, Animal.deleted_at.is_(None)))
            .options(
                selectinload(Animal.species),
                selectinload(Animal.breed),
                selectinload(Animal.owner),
                selectinload(Animal.gps_device),
            )
        )
        animal = result.scalar_one_or_none()
        if not animal:
            raise NotFoundError(f"Animal {animal_id} not found")
        return animal

    async def create_animal(
        self, db: AsyncSession, data: dict, created_by: UUID
    ) -> Animal:
        """Create a new animal, optionally syncing with ISZH."""
        # Check for duplicate identification number
        if data.get("identification_no"):
            existing = await db.execute(
                select(Animal).where(
                    Animal.identification_no == data["identification_no"],
                    Animal.deleted_at.is_(None),
                )
            )
            if existing.scalar_one_or_none():
                raise ConflictError(
                    f"Animal with identification_no {data['identification_no']} already exists"
                )

        animal = Animal(
            id=uuid4(),
            **{k: v for k, v in data.items() if hasattr(Animal, k)},
            created_by=created_by,
        )
        db.add(animal)
        await db.commit()
        await db.refresh(animal)

        logger.info(f"Created animal {animal.id} ({animal.identification_no})")
        return animal

    async def update_animal(
        self, db: AsyncSession, animal_id: UUID, data: dict, updated_by: UUID
    ) -> Animal:
        animal = await self.get_animal(db, animal_id)
        for key, value in data.items():
            if hasattr(animal, key) and key not in ("id", "created_at", "created_by"):
                setattr(animal, key, value)
        animal.updated_at = datetime.now(timezone.utc)
        await db.commit()
        await db.refresh(animal)
        return animal

    async def soft_delete(self, db: AsyncSession, animal_id: UUID, deleted_by: UUID) -> None:
        animal = await self.get_animal(db, animal_id)
        animal.deleted_at = datetime.now(timezone.utc)
        await db.commit()

    async def lookup_by_rfid(self, db: AsyncSession, rfid_tag_no: str) -> Optional[Animal]:
        """Look up animal by RFID tag — local first, then ISZH."""
        # Local lookup
        result = await db.execute(
            select(Animal).where(
                Animal.rfid_tag_no == rfid_tag_no,
                Animal.deleted_at.is_(None),
            )
        )
        animal = result.scalar_one_or_none()
        if animal:
            return animal

        # Try AnimalID.kz (TROVAN microchip DB)
        try:
            data = await animalid_client.lookup_microchip(rfid_tag_no)
            if data:
                logger.info(f"Found animal via AnimalID.kz: {rfid_tag_no}")
                # TODO: Phase 5 - auto-create from AnimalID data
        except AnimalIDError as e:
            logger.warning(f"AnimalID lookup failed: {e}")

        return None

    async def lookup_by_microchip(
        self, db: AsyncSession, microchip_no: str
    ) -> Optional[Animal]:
        """Look up animal by microchip — local first, then Smart Bridge ISZH."""
        result = await db.execute(
            select(Animal).where(
                Animal.microchip_no == microchip_no,
                Animal.deleted_at.is_(None),
            )
        )
        animal = result.scalar_one_or_none()
        if animal:
            return animal

        # Try Smart Bridge → ISZH
        try:
            iszh_data = await smart_bridge.get_animal_by_microchip(microchip_no)
            if iszh_data:
                logger.info(f"Found in ISZH: {microchip_no}")
                return None  # Phase 5: auto-create from ISZH
        except SmartBridgeError as e:
            raise ExternalServiceError(f"ISZH lookup failed: {e}")

        return None

    async def get_animal_location(self, db: AsyncSession, animal_id: UUID) -> Optional[dict]:
        """Get latest GPS position for an animal."""
        animal = await self.get_animal(db, animal_id)
        if not animal.gps_device_id:
            return None

        result = await db.execute(
            select(GPSDevice).where(GPSDevice.id == animal.gps_device_id)
        )
        device = result.scalar_one_or_none()
        if not device or not device.last_latitude:
            return None

        return {
            "latitude": float(device.last_latitude),
            "longitude": float(device.last_longitude),
            "battery_level": device.battery_level,
            "last_seen_at": device.last_seen_at.isoformat() if device.last_seen_at else None,
            "device_id": str(device.id),
        }

    async def get_track_history(
        self,
        db: AsyncSession,
        animal_id: UUID,
        *,
        from_dt: Optional[datetime] = None,
        to_dt: Optional[datetime] = None,
        limit: int = 500,
    ) -> list[GPSReading]:
        """Get GPS track history for an animal."""
        animal = await self.get_animal(db, animal_id)
        if not animal.gps_device_id:
            return []

        q = select(GPSReading).where(GPSReading.device_id == animal.gps_device_id)
        if from_dt:
            q = q.where(GPSReading.timestamp >= from_dt)
        if to_dt:
            q = q.where(GPSReading.timestamp <= to_dt)
        q = q.order_by(GPSReading.timestamp.asc()).limit(limit)

        result = await db.execute(q)
        return list(result.scalars().all())


# Singleton service instance
animal_service = AnimalService()

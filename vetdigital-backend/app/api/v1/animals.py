from typing import Optional, List
from fastapi import APIRouter, Depends, HTTPException, Query, UploadFile, File, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, or_, func

from app.database import get_db
from app.dependencies import CurrentUser, require_permission
from app.core.permissions import Permission
from app.core.pagination import PaginationParams, PagedResponse
from app.models.animal import Animal
from app.models.gps import GPSDevice
from app.schemas.animal import (
    AnimalCreate, AnimalUpdate, AnimalResponse,
    RFIDLookupRequest, AnimalLocationResponse,
)

router = APIRouter()


@router.get("", response_model=PagedResponse[AnimalResponse], summary="List animals")
async def list_animals(
    current_user: CurrentUser,
    page: int = Query(default=1, ge=1),
    size: int = Query(default=20, ge=1, le=100),
    species_id: Optional[int] = None,
    owner_id: Optional[str] = None,
    region_id: Optional[int] = None,
    status: Optional[str] = None,
    search: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
):
    params = PaginationParams(page=page, size=size)
    query = select(Animal).where(Animal.deleted_at == None)

    if species_id:
        query = query.where(Animal.species_id == species_id)
    if owner_id:
        query = query.where(Animal.owner_id == owner_id)
    if region_id:
        query = query.where(Animal.region_id == region_id)
    if status:
        query = query.where(Animal.status == status)
    if search:
        query = query.where(
            or_(
                Animal.identification_no.ilike(f"%{search}%"),
                Animal.microchip_no.ilike(f"%{search}%"),
                Animal.rfid_tag_no.ilike(f"%{search}%"),
            )
        )

    count_result = await db.execute(select(func.count()).select_from(query.subquery()))
    total = count_result.scalar_one()

    result = await db.execute(
        query.offset(params.offset).limit(params.size).order_by(Animal.created_at.desc())
    )
    animals = result.scalars().all()

    return PagedResponse.create(
        items=[AnimalResponse.model_validate(a) for a in animals],
        total=total,
        page=page,
        size=size,
    )


@router.post("", response_model=AnimalResponse, status_code=status.HTTP_201_CREATED)
async def create_animal(
    current_user: CurrentUser,
    data: AnimalCreate,
    db: AsyncSession = Depends(get_db),
):
    # Check for duplicate identification_no
    existing = await db.execute(
        select(Animal).where(Animal.identification_no == data.identification_no)
    )
    if existing.scalar_one_or_none():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Animal with identification_no '{data.identification_no}' already exists",
        )

    animal = Animal(**data.model_dump())
    db.add(animal)
    await db.commit()
    await db.refresh(animal)
    return AnimalResponse.model_validate(animal)


@router.get("/{animal_id}", response_model=AnimalResponse)
async def get_animal(
    current_user: CurrentUser,
    animal_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(Animal).where(Animal.id == animal_id, Animal.deleted_at == None)
    )
    animal = result.scalar_one_or_none()
    if not animal:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Animal not found")
    return AnimalResponse.model_validate(animal)


@router.put("/{animal_id}", response_model=AnimalResponse)
async def update_animal(
    current_user: CurrentUser,
    animal_id: str,
    data: AnimalUpdate,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(Animal).where(Animal.id == animal_id, Animal.deleted_at == None)
    )
    animal = result.scalar_one_or_none()
    if not animal:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Animal not found")

    for field, value in data.model_dump(exclude_none=True).items():
        setattr(animal, field, value)

    await db.commit()
    await db.refresh(animal)
    return AnimalResponse.model_validate(animal)


@router.delete("/{animal_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_animal(
    current_user: CurrentUser,
    animal_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(Animal).where(Animal.id == animal_id, Animal.deleted_at == None)
    )
    animal = result.scalar_one_or_none()
    if not animal:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Animal not found")

    from datetime import datetime, timezone
    animal.deleted_at = datetime.now(timezone.utc).isoformat()
    await db.commit()


@router.get("/{animal_id}/location", response_model=AnimalLocationResponse)
async def get_animal_location(
    current_user: CurrentUser,
    animal_id: str,
    db: AsyncSession = Depends(get_db),
):
    """Get the current GPS location of an animal via its GPS device."""
    result = await db.execute(
        select(GPSDevice).where(
            GPSDevice.animal_id == animal_id,
            GPSDevice.status == "active",
        )
    )
    device = result.scalar_one_or_none()

    if not device:
        return AnimalLocationResponse(
            animal_id=animal_id,
            latitude=None,
            longitude=None,
            last_seen_at=None,
            battery_level=None,
            device_serial=None,
        )

    return AnimalLocationResponse(
        animal_id=animal_id,
        latitude=device.last_latitude,
        longitude=device.last_longitude,
        last_seen_at=device.last_seen_at,
        battery_level=device.battery_level,
        device_serial=device.device_serial,
    )


@router.get("/{animal_id}/track", summary="Get GPS track history for animal")
async def get_animal_track(
    current_user: CurrentUser,
    animal_id: str,
    from_time: Optional[str] = Query(None, description="ISO8601 start timestamp"),
    to_time: Optional[str] = Query(None, description="ISO8601 end timestamp"),
    limit: int = Query(default=500, ge=1, le=5000),
    db: AsyncSession = Depends(get_db),
):
    from app.models.gps import GPSReading
    query = select(GPSReading).where(GPSReading.animal_id == animal_id)
    if from_time:
        query = query.where(GPSReading.time >= from_time)
    if to_time:
        query = query.where(GPSReading.time <= to_time)
    query = query.order_by(GPSReading.time.desc()).limit(limit)

    result = await db.execute(query)
    readings = result.scalars().all()

    return {
        "animal_id": animal_id,
        "count": len(readings),
        "track": [
            {"time": r.time, "lat": r.latitude, "lon": r.longitude,
             "speed": r.speed, "heading": r.heading}
            for r in reversed(readings)
        ],
    }


@router.post("/rfid-lookup", response_model=AnimalResponse, summary="Look up animal by RFID/microchip")
async def rfid_lookup(
    current_user: CurrentUser,
    request: RFIDLookupRequest,
    db: AsyncSession = Depends(get_db),
):
    """Search for animal by RFID tag number or microchip number."""
    result = await db.execute(
        select(Animal).where(
            or_(
                Animal.rfid_tag_no == request.rfid_number,
                Animal.microchip_no == request.rfid_number,
            ),
            Animal.deleted_at == None,
        )
    )
    animal = result.scalar_one_or_none()

    if not animal:
        # TODO: Phase 2 - Query AnimalID.kz and Smart Bridge if not in local DB
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Animal with RFID '{request.rfid_number}' not found in local database",
        )

    return AnimalResponse.model_validate(animal)

from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from pydantic import BaseModel, Field

from app.database import get_db
from app.dependencies import CurrentUser
from app.core.pagination import PaginationParams, PagedResponse
from app.models.owner import Owner
from app.models.animal import Animal

router = APIRouter()


class OwnerCreate(BaseModel):
    iin: str = Field(..., min_length=12, max_length=12)
    full_name_kk: Optional[str] = None
    full_name_ru: str
    phone: Optional[str] = None
    address: Optional[str] = None
    region_id: Optional[int] = None
    farm_name: Optional[str] = None
    farm_latitude: Optional[float] = None
    farm_longitude: Optional[float] = None


class OwnerResponse(BaseModel):
    id: str
    iin: str
    full_name_kk: Optional[str]
    full_name_ru: str
    phone: Optional[str]
    address: Optional[str]
    region_id: Optional[int]
    farm_name: Optional[str]
    farm_latitude: Optional[float]
    farm_longitude: Optional[float]

    model_config = {"from_attributes": True}


@router.get("", response_model=PagedResponse[OwnerResponse])
async def list_owners(
    current_user: CurrentUser,
    page: int = Query(default=1, ge=1),
    size: int = Query(default=20, ge=1, le=100),
    region_id: Optional[int] = None,
    search: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
):
    query = select(Owner)
    if region_id:
        query = query.where(Owner.region_id == region_id)
    if search:
        from sqlalchemy import or_
        query = query.where(
            or_(
                Owner.iin.ilike(f"%{search}%"),
                Owner.full_name_ru.ilike(f"%{search}%"),
            )
        )

    count_result = await db.execute(select(func.count()).select_from(query.subquery()))
    total = count_result.scalar_one()

    params = PaginationParams(page=page, size=size)
    result = await db.execute(query.offset(params.offset).limit(params.size))
    owners = result.scalars().all()

    return PagedResponse.create(
        items=[OwnerResponse.model_validate(o) for o in owners],
        total=total, page=page, size=size,
    )


@router.post("", response_model=OwnerResponse, status_code=status.HTTP_201_CREATED)
async def create_owner(
    current_user: CurrentUser,
    data: OwnerCreate,
    db: AsyncSession = Depends(get_db),
):
    owner = Owner(**data.model_dump())
    db.add(owner)
    await db.commit()
    await db.refresh(owner)
    return OwnerResponse.model_validate(owner)


@router.get("/{owner_id}", response_model=OwnerResponse)
async def get_owner(
    current_user: CurrentUser,
    owner_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(Owner).where(Owner.id == owner_id))
    owner = result.scalar_one_or_none()
    if not owner:
        raise HTTPException(status_code=404, detail="Owner not found")
    return OwnerResponse.model_validate(owner)


@router.get("/{owner_id}/animals", summary="Get all animals for an owner")
async def get_owner_animals(
    current_user: CurrentUser,
    owner_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(Animal).where(Animal.owner_id == owner_id, Animal.deleted_at == None)
    )
    animals = result.scalars().all()
    return {"owner_id": owner_id, "count": len(animals), "animals": [
        {"id": a.id, "identification_no": a.identification_no,
         "species_id": a.species_id, "sex": a.sex, "status": a.status}
        for a in animals
    ]}

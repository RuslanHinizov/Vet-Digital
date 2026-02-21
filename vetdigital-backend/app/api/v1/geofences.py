from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from datetime import datetime, timezone

from app.database import get_db
from app.dependencies import CurrentUser
from app.core.pagination import PaginationParams, PagedResponse
from app.models.geofence import Geofence, GeofenceAnimal, GeofenceAlert
from app.schemas.geofence import GeofenceCreate, GeofenceUpdate, GeofenceResponse, GeofenceAlertResponse

router = APIRouter()


@router.get("", response_model=PagedResponse[GeofenceResponse], summary="List geofences")
async def list_geofences(
    current_user: CurrentUser,
    page: int = Query(default=1, ge=1),
    size: int = Query(default=20, ge=1, le=100),
    owner_id: Optional[str] = None,
    region_id: Optional[int] = None,
    fence_type: Optional[str] = None,
    active_only: bool = True,
    db: AsyncSession = Depends(get_db),
):
    query = select(Geofence)
    if active_only:
        query = query.where(Geofence.is_active == True)
    if owner_id:
        query = query.where(Geofence.owner_id == owner_id)
    if region_id:
        query = query.where(Geofence.region_id == region_id)
    if fence_type:
        query = query.where(Geofence.fence_type == fence_type)

    count_result = await db.execute(select(func.count()).select_from(query.subquery()))
    total = count_result.scalar_one()

    params = PaginationParams(page=page, size=size)
    result = await db.execute(query.offset(params.offset).limit(params.size))
    fences = result.scalars().all()

    return PagedResponse.create(
        items=[GeofenceResponse.model_validate(f) for f in fences],
        total=total, page=page, size=size,
    )


@router.post("", response_model=GeofenceResponse, status_code=status.HTTP_201_CREATED)
async def create_geofence(
    current_user: CurrentUser,
    data: GeofenceCreate,
    db: AsyncSession = Depends(get_db),
):
    # Calculate approximate area from GeoJSON
    import json
    try:
        geojson = json.loads(data.boundary_geojson)
        # Basic validation
        assert geojson.get("type") == "Polygon"
    except Exception:
        raise HTTPException(status_code=422, detail="Invalid GeoJSON polygon")

    fence = Geofence(
        name_kk=data.name_kk,
        name_ru=data.name_ru,
        owner_id=data.owner_id,
        region_id=data.region_id,
        fence_type=data.fence_type,
        description=data.description,
        boundary_geojson=data.boundary_geojson,
        alert_on_exit=data.alert_on_exit,
        alert_on_enter=data.alert_on_enter,
        created_by=current_user.id,
    )
    db.add(fence)
    await db.flush()

    # Associate animals with this geofence
    if data.animal_ids:
        for animal_id in data.animal_ids:
            db.add(GeofenceAnimal(geofence_id=fence.id, animal_id=animal_id))

    await db.commit()
    await db.refresh(fence)
    return GeofenceResponse.model_validate(fence)


@router.get("/{fence_id}", response_model=GeofenceResponse)
async def get_geofence(
    current_user: CurrentUser,
    fence_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(Geofence).where(Geofence.id == fence_id))
    fence = result.scalar_one_or_none()
    if not fence:
        raise HTTPException(status_code=404, detail="Geofence not found")
    return GeofenceResponse.model_validate(fence)


@router.put("/{fence_id}", response_model=GeofenceResponse)
async def update_geofence(
    current_user: CurrentUser,
    fence_id: str,
    data: GeofenceUpdate,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(Geofence).where(Geofence.id == fence_id))
    fence = result.scalar_one_or_none()
    if not fence:
        raise HTTPException(status_code=404, detail="Geofence not found")

    for field, value in data.model_dump(exclude_none=True).items():
        setattr(fence, field, value)

    await db.commit()
    await db.refresh(fence)
    return GeofenceResponse.model_validate(fence)


@router.delete("/{fence_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_geofence(
    current_user: CurrentUser,
    fence_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(Geofence).where(Geofence.id == fence_id))
    fence = result.scalar_one_or_none()
    if not fence:
        raise HTTPException(status_code=404, detail="Geofence not found")
    fence.is_active = False
    await db.commit()


@router.get("/{fence_id}/alerts", response_model=PagedResponse[GeofenceAlertResponse])
async def get_geofence_alerts(
    current_user: CurrentUser,
    fence_id: str,
    page: int = Query(default=1, ge=1),
    size: int = Query(default=20, ge=1, le=100),
    unacknowledged_only: bool = False,
    db: AsyncSession = Depends(get_db),
):
    query = select(GeofenceAlert).where(GeofenceAlert.geofence_id == fence_id)
    if unacknowledged_only:
        query = query.where(GeofenceAlert.acknowledged == False)

    count_result = await db.execute(select(func.count()).select_from(query.subquery()))
    total = count_result.scalar_one()

    params = PaginationParams(page=page, size=size)
    result = await db.execute(
        query.offset(params.offset).limit(params.size).order_by(GeofenceAlert.triggered_at.desc())
    )
    alerts = result.scalars().all()

    return PagedResponse.create(
        items=[GeofenceAlertResponse.model_validate(a) for a in alerts],
        total=total, page=page, size=size,
    )


@router.post("/{fence_id}/alerts/{alert_id}/acknowledge", summary="Acknowledge a geofence alert")
async def acknowledge_alert(
    current_user: CurrentUser,
    fence_id: str,
    alert_id: str,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(
        select(GeofenceAlert).where(
            GeofenceAlert.id == alert_id,
            GeofenceAlert.geofence_id == fence_id,
        )
    )
    alert = result.scalar_one_or_none()
    if not alert:
        raise HTTPException(status_code=404, detail="Alert not found")

    alert.acknowledged = True
    alert.acknowledged_by = current_user.id
    alert.acknowledged_at = datetime.now(timezone.utc).isoformat()
    await db.commit()

    return {"message": "Alert acknowledged", "alert_id": alert_id}

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_
from typing import Optional

from app.database import get_db
from app.dependencies import CurrentUser
from app.models.animal import Animal
from app.models.veterinary import ProcedureAct
from app.models.geofence import GeofenceAlert
from app.models.owner import Owner

router = APIRouter()


@router.get("/overview", summary="Dashboard overview - key metrics")
async def dashboard_overview(
    current_user: CurrentUser,
    region_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db),
):
    # Total animals
    animal_query = select(func.count(Animal.id)).where(Animal.deleted_at == None)
    if region_id:
        animal_query = animal_query.where(Animal.region_id == region_id)
    total_animals = (await db.execute(animal_query)).scalar_one()

    # Animals by status
    status_query = (
        select(Animal.status, func.count(Animal.id))
        .where(Animal.deleted_at == None)
        .group_by(Animal.status)
    )
    if region_id:
        status_query = status_query.where(Animal.region_id == region_id)
    status_rows = (await db.execute(status_query)).all()
    animals_by_status = {row[0]: row[1] for row in status_rows}

    # Total owners
    owner_query = select(func.count(Owner.id))
    if region_id:
        owner_query = owner_query.where(Owner.region_id == region_id)
    total_owners = (await db.execute(owner_query)).scalar_one()

    # Total procedures this month
    from datetime import datetime, timezone
    now = datetime.now(timezone.utc)
    month_start = f"{now.year}-{now.month:02d}-01"
    proc_query = (
        select(func.count(ProcedureAct.id))
        .where(ProcedureAct.act_date >= month_start)
    )
    if region_id:
        proc_query = proc_query.where(ProcedureAct.region_id == region_id)
    procedures_this_month = (await db.execute(proc_query)).scalar_one()

    # Unacknowledged alerts
    alert_count = (
        await db.execute(
            select(func.count(GeofenceAlert.id)).where(GeofenceAlert.acknowledged == False)
        )
    ).scalar_one()

    return {
        "total_animals": total_animals,
        "animals_by_status": animals_by_status,
        "total_owners": total_owners,
        "procedures_this_month": procedures_this_month,
        "unacknowledged_geofence_alerts": alert_count,
    }


@router.get("/vaccination-coverage", summary="Vaccination coverage by region/species")
async def vaccination_coverage(
    current_user: CurrentUser,
    year: int = Query(default=2025),
    region_id: Optional[int] = None,
    species_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db),
):
    query = (
        select(
            ProcedureAct.species_id,
            ProcedureAct.region_id,
            func.sum(ProcedureAct.total_animal_count).label("vaccinated_count"),
        )
        .where(
            and_(
                ProcedureAct.procedure_type == "vaccination",
                ProcedureAct.status == "signed",
                ProcedureAct.act_date >= f"{year}-01-01",
                ProcedureAct.act_date <= f"{year}-12-31",
            )
        )
        .group_by(ProcedureAct.species_id, ProcedureAct.region_id)
    )
    if region_id:
        query = query.where(ProcedureAct.region_id == region_id)
    if species_id:
        query = query.where(ProcedureAct.species_id == species_id)

    rows = (await db.execute(query)).all()
    return {
        "year": year,
        "data": [
            {"species_id": r[0], "region_id": r[1], "vaccinated_count": r[2]}
            for r in rows
        ],
    }


@router.get("/geofence-violations", summary="Recent geofence violations")
async def geofence_violations(
    current_user: CurrentUser,
    limit: int = Query(default=50, ge=1, le=200),
    unacknowledged_only: bool = False,
    db: AsyncSession = Depends(get_db),
):
    query = select(GeofenceAlert).order_by(GeofenceAlert.triggered_at.desc()).limit(limit)
    if unacknowledged_only:
        query = query.where(GeofenceAlert.acknowledged == False)

    result = await db.execute(query)
    alerts = result.scalars().all()

    return {
        "count": len(alerts),
        "alerts": [
            {
                "id": a.id, "geofence_id": a.geofence_id, "animal_id": a.animal_id,
                "alert_type": a.alert_type, "triggered_at": a.triggered_at,
                "lat": a.latitude, "lon": a.longitude, "acknowledged": a.acknowledged,
            }
            for a in alerts
        ],
    }

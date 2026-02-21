"""GPS geofence violation detection tasks."""
from app.tasks.celery_app import celery_app


@celery_app.task(name="app.tasks.gps_tasks.check_geofence_violations")
def check_geofence_violations():
    """
    Periodic task: Check if any animals with GPS devices have exited their geofences.
    Uses Shapely for point-in-polygon calculation (PostGIS in production).
    Runs every 60 seconds via Celery Beat.
    """
    import asyncio
    asyncio.run(_check_violations())


async def _check_violations():
    import json
    from shapely.geometry import Point, shape
    from datetime import datetime, timezone
    from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
    from sqlalchemy import select
    from app.config import settings
    from app.models.gps import GPSDevice
    from app.models.geofence import Geofence, GeofenceAnimal, GeofenceAlert

    engine = create_async_engine(settings.DATABASE_URL)
    async_session = async_sessionmaker(engine, expire_on_commit=False)

    async with async_session() as session:
        # Get all active geofences with exit alerts enabled
        fences_result = await session.execute(
            select(Geofence).where(Geofence.is_active == True, Geofence.alert_on_exit == True)
        )
        geofences = fences_result.scalars().all()

        for fence in geofences:
            # Get animals assigned to this geofence
            ga_result = await session.execute(
                select(GeofenceAnimal).where(GeofenceAnimal.geofence_id == fence.id)
            )
            geofence_animals = ga_result.scalars().all()

            try:
                boundary = shape(json.loads(fence.boundary_geojson))
            except Exception:
                continue

            for ga in geofence_animals:
                # Get latest GPS reading for this animal
                device_result = await session.execute(
                    select(GPSDevice).where(
                        GPSDevice.animal_id == ga.animal_id,
                        GPSDevice.status == "active",
                    )
                )
                device = device_result.scalar_one_or_none()

                if not device or not device.last_latitude or not device.last_longitude:
                    continue

                point = Point(device.last_longitude, device.last_latitude)
                is_inside = boundary.contains(point)

                if not is_inside:
                    # Check if alert already fired recently (within 5 min)
                    from sqlalchemy import and_
                    from datetime import timedelta

                    cutoff = (datetime.now(timezone.utc) - timedelta(minutes=5)).isoformat()
                    recent_alert = await session.execute(
                        select(GeofenceAlert).where(
                            and_(
                                GeofenceAlert.geofence_id == fence.id,
                                GeofenceAlert.animal_id == ga.animal_id,
                                GeofenceAlert.alert_type == "exit",
                                GeofenceAlert.acknowledged == False,
                                GeofenceAlert.triggered_at >= cutoff,
                            )
                        )
                    )
                    if recent_alert.scalar_one_or_none():
                        continue

                    # Create alert
                    alert = GeofenceAlert(
                        geofence_id=fence.id,
                        animal_id=ga.animal_id,
                        device_id=device.id,
                        alert_type="exit",
                        triggered_at=datetime.now(timezone.utc).isoformat(),
                        latitude=device.last_latitude,
                        longitude=device.last_longitude,
                        created_at=datetime.now(timezone.utc).isoformat(),
                    )
                    session.add(alert)

                    # TODO: Send push notification
                    print(f"GEOFENCE VIOLATION: Animal {ga.animal_id} exited fence {fence.id}")

        await session.commit()
    await engine.dispose()

"""
Geofence service — spatial boundary management and alert handling.
Uses Shapely for point-in-polygon checks (PostGIS used in production queries).
"""
import json
import logging
from typing import Optional
from uuid import UUID, uuid4
from datetime import datetime, timezone

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from shapely.geometry import shape, Point

from app.models.geofence import Geofence, GeofenceAlert
from app.core.exceptions import NotFoundError

logger = logging.getLogger(__name__)


class GeofenceService:

    async def get_geofences(
        self,
        db: AsyncSession,
        *,
        page: int = 1,
        page_size: int = 50,
        geofence_type: Optional[str] = None,
        is_active: bool = True,
        region_kato: Optional[str] = None,
        organization_id: Optional[UUID] = None,
    ) -> tuple[list[Geofence], int]:
        q = select(Geofence).where(Geofence.is_active == is_active)

        if geofence_type:
            q = q.where(Geofence.geofence_type == geofence_type)
        if region_kato:
            q = q.where(Geofence.region_kato.startswith(region_kato))
        if organization_id:
            q = q.where(Geofence.owner_org_id == organization_id)

        count_q = select(func.count()).select_from(q.subquery())
        total = (await db.execute(count_q)).scalar_one()

        q = q.offset((page - 1) * page_size).limit(page_size)
        result = await db.execute(q)
        return list(result.scalars().all()), total

    async def get_geofence(self, db: AsyncSession, geofence_id: UUID) -> Geofence:
        result = await db.execute(
            select(Geofence).where(Geofence.id == geofence_id)
        )
        g = result.scalar_one_or_none()
        if not g:
            raise NotFoundError(f"Geofence {geofence_id} not found")
        return g

    async def create_geofence(
        self, db: AsyncSession, data: dict, created_by: UUID
    ) -> Geofence:
        """Create geofence from GeoJSON polygon."""
        geofence = Geofence(
            id=uuid4(),
            created_by=created_by,
            **{k: v for k, v in data.items() if hasattr(Geofence, k)},
        )
        db.add(geofence)
        await db.commit()
        await db.refresh(geofence)
        logger.info(f"Created geofence {geofence.name} ({geofence.id})")
        return geofence

    async def update_geofence(
        self, db: AsyncSession, geofence_id: UUID, data: dict
    ) -> Geofence:
        geofence = await self.get_geofence(db, geofence_id)
        for k, v in data.items():
            if hasattr(geofence, k) and k not in ("id", "created_at"):
                setattr(geofence, k, v)
        await db.commit()
        await db.refresh(geofence)
        return geofence

    async def delete_geofence(self, db: AsyncSession, geofence_id: UUID) -> None:
        geofence = await self.get_geofence(db, geofence_id)
        geofence.is_active = False
        await db.commit()

    async def get_alerts(
        self,
        db: AsyncSession,
        *,
        geofence_id: Optional[UUID] = None,
        acknowledged: Optional[bool] = None,
        limit: int = 50,
    ) -> list[GeofenceAlert]:
        q = select(GeofenceAlert).order_by(GeofenceAlert.detected_at.desc()).limit(limit)
        if geofence_id:
            q = q.where(GeofenceAlert.geofence_id == geofence_id)
        if acknowledged is not None:
            q = q.where(GeofenceAlert.acknowledged == acknowledged)
        result = await db.execute(q)
        return list(result.scalars().all())

    async def acknowledge_alert(
        self, db: AsyncSession, alert_id: UUID, user_id: UUID
    ) -> GeofenceAlert:
        result = await db.execute(
            select(GeofenceAlert).where(GeofenceAlert.id == alert_id)
        )
        alert = result.scalar_one_or_none()
        if not alert:
            raise NotFoundError(f"Alert {alert_id} not found")
        alert.acknowledged = True
        alert.acknowledged_at = datetime.now(timezone.utc)
        alert.acknowledged_by = user_id
        await db.commit()
        await db.refresh(alert)
        return alert

    def is_point_inside(self, geofence: Geofence, lat: float, lng: float) -> bool:
        """Check if a GPS point is inside a geofence polygon using Shapely."""
        try:
            boundary = json.loads(geofence.boundary_geojson)
            polygon = shape(boundary)
            point = Point(lng, lat)  # GeoJSON is (lng, lat)
            return polygon.contains(point)
        except Exception as e:
            logger.warning(f"Geofence check failed for {geofence.id}: {e}")
            return False

    async def create_alert(
        self,
        db: AsyncSession,
        *,
        geofence_id: UUID,
        alert_type: str,
        animal_id: Optional[UUID],
        gps_device_id: UUID,
        latitude: float,
        longitude: float,
    ) -> GeofenceAlert:
        """Create a geofence violation alert."""
        alert = GeofenceAlert(
            id=uuid4(),
            geofence_id=geofence_id,
            alert_type=alert_type,
            animal_id=animal_id,
            gps_device_id=gps_device_id,
            latitude=latitude,
            longitude=longitude,
            detected_at=datetime.now(timezone.utc),
        )
        db.add(alert)
        await db.commit()
        await db.refresh(alert)
        logger.warning(
            f"Geofence alert: {alert_type} for device {gps_device_id} "
            f"at ({latitude:.4f}, {longitude:.4f})"
        )
        return alert


# Singleton
geofence_service = GeofenceService()

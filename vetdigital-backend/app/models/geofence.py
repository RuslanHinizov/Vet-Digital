"""Geofence models for GPS zone boundary management and alerts."""
from typing import Optional
from sqlalchemy import String, Boolean, ForeignKey, Float, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class Geofence(Base, TimestampMixin):
    __tablename__ = "geofences"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    owner_id: Mapped[Optional[str]] = mapped_column(ForeignKey("owners.id"))
    region_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))
    fence_type: Mapped[str] = mapped_column(String(30), nullable=False)
    # fence_type: pasture, farm, quarantine_zone, restricted
    description: Mapped[Optional[str]] = mapped_column(Text)

    # Polygon stored as GeoJSON string (use PostGIS Geometry in production)
    # Format: {"type": "Polygon", "coordinates": [[[lon,lat], ...]]}
    boundary_geojson: Mapped[str] = mapped_column(Text, nullable=False)
    area_sqm: Mapped[Optional[float]] = mapped_column(Float)

    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    alert_on_exit: Mapped[bool] = mapped_column(Boolean, default=True)
    alert_on_enter: Mapped[bool] = mapped_column(Boolean, default=False)
    created_by: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)

    geofence_animals: Mapped[list["GeofenceAnimal"]] = relationship(
        back_populates="geofence", cascade="all, delete-orphan"
    )
    alerts: Mapped[list["GeofenceAlert"]] = relationship(back_populates="geofence")


class GeofenceAnimal(Base):
    __tablename__ = "geofence_animals"

    geofence_id: Mapped[str] = mapped_column(
        ForeignKey("geofences.id", ondelete="CASCADE"), primary_key=True
    )
    animal_id: Mapped[str] = mapped_column(
        ForeignKey("animals.id", ondelete="CASCADE"), primary_key=True
    )

    geofence: Mapped["Geofence"] = relationship(back_populates="geofence_animals")


class GeofenceAlert(Base):
    __tablename__ = "geofence_alerts"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    geofence_id: Mapped[str] = mapped_column(ForeignKey("geofences.id"), nullable=False)
    animal_id: Mapped[str] = mapped_column(String(36), nullable=False)
    device_id: Mapped[Optional[str]] = mapped_column(ForeignKey("gps_devices.id"))
    alert_type: Mapped[str] = mapped_column(String(20), nullable=False)
    # alert_type: exit, enter
    triggered_at: Mapped[str] = mapped_column(String(50), nullable=False)
    latitude: Mapped[float] = mapped_column(Float, nullable=False)
    longitude: Mapped[float] = mapped_column(Float, nullable=False)
    acknowledged: Mapped[bool] = mapped_column(Boolean, default=False)
    acknowledged_by: Mapped[Optional[str]] = mapped_column(ForeignKey("users.id"))
    acknowledged_at: Mapped[Optional[str]] = mapped_column(String(50))
    created_at: Mapped[str] = mapped_column(String(50), nullable=False)

    geofence: Mapped["Geofence"] = relationship(back_populates="alerts")

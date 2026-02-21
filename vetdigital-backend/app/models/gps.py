"""GPS device and telemetry models. gps_readings is designed as a TimescaleDB hypertable."""
from typing import Optional
from sqlalchemy import String, Boolean, ForeignKey, Integer, SmallInteger, Float, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class GPSDevice(Base, TimestampMixin):
    __tablename__ = "gps_devices"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    device_serial: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    device_model: Mapped[Optional[str]] = mapped_column(String(100))
    animal_id: Mapped[Optional[str]] = mapped_column(ForeignKey("animals.id"))
    owner_id: Mapped[Optional[str]] = mapped_column(ForeignKey("owners.id"))
    status: Mapped[str] = mapped_column(String(20), default="active")
    # status: active, inactive, lost, maintenance
    battery_level: Mapped[Optional[int]] = mapped_column(SmallInteger)
    # 0-100
    firmware_ver: Mapped[Optional[str]] = mapped_column(String(50))
    last_seen_at: Mapped[Optional[str]] = mapped_column(String(50))
    last_latitude: Mapped[Optional[float]] = mapped_column(Float)
    last_longitude: Mapped[Optional[float]] = mapped_column(Float)

    readings: Mapped[list["GPSReading"]] = relationship(back_populates="device")


class GPSReading(Base):
    """
    GPS telemetry reading. Designed for TimescaleDB hypertable on 'time' column.
    Each record represents one GPS position fix from an IoT device.
    """
    __tablename__ = "gps_readings"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    time: Mapped[str] = mapped_column(String(50), nullable=False, index=True)
    # ISO8601 timestamp - TimescaleDB hypertable partition key
    device_id: Mapped[str] = mapped_column(ForeignKey("gps_devices.id"), nullable=False)
    animal_id: Mapped[str] = mapped_column(String(36), nullable=False, index=True)
    latitude: Mapped[float] = mapped_column(Float, nullable=False)
    longitude: Mapped[float] = mapped_column(Float, nullable=False)
    altitude: Mapped[Optional[float]] = mapped_column(Float)
    speed: Mapped[Optional[float]] = mapped_column(Float)
    # km/h
    heading: Mapped[Optional[float]] = mapped_column(Float)
    # degrees 0-360
    accuracy: Mapped[Optional[float]] = mapped_column(Float)
    # meters
    battery: Mapped[Optional[int]] = mapped_column(SmallInteger)

    device: Mapped["GPSDevice"] = relationship(back_populates="readings")

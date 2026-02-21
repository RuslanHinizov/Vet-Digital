from typing import Optional, List
from sqlalchemy import String, ForeignKey, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class Owner(Base, TimestampMixin):
    __tablename__ = "owners"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    user_id: Mapped[Optional[str]] = mapped_column(ForeignKey("users.id"))
    # If they have an app account
    iin: Mapped[str] = mapped_column(String(12), nullable=False, index=True)
    full_name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    full_name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    phone: Mapped[Optional[str]] = mapped_column(String(20))
    address: Mapped[Optional[str]] = mapped_column(Text)
    region_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))
    farm_name: Mapped[Optional[str]] = mapped_column(String(255))
    # Farm GPS location stored as lat,lon string (use PostGIS Point in production)
    farm_latitude: Mapped[Optional[float]] = mapped_column()
    farm_longitude: Mapped[Optional[float]] = mapped_column()

    animals: Mapped[List["Animal"]] = relationship(back_populates="owner")

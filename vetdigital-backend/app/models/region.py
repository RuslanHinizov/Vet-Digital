from typing import Optional, List
from sqlalchemy import String, Integer, ForeignKey, SmallInteger
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class Region(Base):
    __tablename__ = "regions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    parent_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))
    name_kk: Mapped[str] = mapped_column(String(255), nullable=False)
    name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    level: Mapped[int] = mapped_column(SmallInteger, nullable=False)
    # level: 1=oblast, 2=rayon, 3=settlement
    kato_code: Mapped[Optional[str]] = mapped_column(String(20), unique=True)
    # PostGIS boundary stored as WKT text (use GeoAlchemy2 in production)
    boundary_wkt: Mapped[Optional[str]] = mapped_column(String)

    parent: Mapped[Optional["Region"]] = relationship(remote_side="Region.id", back_populates="children")
    children: Mapped[List["Region"]] = relationship(back_populates="parent")

from typing import Optional, List
from datetime import date
from sqlalchemy import String, Boolean, ForeignKey, Integer, Text, Date, Numeric
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, SoftDeleteMixin, generate_uuid


class AnimalSpecies(Base):
    __tablename__ = "animal_species"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    name_kk: Mapped[str] = mapped_column(String(100), nullable=False)
    name_ru: Mapped[str] = mapped_column(String(100), nullable=False)
    code: Mapped[str] = mapped_column(String(20), unique=True, nullable=False)
    # code: cattle (IQM/KRS), sheep (usak_mal/MRS), goat, horse, camel, deer, poultry, carnivore, other

    breeds: Mapped[List["AnimalBreed"]] = relationship(back_populates="species")
    animals: Mapped[List["Animal"]] = relationship(back_populates="species")


class AnimalBreed(Base):
    __tablename__ = "animal_breeds"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    species_id: Mapped[int] = mapped_column(ForeignKey("animal_species.id"), nullable=False)
    name_kk: Mapped[Optional[str]] = mapped_column(String(100))
    name_ru: Mapped[str] = mapped_column(String(100), nullable=False)
    code: Mapped[Optional[str]] = mapped_column(String(50))

    species: Mapped["AnimalSpecies"] = relationship(back_populates="breeds")
    animals: Mapped[List["Animal"]] = relationship(back_populates="breed")


class Animal(Base, TimestampMixin, SoftDeleteMixin):
    __tablename__ = "animals"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)

    # Identification
    identification_no: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)
    # National ID from iszh.gov.kz
    microchip_no: Mapped[Optional[str]] = mapped_column(String(15), index=True)
    # 15-digit ISO 11784 TROVAN microchip
    rfid_tag_no: Mapped[Optional[str]] = mapped_column(String(50), index=True)
    # Ear tag RFID number

    # Classification
    species_id: Mapped[int] = mapped_column(ForeignKey("animal_species.id"), nullable=False)
    breed_id: Mapped[Optional[int]] = mapped_column(ForeignKey("animal_breeds.id"))
    sex: Mapped[str] = mapped_column(String(10), nullable=False)
    # sex: male (ertek/samets), female (urgashi/samka)

    # Physical attributes
    birth_date: Mapped[Optional[date]] = mapped_column(Date)
    color_kk: Mapped[Optional[str]] = mapped_column(String(100))
    color_ru: Mapped[Optional[str]] = mapped_column(String(100))
    weight_kg: Mapped[Optional[float]] = mapped_column(Numeric(8, 2))
    photo_url: Mapped[Optional[str]] = mapped_column(String(512))

    # Ownership
    owner_id: Mapped[str] = mapped_column(ForeignKey("owners.id"), nullable=False)
    region_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))

    # Status
    status: Mapped[str] = mapped_column(String(20), default="active")
    # status: active, deceased, sold, lost

    # Sync
    iszh_synced_at: Mapped[Optional[str]] = mapped_column(String(50))

    notes: Mapped[Optional[str]] = mapped_column(Text)

    # Relationships
    species: Mapped["AnimalSpecies"] = relationship(back_populates="animals")
    breed: Mapped[Optional["AnimalBreed"]] = relationship(back_populates="animals")
    owner: Mapped["Owner"] = relationship(back_populates="animals")

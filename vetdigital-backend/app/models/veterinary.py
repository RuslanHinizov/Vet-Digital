"""
Veterinary procedure models based on the 4 Excel templates:
- File 3: Expendable materials list
- File 4: Veterinary procedure act (20+ fields)
- File 5: Animal registry table within an act
- File 6: Owner signature form
"""
from typing import Optional, List
from datetime import date
from sqlalchemy import String, Boolean, ForeignKey, Integer, Text, Date, Numeric, JSON
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class ProcedureAct(Base, TimestampMixin):
    __tablename__ = "procedure_acts"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)

    # Field 1: Act number
    act_number: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)

    # Field 2: Date of procedure
    act_date: Mapped[date] = mapped_column(Date, nullable=False)

    # Field 3: Administrative-territorial unit
    region_id: Mapped[int] = mapped_column(ForeignKey("regions.id"), nullable=False)
    settlement_name: Mapped[Optional[str]] = mapped_column(String(255))

    # Field 4: Veterinary specialist
    veterinarian_id: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)
    vet_position_kk: Mapped[Optional[str]] = mapped_column(String(255))
    vet_position_ru: Mapped[Optional[str]] = mapped_column(String(255))

    # Field 5: Participants (witnesses) - JSON array of {name, position, iin}
    participants_json: Mapped[Optional[dict]] = mapped_column(JSON)

    # Field 6: Animal owner
    owner_id: Mapped[Optional[str]] = mapped_column(ForeignKey("owners.id"))

    # Field 7: Type of veterinary procedure
    procedure_type: Mapped[str] = mapped_column(String(50), nullable=False)
    # procedure_type: vaccination, allergy_test, deworming, treatment, examination

    # Field 8: Disease name
    disease_name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    disease_name_ru: Mapped[Optional[str]] = mapped_column(String(255))

    # Field 9: Animal type (species)
    species_id: Mapped[int] = mapped_column(ForeignKey("animal_species.id"), nullable=False)

    # Field 10: Sex-age group
    sex_age_group_kk: Mapped[Optional[str]] = mapped_column(String(100))
    # e.g. "erkek/samets", "urgashi/samka"
    sex_age_group_ru: Mapped[Optional[str]] = mapped_column(String(100))
    male_count: Mapped[Optional[int]] = mapped_column(Integer)
    female_count: Mapped[Optional[int]] = mapped_column(Integer)

    # Field 11: Total animals vaccinated/tested/treated
    total_animal_count: Mapped[int] = mapped_column(Integer, nullable=False, default=0)

    # Fields 12-18: Vaccine / medication data
    vaccine_name: Mapped[Optional[str]] = mapped_column(String(255))
    # Field 13: Vaccine/allergen name
    manufacturer: Mapped[Optional[str]] = mapped_column(String(255))
    # Field 14: Manufacturer name
    production_date: Mapped[Optional[date]] = mapped_column(Date)
    # Field 15: Production date
    series_number: Mapped[Optional[str]] = mapped_column(String(100))
    # Field 16: Series number
    state_control_no: Mapped[Optional[str]] = mapped_column(String(100))
    # Field 17: State control number and date
    state_control_date: Mapped[Optional[date]] = mapped_column(Date)
    injection_method: Mapped[Optional[str]] = mapped_column(String(50))
    # Field 18: Injection method and location (subcutaneous, intramuscular, oral, etc.)
    injection_location: Mapped[Optional[str]] = mapped_column(String(100))

    # Fields 19-20: Dose information
    dose_adult_ml: Mapped[Optional[float]] = mapped_column(Numeric(8, 2))
    # Field 19: Dose per adult animal (ml)
    dose_young_ml: Mapped[Optional[float]] = mapped_column(Numeric(8, 2))
    # Field 20: Dose per young animal (ml)

    # Expendable materials used (from File 3 template)
    # JSON array: [{name_kk, name_ru, quantity, unit}]
    materials_json: Mapped[Optional[list]] = mapped_column(JSON)

    # Document status
    status: Mapped[str] = mapped_column(String(20), default="draft")
    # status: draft, pending_sign, signed, cancelled
    signed_at: Mapped[Optional[str]] = mapped_column(String(50))
    signed_document_url: Mapped[Optional[str]] = mapped_column(String(512))

    # Offline sync tracking
    offline_created: Mapped[bool] = mapped_column(Boolean, default=False)
    synced_at: Mapped[Optional[str]] = mapped_column(String(50))

    # Relationships
    act_animals: Mapped[List["ProcedureActAnimal"]] = relationship(
        back_populates="procedure_act", cascade="all, delete-orphan"
    )
    owner_consents: Mapped[List["OwnerConsent"]] = relationship(back_populates="procedure_act")


class ProcedureActAnimal(Base):
    """
    Individual animal record within a procedure act.
    Corresponds to each row in the animal registry table (File 5 template).
    """
    __tablename__ = "procedure_act_animals"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    procedure_act_id: Mapped[str] = mapped_column(
        ForeignKey("procedure_acts.id", ondelete="CASCADE"), nullable=False
    )
    animal_id: Mapped[str] = mapped_column(ForeignKey("animals.id"), nullable=False)
    owner_id: Mapped[str] = mapped_column(ForeignKey("owners.id"), nullable=False)

    # Column: Identification number
    identification_no: Mapped[Optional[str]] = mapped_column(String(50))

    # Columns: Animal type, sex
    species_name_kk: Mapped[Optional[str]] = mapped_column(String(100))
    species_name_ru: Mapped[Optional[str]] = mapped_column(String(100))
    sex: Mapped[Optional[str]] = mapped_column(String(10))

    # Column: Age
    age_description: Mapped[Optional[str]] = mapped_column(String(50))

    # Column: Color
    color_kk: Mapped[Optional[str]] = mapped_column(String(100))
    color_ru: Mapped[Optional[str]] = mapped_column(String(100))

    # Column: Vaccination date / allergen injection date
    vaccination_date: Mapped[Optional[date]] = mapped_column(Date)

    # Allergy test specific columns (from File 5)
    allergy_skin_measurement_mm: Mapped[Optional[float]] = mapped_column(Numeric(5, 2))
    # Column: Skin thickness at injection site (mm)
    allergy_result_reading_date: Mapped[Optional[date]] = mapped_column(Date)
    allergy_result_mm: Mapped[Optional[float]] = mapped_column(Numeric(5, 2))
    allergy_difference_mm: Mapped[Optional[float]] = mapped_column(Numeric(5, 2))
    allergy_result: Mapped[Optional[str]] = mapped_column(String(20))
    # allergy_result: positive, negative, doubtful

    notes: Mapped[Optional[str]] = mapped_column(Text)
    sort_order: Mapped[int] = mapped_column(Integer, default=0)

    procedure_act: Mapped["ProcedureAct"] = relationship(back_populates="act_animals")

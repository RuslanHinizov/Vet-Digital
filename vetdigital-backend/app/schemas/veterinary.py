"""Schemas for veterinary procedure acts (matching the 4 Excel templates)."""
from typing import Optional, List
from datetime import date
from pydantic import BaseModel, Field


class MaterialItem(BaseModel):
    """Expendable material item (File 3 template)."""
    name_kk: Optional[str] = None
    name_ru: str
    quantity: Optional[float] = None
    unit: Optional[str] = None
    series: Optional[str] = None


class Participant(BaseModel):
    """Witness/participant in a procedure act."""
    full_name_ru: str
    full_name_kk: Optional[str] = None
    position_ru: Optional[str] = None
    iin: Optional[str] = None


class ProcedureActAnimalCreate(BaseModel):
    """One animal row in the animal registry table (File 5 template)."""
    animal_id: str
    owner_id: str
    identification_no: Optional[str] = None
    sex: Optional[str] = None
    age_description: Optional[str] = None
    color_kk: Optional[str] = None
    color_ru: Optional[str] = None
    vaccination_date: Optional[date] = None
    # Allergy test fields
    allergy_skin_measurement_mm: Optional[float] = None
    allergy_result_reading_date: Optional[date] = None
    allergy_result_mm: Optional[float] = None
    allergy_difference_mm: Optional[float] = None
    allergy_result: Optional[str] = Field(None, pattern="^(positive|negative|doubtful)$")
    notes: Optional[str] = None
    sort_order: int = 0


class ProcedureActCreate(BaseModel):
    """Create a new procedure act (File 4 template - all 20 fields)."""
    act_number: str = Field(..., description="Act number - Field 1")
    act_date: date = Field(..., description="Date of procedure - Field 2")
    region_id: int = Field(..., description="Administrative region - Field 3")
    settlement_name: Optional[str] = Field(None, description="Settlement name - Field 3")

    # Field 4: Veterinary specialist (auto-filled from current user)
    vet_position_kk: Optional[str] = None
    vet_position_ru: Optional[str] = None

    # Field 5: Participants
    participants: Optional[List[Participant]] = Field(None, description="Witnesses - Field 5")

    # Field 6: Owner
    owner_id: Optional[str] = Field(None, description="Animal owner - Field 6")

    # Field 7: Procedure type
    procedure_type: str = Field(..., description="vaccination/allergy_test/deworming/treatment - Field 7")

    # Field 8: Disease name
    disease_name_kk: Optional[str] = Field(None, description="Disease name in Kazakh - Field 8")
    disease_name_ru: Optional[str] = Field(None, description="Disease name in Russian - Field 8")

    # Field 9: Animal species
    species_id: int = Field(..., description="Animal species - Field 9")

    # Field 10: Sex-age group
    sex_age_group_kk: Optional[str] = Field(None, description="Sex-age group Kazakh - Field 10")
    sex_age_group_ru: Optional[str] = Field(None, description="Sex-age group Russian - Field 10")
    male_count: Optional[int] = Field(None, description="Male count - Field 10")
    female_count: Optional[int] = Field(None, description="Female count - Field 10")

    # Field 11: Total vaccinated
    total_animal_count: int = Field(..., ge=0, description="Total animals - Field 11")

    # Fields 12-18: Vaccine data
    vaccine_name: Optional[str] = Field(None, description="Vaccine/allergen name - Field 13")
    manufacturer: Optional[str] = Field(None, description="Manufacturer - Field 14")
    production_date: Optional[date] = Field(None, description="Production date - Field 15")
    series_number: Optional[str] = Field(None, description="Series number - Field 16")
    state_control_no: Optional[str] = Field(None, description="State control number - Field 17")
    state_control_date: Optional[date] = None
    injection_method: Optional[str] = Field(None, description="Injection method - Field 18")
    injection_location: Optional[str] = None

    # Fields 19-20: Doses
    dose_adult_ml: Optional[float] = Field(None, description="Adult dose ml - Field 19")
    dose_young_ml: Optional[float] = Field(None, description="Young animal dose ml - Field 20")

    # Expendable materials (File 3)
    materials: Optional[List[MaterialItem]] = None

    # Animals in this act (File 5)
    act_animals: Optional[List[ProcedureActAnimalCreate]] = None


class ProcedureActResponse(BaseModel):
    id: str
    act_number: str
    act_date: date
    region_id: int
    settlement_name: Optional[str]
    veterinarian_id: str
    procedure_type: str
    disease_name_kk: Optional[str]
    disease_name_ru: Optional[str]
    species_id: int
    total_animal_count: int
    vaccine_name: Optional[str]
    manufacturer: Optional[str]
    production_date: Optional[date]
    series_number: Optional[str]
    dose_adult_ml: Optional[float]
    dose_young_ml: Optional[float]
    status: str
    signed_at: Optional[str]
    signed_document_url: Optional[str]
    created_at: str

    model_config = {"from_attributes": True}


class SignDocumentRequest(BaseModel):
    signature_data: str = Field(..., description="CMS/XML EDS signature blob")
    certificate_sn: Optional[str] = None
    signer_name: str

from typing import Optional
from datetime import date
from pydantic import BaseModel, Field


class AnimalBase(BaseModel):
    identification_no: str = Field(..., description="National ID from iszh.gov.kz")
    microchip_no: Optional[str] = Field(None, max_length=15, description="15-digit ISO 11784")
    rfid_tag_no: Optional[str] = Field(None, description="Ear tag RFID number")
    species_id: int
    breed_id: Optional[int] = None
    sex: str = Field(..., pattern="^(male|female)$")
    birth_date: Optional[date] = None
    color_kk: Optional[str] = None
    color_ru: Optional[str] = None
    weight_kg: Optional[float] = None
    owner_id: str
    region_id: Optional[int] = None
    notes: Optional[str] = None


class AnimalCreate(AnimalBase):
    pass


class AnimalUpdate(BaseModel):
    microchip_no: Optional[str] = None
    rfid_tag_no: Optional[str] = None
    breed_id: Optional[int] = None
    birth_date: Optional[date] = None
    color_kk: Optional[str] = None
    color_ru: Optional[str] = None
    weight_kg: Optional[float] = None
    status: Optional[str] = None
    notes: Optional[str] = None


class AnimalResponse(BaseModel):
    id: str
    identification_no: str
    microchip_no: Optional[str]
    rfid_tag_no: Optional[str]
    species_id: int
    breed_id: Optional[int]
    sex: str
    birth_date: Optional[date]
    color_kk: Optional[str]
    color_ru: Optional[str]
    weight_kg: Optional[float]
    owner_id: str
    region_id: Optional[int]
    status: str
    photo_url: Optional[str]
    notes: Optional[str]
    created_at: str

    model_config = {"from_attributes": True}


class RFIDLookupRequest(BaseModel):
    rfid_number: str
    # Can be microchip_no or rfid_tag_no


class AnimalLocationResponse(BaseModel):
    animal_id: str
    latitude: Optional[float]
    longitude: Optional[float]
    last_seen_at: Optional[str]
    battery_level: Optional[int]
    device_serial: Optional[str]

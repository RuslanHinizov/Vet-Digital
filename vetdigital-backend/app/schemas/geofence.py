from typing import Optional, List, Any
from pydantic import BaseModel, Field


class GeofenceCreate(BaseModel):
    name_kk: Optional[str] = None
    name_ru: str = Field(..., description="Geofence name in Russian")
    owner_id: Optional[str] = None
    region_id: Optional[int] = None
    fence_type: str = Field(..., description="pasture/farm/quarantine_zone/restricted")
    description: Optional[str] = None
    boundary_geojson: str = Field(
        ..., description='GeoJSON Polygon: {"type":"Polygon","coordinates":[[[lon,lat],...]]}'
    )
    alert_on_exit: bool = True
    alert_on_enter: bool = False
    animal_ids: Optional[List[str]] = None


class GeofenceUpdate(BaseModel):
    name_kk: Optional[str] = None
    name_ru: Optional[str] = None
    description: Optional[str] = None
    boundary_geojson: Optional[str] = None
    fence_type: Optional[str] = None
    alert_on_exit: Optional[bool] = None
    alert_on_enter: Optional[bool] = None
    is_active: Optional[bool] = None


class GeofenceResponse(BaseModel):
    id: str
    name_kk: Optional[str]
    name_ru: str
    owner_id: Optional[str]
    region_id: Optional[int]
    fence_type: str
    boundary_geojson: str
    area_sqm: Optional[float]
    is_active: bool
    alert_on_exit: bool
    alert_on_enter: bool
    created_by: str
    created_at: str

    model_config = {"from_attributes": True}


class GeofenceAlertResponse(BaseModel):
    id: str
    geofence_id: str
    animal_id: str
    device_id: Optional[str]
    alert_type: str
    triggered_at: str
    latitude: float
    longitude: float
    acknowledged: bool
    acknowledged_by: Optional[str]
    acknowledged_at: Optional[str]

    model_config = {"from_attributes": True}

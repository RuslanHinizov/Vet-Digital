from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query, WebSocket, WebSocketDisconnect, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from pydantic import BaseModel

from app.database import get_db
from app.dependencies import CurrentUser
from app.models.gps import GPSDevice, GPSReading

router = APIRouter()


class GPSDeviceCreate(BaseModel):
    device_serial: str
    device_model: Optional[str] = None
    animal_id: Optional[str] = None
    owner_id: Optional[str] = None


class GPSDeviceResponse(BaseModel):
    id: str
    device_serial: str
    device_model: Optional[str]
    animal_id: Optional[str]
    owner_id: Optional[str]
    status: str
    battery_level: Optional[int]
    last_latitude: Optional[float]
    last_longitude: Optional[float]
    last_seen_at: Optional[str]

    model_config = {"from_attributes": True}


@router.get("/devices", summary="List GPS devices")
async def list_gps_devices(
    current_user: CurrentUser,
    animal_id: Optional[str] = None,
    owner_id: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
):
    query = select(GPSDevice)
    if animal_id:
        query = query.where(GPSDevice.animal_id == animal_id)
    if owner_id:
        query = query.where(GPSDevice.owner_id == owner_id)

    result = await db.execute(query)
    devices = result.scalars().all()
    return {"count": len(devices), "devices": [GPSDeviceResponse.model_validate(d) for d in devices]}


@router.post("/devices", response_model=GPSDeviceResponse, status_code=status.HTTP_201_CREATED)
async def register_gps_device(
    current_user: CurrentUser,
    data: GPSDeviceCreate,
    db: AsyncSession = Depends(get_db),
):
    existing = await db.execute(
        select(GPSDevice).where(GPSDevice.device_serial == data.device_serial)
    )
    if existing.scalar_one_or_none():
        raise HTTPException(status_code=409, detail="Device already registered")

    device = GPSDevice(**data.model_dump())
    db.add(device)
    await db.commit()
    await db.refresh(device)
    return GPSDeviceResponse.model_validate(device)


@router.get("/devices/{device_id}/readings", summary="Get historical GPS readings")
async def get_device_readings(
    current_user: CurrentUser,
    device_id: str,
    from_time: Optional[str] = Query(None),
    to_time: Optional[str] = Query(None),
    limit: int = Query(default=200, ge=1, le=2000),
    db: AsyncSession = Depends(get_db),
):
    query = select(GPSReading).where(GPSReading.device_id == device_id)
    if from_time:
        query = query.where(GPSReading.time >= from_time)
    if to_time:
        query = query.where(GPSReading.time <= to_time)
    query = query.order_by(GPSReading.time.desc()).limit(limit)

    result = await db.execute(query)
    readings = result.scalars().all()

    return {
        "device_id": device_id,
        "count": len(readings),
        "readings": [
            {"time": r.time, "lat": r.latitude, "lon": r.longitude,
             "speed": r.speed, "battery": r.battery, "accuracy": r.accuracy}
            for r in reversed(readings)
        ],
    }


# WebSocket connection manager for live GPS streaming
class LiveGPSManager:
    def __init__(self):
        self.connections: dict[str, WebSocket] = {}

    async def connect(self, websocket: WebSocket, user_id: str):
        await websocket.accept()
        self.connections[user_id] = websocket

    def disconnect(self, user_id: str):
        self.connections.pop(user_id, None)

    async def broadcast_position(self, animal_id: str, lat: float, lon: float, timestamp: str):
        """Called by the MQTT worker when a new GPS reading arrives."""
        message = {"animal_id": animal_id, "lat": lat, "lon": lon, "time": timestamp}
        disconnected = []
        for user_id, ws in self.connections.items():
            try:
                await ws.send_json(message)
            except Exception:
                disconnected.append(user_id)
        for uid in disconnected:
            self.disconnect(uid)


live_manager = LiveGPSManager()


@router.websocket("/live")
async def live_gps_websocket(websocket: WebSocket):
    """WebSocket endpoint for real-time animal GPS positions."""
    # TODO: Phase 4 - Add JWT authentication for WebSocket
    user_id = websocket.query_params.get("user_id", "anonymous")
    await live_manager.connect(websocket, user_id)
    try:
        while True:
            # Keep connection alive, receive pings
            data = await websocket.receive_text()
            if data == "ping":
                await websocket.send_text("pong")
    except WebSocketDisconnect:
        live_manager.disconnect(user_id)

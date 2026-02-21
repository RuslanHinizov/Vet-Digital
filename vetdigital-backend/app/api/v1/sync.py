"""Offline sync endpoints for mobile app data synchronization."""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from pydantic import BaseModel
from datetime import datetime, timezone

from app.database import get_db
from app.dependencies import CurrentUser
from app.models.sync import SyncLog

router = APIRouter()


class SyncItem(BaseModel):
    entity_type: str
    entity_id: str
    operation: str  # create, update, delete
    payload: dict
    client_timestamp: str


class SyncPushRequest(BaseModel):
    device_id: str
    items: List[SyncItem]


class SyncPushResponse(BaseModel):
    accepted: int
    failed: int
    conflicts: List[str]


@router.post("/push", response_model=SyncPushResponse, summary="Upload offline changes to server")
async def sync_push(
    current_user: CurrentUser,
    request: SyncPushRequest,
    db: AsyncSession = Depends(get_db),
):
    """
    Mobile app sends all offline changes (create/update/delete operations).
    Server processes them and returns conflict info.
    """
    accepted = 0
    failed = 0
    conflicts = []

    for item in request.items:
        try:
            # Log the sync operation
            log = SyncLog(
                user_id=current_user.id,
                device_id=request.device_id,
                entity_type=item.entity_type,
                entity_id=item.entity_id,
                operation=item.operation,
                payload=item.payload,
                client_timestamp=item.client_timestamp,
                server_timestamp=datetime.now(timezone.utc).isoformat(),
            )
            db.add(log)

            # TODO: Phase 6 - Process each entity type properly
            # For now just log and accept
            accepted += 1
        except Exception as e:
            failed += 1

    await db.commit()
    return SyncPushResponse(accepted=accepted, failed=failed, conflicts=conflicts)


@router.get("/pull", summary="Download server changes since last sync")
async def sync_pull(
    current_user: CurrentUser,
    since: Optional[str] = None,
    entity_types: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
):
    """
    Returns all changes made on the server since the given timestamp.
    Mobile app uses this to update its local Drift database.
    """
    # TODO: Phase 6 - Full implementation with per-entity-type change tracking
    return {
        "since": since,
        "server_time": datetime.now(timezone.utc).isoformat(),
        "changes": [],
        "message": "Full offline sync available in Phase 6",
    }


@router.get("/status", summary="Check sync health")
async def sync_status(current_user: CurrentUser):
    return {
        "status": "ok",
        "server_time": datetime.now(timezone.utc).isoformat(),
    }

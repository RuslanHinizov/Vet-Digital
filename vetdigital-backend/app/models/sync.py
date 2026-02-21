from typing import Optional
from sqlalchemy import String, Boolean, ForeignKey, JSON
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, generate_uuid


class SyncLog(Base):
    __tablename__ = "sync_log"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)
    device_id: Mapped[str] = mapped_column(String(255), nullable=False)
    entity_type: Mapped[str] = mapped_column(String(50), nullable=False)
    # entity_type: animal, procedure_act, owner, geofence
    entity_id: Mapped[str] = mapped_column(String(36), nullable=False)
    operation: Mapped[str] = mapped_column(String(10), nullable=False)
    # operation: create, update, delete
    payload: Mapped[dict] = mapped_column(JSON, nullable=False)
    client_timestamp: Mapped[str] = mapped_column(String(50), nullable=False)
    server_timestamp: Mapped[str] = mapped_column(String(50), nullable=False)
    conflict_resolved: Mapped[bool] = mapped_column(Boolean, default=False)
    resolution_strategy: Mapped[Optional[str]] = mapped_column(String(20))
    # resolution_strategy: server_wins, client_wins, merged

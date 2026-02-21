from typing import Optional
from sqlalchemy import String, Boolean, ForeignKey, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, generate_uuid


class Notification(Base):
    __tablename__ = "notifications"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)
    title_kk: Mapped[Optional[str]] = mapped_column(String(255))
    title_ru: Mapped[Optional[str]] = mapped_column(String(255))
    body_kk: Mapped[Optional[str]] = mapped_column(Text)
    body_ru: Mapped[Optional[str]] = mapped_column(Text)
    notification_type: Mapped[str] = mapped_column(String(50), nullable=False)
    # notification_type: geofence_alert, sync_complete, vaccination_reminder, document_signed
    reference_type: Mapped[Optional[str]] = mapped_column(String(50))
    reference_id: Mapped[Optional[str]] = mapped_column(String(36))
    is_read: Mapped[bool] = mapped_column(Boolean, default=False)
    sent_at: Mapped[str] = mapped_column(String(50), nullable=False)

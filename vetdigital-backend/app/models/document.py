"""
Digital signature and owner consent models.
Corresponds to File 6 template (owner signature form).
"""
from typing import Optional
from sqlalchemy import String, Boolean, ForeignKey, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class DigitalSignature(Base):
    __tablename__ = "digital_signatures"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    document_type: Mapped[str] = mapped_column(String(50), nullable=False)
    # document_type: procedure_act, owner_consent, lab_result
    document_id: Mapped[str] = mapped_column(String(36), nullable=False, index=True)

    signer_id: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)
    signer_iin: Mapped[str] = mapped_column(String(12), nullable=False)
    signer_name: Mapped[str] = mapped_column(String(255), nullable=False)

    signature_data: Mapped[str] = mapped_column(Text, nullable=False)
    # CMS/XML EDS signature blob
    certificate_sn: Mapped[Optional[str]] = mapped_column(String(255))
    signed_at: Mapped[str] = mapped_column(String(50), nullable=False)
    is_valid: Mapped[bool] = mapped_column(Boolean, default=True)


class OwnerConsent(Base, TimestampMixin):
    """
    Owner consent record for veterinary procedures.
    Corresponds to File 6 template - owner signature form.
    """
    __tablename__ = "owner_consents"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    procedure_act_id: Mapped[str] = mapped_column(ForeignKey("procedure_acts.id"), nullable=False)
    owner_id: Mapped[str] = mapped_column(ForeignKey("owners.id"), nullable=False)

    # Owner info for consent document
    owner_full_name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    owner_full_name_ru: Mapped[Optional[str]] = mapped_column(String(255))
    animal_count: Mapped[Optional[int]] = mapped_column()

    consent_text_kk: Mapped[Optional[str]] = mapped_column(Text)
    consent_text_ru: Mapped[Optional[str]] = mapped_column(Text)

    # EDS signature or drawn signature base64
    signature_data: Mapped[Optional[str]] = mapped_column(Text)
    signed_at: Mapped[Optional[str]] = mapped_column(String(50))

    procedure_act: Mapped["ProcedureAct"] = relationship(back_populates="owner_consents")

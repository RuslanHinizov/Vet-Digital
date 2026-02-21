"""Inventory management for veterinary expendable materials (File 3 template)."""
from typing import Optional
from datetime import date
from sqlalchemy import String, Boolean, ForeignKey, Integer, Text, Date, Numeric
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class InventoryItem(Base, TimestampMixin):
    __tablename__ = "inventory_items"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    category: Mapped[str] = mapped_column(String(50), nullable=False)
    # category: vaccine, syringe, needle, cotton, alcohol, other
    # Matches items from File 3: шприцтер, инелер, мақта, 70% спирт, вакцина/аллерген
    unit: Mapped[str] = mapped_column(String(20), nullable=False)
    # unit: dose, piece, ml, gram, pack
    current_stock: Mapped[float] = mapped_column(Numeric(10, 2), default=0)
    min_stock_alert: Mapped[Optional[float]] = mapped_column(Numeric(10, 2))
    organization_id: Mapped[str] = mapped_column(ForeignKey("organizations.id"), nullable=False)
    manufacturer: Mapped[Optional[str]] = mapped_column(String(255))
    batch_number: Mapped[Optional[str]] = mapped_column(String(100))
    expiry_date: Mapped[Optional[date]] = mapped_column(Date)
    state_control_no: Mapped[Optional[str]] = mapped_column(String(100))

    transactions: Mapped[list["InventoryTransaction"]] = relationship(back_populates="item")


class InventoryTransaction(Base):
    __tablename__ = "inventory_transactions"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    item_id: Mapped[str] = mapped_column(ForeignKey("inventory_items.id"), nullable=False)
    transaction_type: Mapped[str] = mapped_column(String(20), nullable=False)
    # transaction_type: receipt, consumption, adjustment, disposal
    quantity: Mapped[float] = mapped_column(Numeric(10, 2), nullable=False)
    procedure_act_id: Mapped[Optional[str]] = mapped_column(ForeignKey("procedure_acts.id"))
    performed_by: Mapped[str] = mapped_column(ForeignKey("users.id"), nullable=False)
    notes: Mapped[Optional[str]] = mapped_column(Text)
    created_at: Mapped[str] = mapped_column(String(50), nullable=False)

    item: Mapped["InventoryItem"] = relationship(back_populates="transactions")

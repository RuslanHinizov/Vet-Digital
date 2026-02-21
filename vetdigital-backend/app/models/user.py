from typing import Optional, List
from sqlalchemy import String, Boolean, ForeignKey, Integer, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin, generate_uuid


class Permission(Base):
    __tablename__ = "permissions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    codename: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    description: Mapped[Optional[str]] = mapped_column(String(255))

    role_permissions: Mapped[List["RolePermission"]] = relationship(back_populates="permission")


class Role(Base):
    __tablename__ = "roles"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    name: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)
    description_kk: Mapped[Optional[str]] = mapped_column(Text)
    description_ru: Mapped[Optional[str]] = mapped_column(Text)

    role_permissions: Mapped[List["RolePermission"]] = relationship(back_populates="role")
    users: Mapped[List["User"]] = relationship(back_populates="role")


class RolePermission(Base):
    __tablename__ = "role_permissions"

    role_id: Mapped[int] = mapped_column(ForeignKey("roles.id"), primary_key=True)
    permission_id: Mapped[int] = mapped_column(ForeignKey("permissions.id"), primary_key=True)

    role: Mapped["Role"] = relationship(back_populates="role_permissions")
    permission: Mapped["Permission"] = relationship(back_populates="role_permissions")


class Organization(Base, TimestampMixin):
    __tablename__ = "organizations"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    bin: Mapped[str] = mapped_column(String(12), unique=True, nullable=False)
    name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    org_type: Mapped[str] = mapped_column(String(50), nullable=False)
    # org_type: vet_clinic, farm, lab, supplier, gov_agency
    region_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))
    address: Mapped[Optional[str]] = mapped_column(Text)
    phone: Mapped[Optional[str]] = mapped_column(String(20))
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)

    users: Mapped[List["User"]] = relationship(back_populates="organization")


class User(Base, TimestampMixin):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    iin: Mapped[str] = mapped_column(String(12), unique=True, nullable=False)
    email: Mapped[Optional[str]] = mapped_column(String(255))
    phone: Mapped[Optional[str]] = mapped_column(String(20))
    full_name_kk: Mapped[Optional[str]] = mapped_column(String(255))
    full_name_ru: Mapped[str] = mapped_column(String(255), nullable=False)
    role_id: Mapped[int] = mapped_column(ForeignKey("roles.id"), nullable=False)
    organization_id: Mapped[Optional[str]] = mapped_column(ForeignKey("organizations.id"))
    region_id: Mapped[Optional[int]] = mapped_column(ForeignKey("regions.id"))
    password_hash: Mapped[Optional[str]] = mapped_column(String(255))
    eds_cert_serial: Mapped[Optional[str]] = mapped_column(String(255))
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    language_pref: Mapped[str] = mapped_column(String(2), default="ru")
    # language_pref: kk, ru, en
    fcm_token: Mapped[Optional[str]] = mapped_column(String(512))

    role: Mapped["Role"] = relationship(back_populates="users")
    organization: Mapped[Optional["Organization"]] = relationship(back_populates="users")

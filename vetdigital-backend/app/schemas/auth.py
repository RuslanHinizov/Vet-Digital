from typing import Optional
from pydantic import BaseModel, field_validator
from app.core.security import validate_iin


class LoginRequest(BaseModel):
    iin: str
    password: str

    @field_validator("iin")
    @classmethod
    def validate_iin_format(cls, v: str) -> str:
        if not validate_iin(v):
            raise ValueError("Invalid IIN format")
        return v


class EDSLoginRequest(BaseModel):
    signature: str
    # CMS signature of a challenge token, signed with EDS certificate


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int
    # seconds until access token expiry
    user_id: str
    role: str
    language: str


class RefreshRequest(BaseModel):
    refresh_token: str


class ChangePasswordRequest(BaseModel):
    current_password: str
    new_password: str

    @field_validator("new_password")
    @classmethod
    def validate_password_strength(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError("Password must be at least 8 characters")
        return v

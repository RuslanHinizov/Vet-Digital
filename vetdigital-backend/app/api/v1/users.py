from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from pydantic import BaseModel, Field

from app.database import get_db
from app.dependencies import CurrentUser
from app.core.security import hash_password
from app.models.user import User

router = APIRouter()


class UserResponse(BaseModel):
    id: str
    iin: str
    email: Optional[str]
    phone: Optional[str]
    full_name_kk: Optional[str]
    full_name_ru: str
    role_id: int
    organization_id: Optional[str]
    region_id: Optional[int]
    is_active: bool
    language_pref: str

    model_config = {"from_attributes": True}


class UserCreate(BaseModel):
    iin: str = Field(..., min_length=12, max_length=12)
    full_name_ru: str
    full_name_kk: Optional[str] = None
    password: str = Field(..., min_length=8)
    role_id: int
    organization_id: Optional[str] = None
    region_id: Optional[int] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    language_pref: str = "ru"


class UpdateFCMToken(BaseModel):
    fcm_token: str


@router.get("/me", response_model=UserResponse, summary="Get current user profile")
async def get_me(current_user: CurrentUser):
    return UserResponse.model_validate(current_user)


@router.put("/me/fcm-token", summary="Update FCM push notification token")
async def update_fcm_token(
    current_user: CurrentUser,
    request: UpdateFCMToken,
    db: AsyncSession = Depends(get_db),
):
    current_user.fcm_token = request.fcm_token
    await db.commit()
    return {"message": "FCM token updated"}


@router.put("/me/language", summary="Update preferred language")
async def update_language(
    current_user: CurrentUser,
    lang: str,
    db: AsyncSession = Depends(get_db),
):
    if lang not in ("kk", "ru", "en"):
        raise HTTPException(status_code=422, detail="Language must be kk, ru, or en")
    current_user.language_pref = lang
    await db.commit()
    return {"message": "Language updated", "language": lang}


@router.post("", response_model=UserResponse, status_code=status.HTTP_201_CREATED,
             summary="Create a new user (admin only)")
async def create_user(
    current_user: CurrentUser,
    data: UserCreate,
    db: AsyncSession = Depends(get_db),
):
    # TODO: Check admin role
    existing = await db.execute(select(User).where(User.iin == data.iin))
    if existing.scalar_one_or_none():
        raise HTTPException(status_code=409, detail=f"User with IIN '{data.iin}' already exists")

    user_data = data.model_dump(exclude={"password"})
    user_data["password_hash"] = hash_password(data.password)
    user = User(**user_data)
    db.add(user)
    await db.commit()
    await db.refresh(user)
    return UserResponse.model_validate(user)

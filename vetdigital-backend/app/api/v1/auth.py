from datetime import timedelta
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import selectinload

from app.database import get_db
from app.schemas.auth import LoginRequest, TokenResponse, RefreshRequest, EDSLoginRequest
from app.models.user import User, Role
from app.core.security import (
    verify_password,
    create_access_token,
    create_refresh_token,
    decode_token,
)
from app.config import settings

router = APIRouter()


def _build_token_payload(user: User, role_name: str) -> dict:
    return {
        "sub": user.id,
        "iin": user.iin,
        "role": role_name,
        "org_id": user.organization_id,
        "region_id": user.region_id,
        "lang": user.language_pref,
    }


@router.post("/login", response_model=TokenResponse, summary="Login with IIN and password")
async def login(request: LoginRequest, db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        select(User).options(selectinload(User.role)).where(User.iin == request.iin, User.is_active == True)
    )
    user = result.scalar_one_or_none()

    if not user or not user.password_hash:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid IIN or password",
        )

    if not verify_password(request.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid IIN or password",
        )

    role_name = user.role.name if user.role else "farmer"
    payload = _build_token_payload(user, role_name)
    access_token = create_access_token(payload)
    refresh_token = create_refresh_token(user.id)

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=settings.JWT_ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        user_id=user.id,
        role=role_name,
        language=user.language_pref,
    )


@router.post("/login/eds", response_model=TokenResponse, summary="Login with EDS certificate")
async def login_eds(request: EDSLoginRequest, db: AsyncSession = Depends(get_db)):
    """
    EDS (Electronic Digital Signature) login flow:
    1. Client requests a challenge token from GET /auth/challenge
    2. Client signs challenge with NCALayer/eGov Mobile
    3. Client sends CMS signature here
    4. Backend verifies signature against NCA RK PKI
    5. Extracts IIN from certificate, finds/creates user
    """
    # TODO: Implement NCALayer CMS signature verification
    # For now, return placeholder
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="EDS login requires NCALayer integration (Phase 5)",
    )


@router.get("/challenge", summary="Get challenge token for EDS login")
async def get_challenge():
    """Returns a one-time challenge token for EDS signing."""
    import uuid
    import time
    challenge = f"vetdigital-challenge-{uuid.uuid4()}-{int(time.time())}"
    return {"challenge": challenge, "expires_in": 300}


@router.post("/refresh", response_model=TokenResponse, summary="Refresh access token")
async def refresh_token(request: RefreshRequest, db: AsyncSession = Depends(get_db)):
    payload = decode_token(request.refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired refresh token",
        )

    user_id = payload.get("sub")
    result = await db.execute(
        select(User).options(selectinload(User.role)).where(User.id == user_id, User.is_active == True)
    )
    user = result.scalar_one_or_none()

    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="User not found")

    role_name = user.role.name if user.role else "farmer"
    token_payload = _build_token_payload(user, role_name)
    access_token = create_access_token(token_payload)
    new_refresh_token = create_refresh_token(user.id)

    return TokenResponse(
        access_token=access_token,
        refresh_token=new_refresh_token,
        expires_in=settings.JWT_ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        user_id=user.id,
        role=role_name,
        language=user.language_pref,
    )


@router.post("/logout", summary="Logout (invalidate refresh token)")
async def logout():
    # TODO: Add refresh token to Redis blacklist
    return {"message": "Logged out successfully"}

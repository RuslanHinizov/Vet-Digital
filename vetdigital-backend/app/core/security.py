from datetime import datetime, timedelta, timezone
from typing import Optional
from jose import JWTError, jwt
from passlib.context import CryptContext

from app.config import settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + (
        expires_delta or timedelta(minutes=settings.JWT_ACCESS_TOKEN_EXPIRE_MINUTES)
    )
    to_encode.update({"exp": expire, "type": "access"})
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.JWT_ALGORITHM)


def create_refresh_token(user_id: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(days=settings.JWT_REFRESH_TOKEN_EXPIRE_DAYS)
    to_encode = {"sub": user_id, "exp": expire, "type": "refresh"}
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.JWT_ALGORITHM)


def decode_token(token: str) -> Optional[dict]:
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.JWT_ALGORITHM])
        return payload
    except JWTError:
        return None


def validate_iin(iin: str) -> bool:
    """Validate Kazakhstan Individual Identification Number (IIN).
    IIN is 12 digits. The last digit is a checksum.
    """
    if not iin or len(iin) != 12 or not iin.isdigit():
        return False

    weights1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    weights2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2]

    digits = [int(d) for d in iin]
    checksum = sum(w * d for w, d in zip(weights1, digits[:11])) % 11

    if checksum == 10:
        checksum = sum(w * d for w, d in zip(weights2, digits[:11])) % 11

    return checksum == digits[11]


def validate_bin(bin_number: str) -> bool:
    """Validate Kazakhstan Business Identification Number (BIN).
    BIN is 12 digits with specific structure for legal entities.
    """
    if not bin_number or len(bin_number) != 12 or not bin_number.isdigit():
        return False
    # BIN: 4th digit must be 4 or 5 (4=legal entity, 5=branch)
    return bin_number[3] in ("4", "5")

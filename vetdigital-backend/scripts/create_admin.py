"""
Create the initial admin user.

Usage (from vetdigital-backend/):
    python scripts/create_admin.py

Environment:
    Reads DATABASE_URL from .env (or environment variables).
    Requires the database to be running and migrations applied:
        alembic upgrade head
"""
import asyncio
import sys
import uuid
from pathlib import Path

# Add project root to path so 'app' package is importable
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from passlib.context import CryptContext
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

from app.config import settings
from app.models.user import Role, User

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


async def create_admin(iin: str, full_name_ru: str, password: str) -> None:
    engine = create_async_engine(settings.DATABASE_URL, echo=False)
    async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

    async with async_session() as db:
        # Verify admin role exists (seed data from migration)
        result = await db.execute(select(Role).where(Role.name == "admin"))
        admin_role = result.scalar_one_or_none()
        if not admin_role:
            print("ERROR: 'admin' role not found. Run 'alembic upgrade head' first.")
            await engine.dispose()
            return

        # Check if user with this IIN already exists
        result = await db.execute(select(User).where(User.iin == iin))
        existing = result.scalar_one_or_none()
        if existing:
            print(f"User with IIN {iin} already exists (id={existing.id}).")
            await engine.dispose()
            return

        user = User(
            id=str(uuid.uuid4()),
            iin=iin,
            full_name_ru=full_name_ru,
            role_id=admin_role.id,
            password_hash=pwd_context.hash(password),
            is_active=True,
            language_pref="ru",
        )
        db.add(user)
        await db.commit()
        await db.refresh(user)
        print(f"Admin user created successfully:")
        print(f"  ID       : {user.id}")
        print(f"  IIN      : {user.iin}")
        print(f"  Name     : {user.full_name_ru}")
        print(f"  Role     : admin")
        print(f"  Password : (the one you provided - change it in production!)")

    await engine.dispose()


def main():
    import getpass

    print("=== VetDigital Admin User Setup ===")
    iin = input("IIN (12 digits): ").strip()
    if len(iin) != 12 or not iin.isdigit():
        print("ERROR: IIN must be exactly 12 digits.")
        sys.exit(1)

    full_name_ru = input("Full name (Russian, e.g. Иванов Иван Иванович): ").strip()
    if not full_name_ru:
        print("ERROR: Full name cannot be empty.")
        sys.exit(1)

    password = getpass.getpass("Password (min 8 chars): ")
    if len(password) < 8:
        print("ERROR: Password must be at least 8 characters.")
        sys.exit(1)

    confirm = getpass.getpass("Confirm password: ")
    if password != confirm:
        print("ERROR: Passwords do not match.")
        sys.exit(1)

    asyncio.run(create_admin(iin=iin, full_name_ru=full_name_ru, password=password))


if __name__ == "__main__":
    main()

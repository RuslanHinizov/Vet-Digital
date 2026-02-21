"""
Pytest configuration and shared fixtures.
"""
import asyncio
import pytest
import pytest_asyncio
from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from fastapi.testclient import TestClient
from httpx import AsyncClient, ASGITransport

from app.main import app
from app.database import Base, get_db
from app.config import settings


# ─── Event loop ───────────────────────────────────────────────────────────────

@pytest.fixture(scope="session")
def event_loop():
    """Create event loop for async tests."""
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()


# ─── Test database ────────────────────────────────────────────────────────────

TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"


@pytest.fixture(scope="session")
async def test_engine():
    engine = create_async_engine(TEST_DATABASE_URL, echo=False)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
    await engine.dispose()


@pytest.fixture
async def db_session(test_engine) -> AsyncGenerator[AsyncSession, None]:
    session_factory = async_sessionmaker(test_engine, expire_on_commit=False)
    async with session_factory() as session:
        yield session
        await session.rollback()


# ─── FastAPI test client ──────────────────────────────────────────────────────

@pytest.fixture
async def client(db_session: AsyncSession) -> AsyncGenerator[AsyncClient, None]:
    """Async HTTP test client with DB override."""
    async def override_get_db():
        yield db_session

    app.dependency_overrides[get_db] = override_get_db

    async with AsyncClient(
        transport=ASGITransport(app=app),
        base_url="http://test",
    ) as ac:
        yield ac

    app.dependency_overrides.clear()


# ─── Sample data ──────────────────────────────────────────────────────────────

@pytest.fixture
def sample_iin_valid():
    """Valid Kazakhstan IIN for testing."""
    return "861231300115"  # Example valid IIN


@pytest.fixture
def sample_iin_invalid():
    return "123456789012"  # Invalid checksum


@pytest.fixture
def sample_procedure_data():
    """Minimal valid procedure act data."""
    return {
        "act_number": "АКТ-TEST-001",
        "act_date": "2024-05-15",
        "procedure_type": "vaccination",
        "disease_name": "Ящур",
        "settlement": "Алматы",
        "specialist_name": "Иванов И.И.",
        "species_name": "Крупный рогатый скот",
        "male_count": 10,
        "female_count": 15,
        "young_count": 5,
        "total_vaccinated": 30,
        "vaccine_name": "Форт Додж",
        "manufacturer": "Boehringer Ingelheim",
        "series": "2024-001",
        "state_control_no": "КЗ-2024-001",
        "injection_method": "Внутримышечно",
        "dose_adult_ml": 2.0,
        "dose_young_ml": 1.0,
    }


@pytest.fixture
def sample_geofence_data():
    """Valid GeoJSON polygon for geofence testing."""
    return {
        "name": "Тестовое пастбище",
        "geofence_type": "pasture",
        "boundary_geojson": '{"type":"Polygon","coordinates":[[[76.89,43.23],[76.91,43.23],[76.91,43.24],[76.89,43.24],[76.89,43.23]]]}',
        "description": "Тестовая геозона",
    }

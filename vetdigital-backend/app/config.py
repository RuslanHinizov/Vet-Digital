from functools import lru_cache
from pathlib import Path
from typing import List
from pydantic_settings import BaseSettings, SettingsConfigDict

_ENV_FILE = Path(__file__).resolve().parent.parent / ".env"


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=str(_ENV_FILE),
        env_file_encoding="utf-8",
        case_sensitive=False,
    )

    # Application
    APP_NAME: str = "VetDigital"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = False
    ENVIRONMENT: str = "development"
    SECRET_KEY: str = "change-me-in-production-at-least-32-characters"

    # Database
    DATABASE_URL: str = "postgresql+asyncpg://vetdigital:vetdigital_pass@localhost:5432/vetdigital"
    DATABASE_URL_SYNC: str = "postgresql+psycopg2://vetdigital:vetdigital_pass@localhost:5432/vetdigital"
    DB_POOL_SIZE: int = 10
    DB_MAX_OVERFLOW: int = 20

    # Redis
    REDIS_URL: str = "redis://localhost:6379/0"
    REDIS_CACHE_URL: str = "redis://localhost:6379/1"
    REDIS_CACHE_TTL: int = 300  # seconds

    # MQTT (EMQX)
    MQTT_BROKER_HOST: str = "localhost"
    MQTT_BROKER_PORT: int = 1883
    MQTT_USERNAME: str = "vetdigital"
    MQTT_PASSWORD: str = "mqtt_pass"
    MQTT_TOPIC_GPS: str = "vetdigital/gps/{device_serial}/telemetry"
    MQTT_TOPIC_COMMAND: str = "vetdigital/gps/{device_serial}/command"

    # MinIO
    MINIO_ENDPOINT: str = "localhost:9000"
    MINIO_ACCESS_KEY: str = "minioadmin"
    MINIO_SECRET_KEY: str = "minioadmin"
    MINIO_BUCKET_DOCUMENTS: str = "vetdigital-documents"
    MINIO_BUCKET_PHOTOS: str = "vetdigital-photos"
    MINIO_SECURE: bool = False

    # JWT
    JWT_ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    JWT_REFRESH_TOKEN_EXPIRE_DAYS: int = 30
    JWT_ALGORITHM: str = "HS256"

    # Smart Bridge
    SMART_BRIDGE_BASE_URL: str = "https://sb.egov.kz/api/v1"
    SMART_BRIDGE_API_KEY: str = ""
    SMART_BRIDGE_SYSTEM_ID: str = "vetdigital"

    # AnimalID.kz
    ANIMALID_BASE_URL: str = "https://www.animalid.kz/api"
    ANIMALID_API_KEY: str = ""

    # NCALayer / eGov EDS
    NCALAYER_VERIFY_URL: str = ""          # KNCA verification endpoint (Phase 5)
    BACKEND_PUBLIC_URL: str = "https://vetdigital.gov.kz"
    MINIO_BUCKET: str = "vetdigital-documents"  # alias for pdf_generator

    # Firebase
    FIREBASE_CREDENTIALS_PATH: str = "./firebase-credentials.json"

    # CORS
    CORS_ORIGINS: List[str] = ["http://localhost:3000", "http://localhost:8080"]

    # Celery
    CELERY_BROKER_URL: str = "redis://localhost:6379/2"
    CELERY_RESULT_BACKEND: str = "redis://localhost:6379/3"

    # Sync intervals
    ISZH_SYNC_INTERVAL_HOURS: int = 6

    # Pagination
    DEFAULT_PAGE_SIZE: int = 20
    MAX_PAGE_SIZE: int = 100


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()

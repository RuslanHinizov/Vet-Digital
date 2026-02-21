from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.config import settings
from app.database import check_db_connection
from app.core.exceptions import VetDigitalException
from app.api.v1.router import api_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    db_ok = await check_db_connection()
    if not db_ok:
        print("WARNING: Database connection failed on startup")
    else:
        print("Database connection OK")
    yield
    # Shutdown
    print("VetDigital API shutting down")


app = FastAPI(
    title="VetDigital API",
    description=(
        "Kazakhstan Veterinary Animal GPS/RFID Tracking System. "
        "Smart Bridge integrated government project for animal identification, "
        "GPS tracking, geofencing, and digital veterinary document management."
    ),
    version=settings.APP_VERSION,
    docs_url="/docs" if settings.DEBUG else None,
    redoc_url="/redoc" if settings.DEBUG else None,
    lifespan=lifespan,
)

# CORS
_cors_origins = list(settings.CORS_ORIGINS)
if settings.DEBUG:
    # Ensure both localhost and 127.0.0.1 variants are allowed in dev
    for port in ["3000", "8080", "54321"]:
        for host in ["localhost", "127.0.0.1"]:
            origin = f"http://{host}:{port}"
            if origin not in _cors_origins:
                _cors_origins.append(origin)

app.add_middleware(
    CORSMiddleware,
    allow_origins=_cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Global exception handler
@app.exception_handler(VetDigitalException)
async def vetdigital_exception_handler(request: Request, exc: VetDigitalException):
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.message, "details": exc.details},
    )


# Health check
@app.get("/health", tags=["System"])
async def health_check():
    db_ok = await check_db_connection()
    return {
        "status": "ok" if db_ok else "degraded",
        "app": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "database": "connected" if db_ok else "disconnected",
    }


@app.get("/", tags=["System"])
async def root():
    return {
        "app": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "docs": "/docs",
    }


# Include all API routes
app.include_router(api_router)

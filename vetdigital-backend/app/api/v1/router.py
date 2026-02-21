from fastapi import APIRouter

from app.api.v1 import auth, users, animals, owners, veterinary, documents, geofences, gps, inventory, dashboard, sync

api_router = APIRouter(prefix="/api/v1")

api_router.include_router(auth.router, prefix="/auth", tags=["Authentication"])
api_router.include_router(users.router, prefix="/users", tags=["Users"])
api_router.include_router(animals.router, prefix="/animals", tags=["Animals"])
api_router.include_router(owners.router, prefix="/owners", tags=["Owners"])
api_router.include_router(veterinary.router, prefix="/procedures", tags=["Veterinary Procedures"])
api_router.include_router(documents.router, prefix="/documents", tags=["Documents"])
api_router.include_router(geofences.router, prefix="/geofences", tags=["Geofences"])
api_router.include_router(gps.router, prefix="/gps", tags=["GPS Tracking"])
api_router.include_router(inventory.router, prefix="/inventory", tags=["Inventory"])
api_router.include_router(dashboard.router, prefix="/dashboard", tags=["Dashboard"])
api_router.include_router(sync.router, prefix="/sync", tags=["Offline Sync"])

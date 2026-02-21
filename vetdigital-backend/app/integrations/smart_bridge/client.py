"""
Smart Bridge (sb.egov.kz) API Client.

Integration with Kazakhstan's government API gateway to access ISZH
(animal identification system - iszh.gov.kz).

IMPORTANT: Before using this client, the VetDigital system must be
registered on the Smart Bridge platform (sb.egov.kz) with a valid
EDS certificate. Registration is done by the Ministry of Agriculture.

Phase 5 implementation. Currently returns mock data.
"""
import httpx
import logging
from typing import Optional
from app.config import settings

logger = logging.getLogger(__name__)


class SmartBridgeError(Exception):
    pass


class SmartBridgeClient:
    """
    Client for Smart Bridge API gateway (sb.egov.kz).

    Authentication: EDS certificate-based signed requests.
    The system-level certificate is separate from user EDS certificates.

    Key endpoints (after registration):
    - GET /iszh/animals/{identification_no} - Look up animal by national ID
    - GET /iszh/animals/chip/{microchip_no} - Look up by microchip number
    - POST /iszh/animals - Register new animal
    - PUT /iszh/animals/{id} - Update animal data
    - POST /iszh/vaccinations - Record vaccination (sync from VetDigital)
    - GET /farmers/{iin} - Get farmer info by IIN
    """

    BASE_URL = settings.SMART_BRIDGE_BASE_URL
    SYSTEM_ID = settings.SMART_BRIDGE_SYSTEM_ID

    def __init__(self):
        self._client = httpx.AsyncClient(
            base_url=self.BASE_URL,
            headers={
                "X-System-ID": self.SYSTEM_ID,
                "X-API-Key": settings.SMART_BRIDGE_API_KEY,
                "Content-Type": "application/json",
            },
            timeout=30.0,
        )

    async def get_animal_by_id(self, identification_no: str) -> Optional[dict]:
        """Query ISZH for animal by national identification number."""
        if not settings.SMART_BRIDGE_API_KEY:
            logger.warning("Smart Bridge API key not configured - returning mock data")
            return self._mock_animal(identification_no)

        try:
            response = await self._client.get(f"/iszh/animals/{identification_no}")
            response.raise_for_status()
            return response.json()
        except httpx.HTTPError as e:
            raise SmartBridgeError(f"ISZH lookup failed: {e}") from e

    async def get_animal_by_microchip(self, microchip_no: str) -> Optional[dict]:
        """Query ISZH for animal by TROVAN microchip number."""
        if not settings.SMART_BRIDGE_API_KEY:
            return self._mock_animal(f"CHIP-{microchip_no}")

        try:
            response = await self._client.get(f"/iszh/animals/chip/{microchip_no}")
            if response.status_code == 404:
                return None
            response.raise_for_status()
            return response.json()
        except httpx.HTTPError as e:
            raise SmartBridgeError(f"Microchip lookup failed: {e}") from e

    async def sync_vaccination(self, vaccination_data: dict) -> bool:
        """Push a signed vaccination act to ISZH."""
        if not settings.SMART_BRIDGE_API_KEY:
            logger.info(f"MOCK: Would sync vaccination to ISZH: {vaccination_data}")
            return True

        try:
            response = await self._client.post("/iszh/vaccinations", json=vaccination_data)
            response.raise_for_status()
            return True
        except httpx.HTTPError as e:
            raise SmartBridgeError(f"Vaccination sync failed: {e}") from e

    async def close(self):
        await self._client.aclose()

    def _mock_animal(self, identification_no: str) -> dict:
        """Returns mock ISZH animal data for development/testing."""
        return {
            "identification_no": identification_no,
            "species": "cattle",
            "sex": "female",
            "birth_year": 2021,
            "color": "Черно-пестрая",
            "owner_iin": "000000000000",
            "owner_name": "Тестов Тест Тестович",
            "region_kato": "350000000",
            "status": "active",
            "source": "mock_data",
        }


# Singleton instance
smart_bridge = SmartBridgeClient()

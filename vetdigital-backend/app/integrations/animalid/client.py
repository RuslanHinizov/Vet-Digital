"""
AnimalID.kz Client - National Database of Electronic Animal Identification of Kazakhstan.
Manages TROVAN microchip registration data.

Microchip format: 15-digit ISO 11784/11785 FDX-B
- Frequency: 134.2 kHz
- Kazakhstan country code: 398
"""
import httpx
import logging
from typing import Optional
from app.config import settings

logger = logging.getLogger(__name__)


class AnimalIDClient:
    BASE_URL = settings.ANIMALID_BASE_URL

    def __init__(self):
        self._client = httpx.AsyncClient(
            base_url=self.BASE_URL,
            headers={"X-API-Key": settings.ANIMALID_API_KEY},
            timeout=15.0,
        )

    async def lookup_microchip(self, microchip_no: str) -> Optional[dict]:
        """Look up animal by 15-digit ISO 11784 microchip number."""
        if len(microchip_no) != 15 or not microchip_no.isdigit():
            return None

        if not settings.ANIMALID_API_KEY:
            logger.warning("AnimalID.kz API key not configured - returning mock")
            return self._mock_microchip(microchip_no)

        try:
            response = await self._client.get(f"/microchip/{microchip_no}")
            if response.status_code == 404:
                return None
            response.raise_for_status()
            return response.json()
        except httpx.HTTPError as e:
            logger.error(f"AnimalID lookup error: {e}")
            return None

    def validate_microchip_format(self, microchip_no: str) -> bool:
        """Validate 15-digit ISO 11784 microchip number format."""
        if len(microchip_no) != 15 or not microchip_no.isdigit():
            return False
        # Kazakhstan country code starts with 398
        # Full validation requires checksum per ISO 11784
        return True

    def _mock_microchip(self, microchip_no: str) -> dict:
        return {
            "microchip_no": microchip_no,
            "animal_type": "dog",
            "owner_name": "Test Owner",
            "owner_phone": "+77001234567",
            "registered_at": "2023-01-01",
            "source": "mock_data",
        }

    async def close(self):
        await self._client.aclose()


animalid_client = AnimalIDClient()

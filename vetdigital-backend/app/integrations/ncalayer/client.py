"""
NCALayer / eGov Mobile EDS (Electronic Digital Signature) integration.

Two signing flows:
1. Desktop: NCALayer WebSocket (wss://127.0.0.1:13579) — for web admin panel
2. Mobile: eGov Mobile QR signing — for veterinarian app

EDS workflow for procedure act signing:
1. Backend generates document hash
2. Backend creates challenge (UUID + expiry)
3. Mobile shows QR code with egov:// deeplink
4. User opens eGov Mobile → scans QR → signs with PIN → callback to backend
5. Backend verifies signature via KNCA (Kazakhstan National Certification Authority)
6. Act status updated to "signed", DigitalSignature record created

Phase 5 implementation: KNCA signature verification is a stub.
"""
import hashlib
import logging
from typing import Optional
from uuid import uuid4, UUID
from datetime import datetime, timedelta, timezone

import httpx

from app.config import settings

logger = logging.getLogger(__name__)


class NCALayerError(Exception):
    pass


class EgovMobileClient:
    """
    Client for eGov Mobile QR signing flow.

    Docs: https://egov.kz/cms/ru/articles/eds-mobile
    The mobile signing works via a challenge-response mechanism:
    - Backend registers a signing challenge at the eGov callback endpoint
    - User scans QR in eGov Mobile app
    - eGov Mobile calls back to our /api/v1/auth/eds-callback endpoint
    """

    EGOV_DEEPLINK_SCHEME = "egov"

    def __init__(self):
        self._client = httpx.AsyncClient(timeout=15.0)

    def create_document_hash(self, content: str) -> str:
        """Create SHA-256 hash of document content for signing."""
        return hashlib.sha256(content.encode("utf-8")).hexdigest()

    def create_signing_challenge(
        self,
        document_id: str,
        document_hash: str,
        document_type: str = "procedure_act",
        ttl_minutes: int = 10,
    ) -> dict:
        """
        Create a signing challenge for eGov Mobile QR.
        Returns challenge data including the QR deeplink URL.
        """
        challenge_token = str(uuid4())
        expires_at = datetime.now(timezone.utc) + timedelta(minutes=ttl_minutes)

        # eGov Mobile QR deeplink format
        callback_url = (
            f"{settings.BACKEND_PUBLIC_URL}/api/v1/auth/eds-callback"
            f"?token={challenge_token}"
        )
        qr_data = (
            f"{self.EGOV_DEEPLINK_SCHEME}://sign"
            f"?docId={document_id}"
            f"&hash={document_hash}"
            f"&type={document_type}"
            f"&callback={callback_url}"
        )

        return {
            "challenge_token": challenge_token,
            "document_id": document_id,
            "document_hash": document_hash,
            "document_type": document_type,
            "qr_data": qr_data,
            "expires_at": expires_at.isoformat(),
            "ttl_seconds": ttl_minutes * 60,
        }

    async def verify_signature(
        self,
        document_hash: str,
        signature_data: str,
        signer_iin: str,
    ) -> tuple[bool, Optional[str]]:
        """
        Verify an EDS signature via KNCA (Kazakhstan National Certification Authority).

        Phase 5: This requires registration with KNCA and their verification API.
        Currently returns mock valid response.

        Returns (is_valid, error_message)
        """
        if not settings.NCALAYER_VERIFY_URL:
            logger.warning("KNCA verification URL not configured — accepting signature as valid (mock)")
            return True, None

        try:
            response = await self._client.post(
                settings.NCALAYER_VERIFY_URL,
                json={
                    "document_hash": document_hash,
                    "signature": signature_data,
                    "signer_iin": signer_iin,
                },
            )
            response.raise_for_status()
            data = response.json()
            is_valid = data.get("valid", False)
            error = None if is_valid else data.get("error", "Signature invalid")
            return is_valid, error
        except httpx.HTTPError as e:
            logger.error(f"KNCA verification failed: {e}")
            # In production, return False. For development, accept.
            return not bool(settings.NCALAYER_VERIFY_URL), f"KNCA error: {e}"

    async def close(self):
        await self._client.aclose()


class NCALayerDesktopClient:
    """
    NCALayer desktop WebSocket client for web admin panel.
    NCALayer runs as local service: wss://127.0.0.1:13579

    This is used from the frontend JavaScript, not directly from backend.
    The backend only verifies the resulting signature.

    Included here as documentation of the NCALayer API contract.
    """

    NCALAYER_URL = "wss://127.0.0.1:13579"

    # NCALayer method names
    METHOD_GET_ACTIVE_TOKENS = "getActiveTokens"
    METHOD_GET_KEY_INFO = "getKeyInfo"
    METHOD_SIGN_PLAIN_DATA = "signPlainData"  # Signs raw data
    METHOD_SIGN_XML = "signXML"              # Signs XML (for structured documents)
    METHOD_CREATE_CMS = "createCMSSignatureFromBase64"  # CMS envelope

    @classmethod
    def get_frontend_js_snippet(cls, document_hash: str) -> str:
        """
        Returns JS snippet for frontend NCALayer integration.
        This runs in the browser, not on the backend.
        """
        return f"""
// NCALayer signing snippet (run in browser)
const ws = new WebSocket('{cls.NCALAYER_URL}');
ws.onopen = () => {{
    ws.send(JSON.stringify({{
        method: 'signPlainData',
        args: [
            'PKCS12',              // Keystore type
            '{document_hash}',     // Data to sign (Base64 or plain)
            'SHA256withRSA',       // Signature algorithm
            '',                    // Password (user inputs)
        ]
    }}));
}};
ws.onmessage = (event) => {{
    const result = JSON.parse(event.data);
    if (result.responseObject) {{
        // Send signature to backend
        fetch('/api/v1/auth/verify-eds', {{
            method: 'POST',
            headers: {{'Content-Type': 'application/json'}},
            body: JSON.stringify({{ signature: result.responseObject }})
        }});
    }}
}};
"""


# Singleton instances
egov_mobile_client = EgovMobileClient()
ncalayer_desktop = NCALayerDesktopClient()

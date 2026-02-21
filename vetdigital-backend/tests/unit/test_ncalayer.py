"""
Unit tests for NCALayer/eGov Mobile EDS integration.
"""
import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from app.integrations.ncalayer.client import EgovMobileClient, NCALayerDesktopClient


class TestEgovMobileClient:
    def setup_method(self):
        self.client = EgovMobileClient()

    def test_create_document_hash(self):
        content = "test document content"
        hash1 = self.client.create_document_hash(content)
        hash2 = self.client.create_document_hash(content)
        assert hash1 == hash2  # Deterministic
        assert len(hash1) == 64  # SHA-256 hex length
        assert hash1.isalnum()

    def test_different_contents_give_different_hashes(self):
        h1 = self.client.create_document_hash("content 1")
        h2 = self.client.create_document_hash("content 2")
        assert h1 != h2

    def test_create_signing_challenge_structure(self):
        result = self.client.create_signing_challenge(
            document_id="test-doc-id",
            document_hash="abc123",
            document_type="procedure_act",
        )
        assert "challenge_token" in result
        assert "document_id" in result
        assert "document_hash" in result
        assert "document_type" in result
        assert "qr_data" in result
        assert "expires_at" in result
        assert "ttl_seconds" in result

    def test_create_signing_challenge_qr_format(self):
        result = self.client.create_signing_challenge(
            document_id="doc-123",
            document_hash="hash-abc",
        )
        qr_data = result["qr_data"]
        assert qr_data.startswith("egov://sign")
        assert "docId=doc-123" in qr_data
        assert "hash=hash-abc" in qr_data
        assert "callback=" in qr_data

    def test_challenge_token_is_uuid(self):
        import uuid
        result = self.client.create_signing_challenge(
            document_id="x", document_hash="y"
        )
        # Should be a valid UUID
        try:
            uuid.UUID(result["challenge_token"])
            is_uuid = True
        except ValueError:
            is_uuid = False
        assert is_uuid

    def test_ttl_seconds(self):
        result = self.client.create_signing_challenge(
            document_id="x", document_hash="y", ttl_minutes=15
        )
        assert result["ttl_seconds"] == 900

    @pytest.mark.asyncio
    async def test_verify_signature_mock_mode(self):
        """When NCALAYER_VERIFY_URL not configured, accept as valid (mock mode)."""
        with patch("app.integrations.ncalayer.client.settings") as mock_settings:
            mock_settings.NCALAYER_VERIFY_URL = None
            is_valid, error = await self.client.verify_signature(
                document_hash="hash",
                signature_data="sig",
                signer_iin="861231300115",
            )
        assert is_valid is True
        assert error is None

    @pytest.mark.asyncio
    async def test_verify_signature_with_url_success(self):
        mock_response = MagicMock()
        mock_response.json.return_value = {"valid": True}
        mock_response.raise_for_status = MagicMock()

        with patch("app.integrations.ncalayer.client.settings") as mock_settings:
            mock_settings.NCALAYER_VERIFY_URL = "https://knca.test/verify"
            self.client._client.post = AsyncMock(return_value=mock_response)
            is_valid, error = await self.client.verify_signature(
                document_hash="hash",
                signature_data="sig",
                signer_iin="iin",
            )
        assert is_valid is True
        assert error is None

    @pytest.mark.asyncio
    async def test_verify_signature_with_url_invalid(self):
        mock_response = MagicMock()
        mock_response.json.return_value = {"valid": False, "error": "Bad signature"}
        mock_response.raise_for_status = MagicMock()

        with patch("app.integrations.ncalayer.client.settings") as mock_settings:
            mock_settings.NCALAYER_VERIFY_URL = "https://knca.test/verify"
            self.client._client.post = AsyncMock(return_value=mock_response)
            is_valid, error = await self.client.verify_signature(
                document_hash="hash",
                signature_data="bad_sig",
                signer_iin="iin",
            )
        assert is_valid is False
        assert error == "Bad signature"


class TestNCALayerDesktopClient:
    def test_ncalayer_url_constant(self):
        assert NCALayerDesktopClient.NCALAYER_URL == "wss://127.0.0.1:13579"

    def test_get_frontend_js_snippet_contains_hash(self):
        snippet = NCALayerDesktopClient.get_frontend_js_snippet("test-hash-abc")
        assert "test-hash-abc" in snippet

    def test_snippet_contains_websocket(self):
        snippet = NCALayerDesktopClient.get_frontend_js_snippet("hash")
        assert "WebSocket" in snippet
        assert "wss://127.0.0.1:13579" in snippet

    def test_snippet_contains_signplaindata(self):
        snippet = NCALayerDesktopClient.get_frontend_js_snippet("hash")
        assert "signPlainData" in snippet

    def test_snippet_is_string(self):
        snippet = NCALayerDesktopClient.get_frontend_js_snippet("hash")
        assert isinstance(snippet, str)
        assert len(snippet) > 100

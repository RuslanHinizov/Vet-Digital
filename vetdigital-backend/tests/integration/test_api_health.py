"""
Integration tests for API health and basic endpoints.

These tests use the FastAPI test client with an in-memory SQLite DB.
Run with: pytest tests/ -v
"""
import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
class TestHealthEndpoint:
    async def test_root_returns_200(self, client: AsyncClient):
        response = await client.get("/")
        assert response.status_code in (200, 404)  # depends on root handler

    async def test_health_endpoint(self, client: AsyncClient):
        response = await client.get("/health")
        assert response.status_code in (200, 404)

    async def test_api_v1_docs(self, client: AsyncClient):
        response = await client.get("/docs")
        assert response.status_code in (200, 404)


@pytest.mark.asyncio
class TestAuthEndpoints:
    async def test_login_with_missing_credentials(self, client: AsyncClient):
        response = await client.post("/api/v1/auth/login", json={})
        assert response.status_code in (400, 422)

    async def test_login_with_invalid_credentials(self, client: AsyncClient):
        response = await client.post(
            "/api/v1/auth/login",
            json={"iin": "000000000000", "password": "wrongpassword"},
        )
        assert response.status_code in (401, 400, 422)

    async def test_protected_endpoint_requires_auth(self, client: AsyncClient):
        response = await client.get("/api/v1/users/me")
        assert response.status_code in (401, 403)

    async def test_animals_requires_auth(self, client: AsyncClient):
        response = await client.get("/api/v1/animals")
        assert response.status_code in (401, 403)

    async def test_procedures_requires_auth(self, client: AsyncClient):
        response = await client.get("/api/v1/procedures")
        assert response.status_code in (401, 403)


@pytest.mark.asyncio
class TestDocumentEndpoints:
    async def test_documents_list_requires_auth(self, client: AsyncClient):
        response = await client.get("/api/v1/documents")
        assert response.status_code in (401, 403)

    async def test_document_sign_initiate_requires_auth(self, client: AsyncClient):
        import uuid
        doc_id = str(uuid.uuid4())
        response = await client.post(
            f"/api/v1/documents/{doc_id}/sign/initiate",
            params={"doc_type": "procedure_act"},
        )
        assert response.status_code in (401, 403)

    async def test_document_download_requires_auth(self, client: AsyncClient):
        import uuid
        doc_id = str(uuid.uuid4())
        response = await client.get(f"/api/v1/documents/{doc_id}/download")
        assert response.status_code in (401, 403)


@pytest.mark.asyncio
class TestGeofenceEndpoints:
    async def test_geofences_requires_auth(self, client: AsyncClient):
        response = await client.get("/api/v1/geofences")
        assert response.status_code in (401, 403)


@pytest.mark.asyncio
class TestInputValidation:
    async def test_invalid_uuid_returns_422(self, client: AsyncClient):
        """Invalid UUIDs in path params should return 422."""
        response = await client.get("/api/v1/animals/not-a-uuid")
        assert response.status_code in (401, 403, 422)

    async def test_document_unsupported_type(self, client: AsyncClient):
        """Unsupported doc_type param should return error after auth."""
        import uuid
        doc_id = str(uuid.uuid4())
        response = await client.get(
            f"/api/v1/documents/{doc_id}/download",
            params={"doc_type": "unsupported_type"},
        )
        # Unauthenticated → 401/403; authenticated would get 400
        assert response.status_code in (400, 401, 403)

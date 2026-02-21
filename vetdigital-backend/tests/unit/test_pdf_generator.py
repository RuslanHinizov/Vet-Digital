"""
Unit tests for PDF generation utilities.
"""
import pytest
from datetime import datetime
from unittest.mock import AsyncMock, MagicMock, patch


class MockAct:
    """Mock procedure act for PDF generation tests."""
    id = "test-act-id-123"
    act_number = "АКТ-TEST-001"
    act_date = datetime(2024, 5, 15)
    procedure_type = "vaccination"
    disease_name = "Ящур"
    settlement = "Алматы"
    specialist_name = "Иванов И.И."
    species_name = "КРС"
    owner_name = "Петров П.П."
    owner_iin = "861231300115"
    male_count = 10
    female_count = 15
    young_count = 5
    total_vaccinated = 30
    vaccine_name = "Форт Додж"
    allergen_name = None
    manufacturer = "Boehringer"
    series = "2024-001"
    production_date = datetime(2024, 1, 1)
    state_control_no = "КЗ-2024-001"
    injection_method = "Внутримышечно"
    dose_adult_ml = 2.0
    dose_young_ml = 1.0
    allergen_reading_hours = None
    materials_json = '[{"name":"Шприц 2мл","quantity":30,"unit":"шт"}]'
    status = "signed"
    signed_at = datetime(2024, 5, 15, 12, 30)


class TestPdfGeneratorImport:
    def test_can_import_module(self):
        """PDF generator module should import without error."""
        try:
            from app.utils.pdf_generator import generate_procedure_act_pdf
            assert callable(generate_procedure_act_pdf)
        except ImportError as e:
            pytest.skip(f"PDF dependencies not installed: {e}")

    def test_reportlab_availability_flag(self):
        """REPORTLAB_AVAILABLE flag should exist."""
        from app.utils import pdf_generator
        assert hasattr(pdf_generator, "REPORTLAB_AVAILABLE")
        assert isinstance(pdf_generator.REPORTLAB_AVAILABLE, bool)


@pytest.mark.asyncio
class TestBuildPdf:
    async def test_generate_returns_none_when_reportlab_unavailable(self):
        """When ReportLab not installed, generate should return None."""
        with patch("app.utils.pdf_generator.REPORTLAB_AVAILABLE", False):
            from app.utils.pdf_generator import generate_procedure_act_pdf
            result = await generate_procedure_act_pdf(MockAct())
        assert result is None

    async def test_build_pdf_returns_bytes(self):
        """_build_pdf should return bytes if ReportLab available."""
        try:
            from app.utils.pdf_generator import _build_pdf, REPORTLAB_AVAILABLE
        except ImportError:
            pytest.skip("PDF module not available")

        if not REPORTLAB_AVAILABLE:
            pytest.skip("ReportLab not installed")

        pdf_bytes = _build_pdf(MockAct())
        assert isinstance(pdf_bytes, bytes)
        assert len(pdf_bytes) > 1000  # Minimum valid PDF size

    async def test_pdf_starts_with_pdf_magic(self):
        """PDF bytes should start with %PDF magic bytes."""
        try:
            from app.utils.pdf_generator import _build_pdf, REPORTLAB_AVAILABLE
        except ImportError:
            pytest.skip("PDF module not available")

        if not REPORTLAB_AVAILABLE:
            pytest.skip("ReportLab not installed")

        pdf_bytes = _build_pdf(MockAct())
        assert pdf_bytes[:4] == b"%PDF"

    async def test_generate_with_minio_mock(self):
        """generate_procedure_act_pdf should call MinIO upload."""
        try:
            from app.utils import pdf_generator
            from app.utils.pdf_generator import REPORTLAB_AVAILABLE
        except ImportError:
            pytest.skip("PDF module not available")

        if not REPORTLAB_AVAILABLE:
            pytest.skip("ReportLab not installed")

        with patch.object(pdf_generator, "_upload_to_minio", new=AsyncMock(
            return_value="https://minio.test/bucket/procedure-acts/test/АКТ-TEST-001.pdf"
        )):
            result = await pdf_generator.generate_procedure_act_pdf(MockAct())

        assert result == "https://minio.test/bucket/procedure-acts/test/АКТ-TEST-001.pdf"


class TestMinioUpload:
    @pytest.mark.asyncio
    async def test_upload_returns_none_on_failure(self):
        """_upload_to_minio returns None when boto3/MinIO fails."""
        from app.utils.pdf_generator import _upload_to_minio

        with patch("boto3.client", side_effect=Exception("No MinIO")):
            result = await _upload_to_minio(b"%PDF-test", MockAct())

        assert result is None

"""
PDF generation for veterinary procedure acts.

Generates bilingual (Russian/Kazakh) PDFs using ReportLab.
PDFs are uploaded to MinIO and a pre-signed URL is returned.

Generated document mirrors the paper form (Без названия (4).xls template):
- Header: Ministry + Organization
- Act metadata: number, date, territory, specialist
- Animal summary: species, sex/age counts, total
- Drug info: vaccine/allergen, manufacturer, series, state control
- Expendable materials table (from Без названия (3).xls)
- Animal registry table (from Без названия (5).xls)
- Signature block: veterinarian + owner (from Без названия (6).xls)
"""
import io
import json
import logging
from typing import Optional
from datetime import datetime, timezone

try:
    from reportlab.lib.pagesizes import A4
    from reportlab.lib import colors
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import cm
    from reportlab.platypus import (
        SimpleDocTemplate,
        Paragraph,
        Spacer,
        Table,
        TableStyle,
        HRFlowable,
    )
    from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_RIGHT
    REPORTLAB_AVAILABLE = True
except ImportError:
    REPORTLAB_AVAILABLE = False

logger = logging.getLogger(__name__)

# Kazakhstan government blue
KZ_BLUE = colors.HexColor("#0D47A1")
KZ_LIGHT_BLUE = colors.HexColor("#E3F2FD")


async def generate_procedure_act_pdf(act) -> Optional[str]:
    """
    Generate PDF for a procedure act and upload to MinIO.
    Returns the MinIO URL or None on failure.
    """
    if not REPORTLAB_AVAILABLE:
        logger.warning("ReportLab not installed — PDF generation skipped")
        return None

    try:
        pdf_bytes = _build_pdf(act)
        url = await _upload_to_minio(pdf_bytes, act)
        return url
    except Exception as e:
        logger.error(f"PDF generation failed for act {act.act_number}: {e}")
        return None


def _build_pdf(act) -> bytes:
    """Build the PDF bytes for a procedure act."""
    buffer = io.BytesIO()
    doc = SimpleDocTemplate(
        buffer,
        pagesize=A4,
        rightMargin=2 * cm,
        leftMargin=2 * cm,
        topMargin=2 * cm,
        bottomMargin=2 * cm,
        title=f"Акт {act.act_number}",
    )

    styles = getSampleStyleSheet()
    elements = []

    # ── Header ───────────────────────────────────────────────────────────────
    header_style = ParagraphStyle(
        "header",
        parent=styles["Normal"],
        fontSize=11,
        alignment=TA_CENTER,
        spaceAfter=4,
        fontName="Helvetica-Bold",
    )
    sub_style = ParagraphStyle(
        "sub",
        parent=styles["Normal"],
        fontSize=9,
        alignment=TA_CENTER,
        spaceAfter=2,
    )
    label_style = ParagraphStyle(
        "label",
        parent=styles["Normal"],
        fontSize=9,
        textColor=colors.grey,
    )
    value_style = ParagraphStyle(
        "value",
        parent=styles["Normal"],
        fontSize=10,
        fontName="Helvetica-Bold",
    )

    elements.append(Paragraph(
        "ҚАЗАҚСТАН РЕСПУБЛИКАСЫ АУЫЛ ШАРУАШЫЛЫҒЫ МИНИСТРЛІГІ",
        header_style,
    ))
    elements.append(Paragraph(
        "МИНИСТЕРСТВО СЕЛЬСКОГО ХОЗЯЙСТВА РЕСПУБЛИКИ КАЗАХСТАН",
        sub_style,
    ))
    elements.append(HRFlowable(width="100%", thickness=2, color=KZ_BLUE))
    elements.append(Spacer(1, 0.3 * cm))

    # ── Title ─────────────────────────────────────────────────────────────────
    title_style = ParagraphStyle(
        "title",
        parent=styles["Normal"],
        fontSize=14,
        alignment=TA_CENTER,
        spaceAfter=6,
        fontName="Helvetica-Bold",
        textColor=KZ_BLUE,
    )
    type_label = {
        "vaccination": "ВАКЦИНАЦИЯ / ЕГІП ЖАСАУ",
        "allergy_test": "АЛЛЕРГИЯЛЫҚ ТЕСТ / АЛЛЕРГИЧЕСКИЙ ТЕСТ",
        "deworming": "ДЕГЕЛЬМИНТИЗАЦИЯ / ДЕГЕЛЬМИНТИЗАЦИЯ",
    }.get(act.procedure_type, act.procedure_type.upper())

    elements.append(Paragraph("АКТ / АКТ", title_style))
    elements.append(Paragraph(
        f"о проведении ветеринарного мероприятия<br/>"
        f"<font size='11'>{type_label}</font>",
        ParagraphStyle("subtitle", parent=title_style, fontSize=11, textColor=colors.black),
    ))
    elements.append(Spacer(1, 0.4 * cm))

    # ── Act metadata table ────────────────────────────────────────────────────
    act_date_str = (
        act.act_date.strftime("%d.%m.%Y") if act.act_date else "—"
    )
    meta_data = [
        ["Номер акта / Акт нөмірі:", act.act_number or "—",
         "Дата / Күні:", act_date_str],
        ["Болезнь / Ауру:", act.disease_name or "—",
         "Населённый пункт:", act.settlement or "—"],
        ["Специалист / Маман:", act.specialist_name or "—",
         "Вид животных:", act.species_name or "—"],
        ["Владелец / Иесі:", act.owner_name or "—",
         "ИИН:", act.owner_iin or "—"],
    ]
    meta_table = Table(meta_data, colWidths=[4 * cm, 6 * cm, 4 * cm, 3 * cm])
    meta_table.setStyle(TableStyle([
        ("FONTSIZE", (0, 0), (-1, -1), 9),
        ("TEXTCOLOR", (0, 0), (0, -1), colors.grey),
        ("TEXTCOLOR", (2, 0), (2, -1), colors.grey),
        ("FONTNAME", (1, 0), (1, -1), "Helvetica-Bold"),
        ("FONTNAME", (3, 0), (3, -1), "Helvetica-Bold"),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
        ("TOPPADDING", (0, 0), (-1, -1), 4),
        ("ROWBACKGROUNDS", (0, 0), (-1, -1), [KZ_LIGHT_BLUE, colors.white]),
        ("BOX", (0, 0), (-1, -1), 0.5, colors.lightgrey),
        ("GRID", (0, 0), (-1, -1), 0.3, colors.lightgrey),
    ]))
    elements.append(meta_table)
    elements.append(Spacer(1, 0.4 * cm))

    # ── Animal count table ────────────────────────────────────────────────────
    elements.append(Paragraph(
        "Количество животных / Жануарлар саны",
        ParagraphStyle("section", parent=styles["Normal"], fontSize=10,
                       fontName="Helvetica-Bold", textColor=KZ_BLUE, spaceAfter=4),
    ))
    count_data = [
        ["Самцы / Еркек", "Самки / Ұрғашы", "Молодняк / Жас мал", "Итого / Барлығы"],
        [
            str(act.male_count or 0),
            str(act.female_count or 0),
            str(act.young_count or 0),
            str(act.total_vaccinated or 0),
        ],
    ]
    count_table = Table(count_data, colWidths=[4.25 * cm] * 4)
    count_table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), KZ_BLUE),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
        ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ("FONTSIZE", (0, 0), (-1, -1), 9),
        ("ALIGN", (0, 0), (-1, -1), "CENTER"),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.lightgrey),
        ("FONTNAME", (0, 1), (-1, 1), "Helvetica-Bold"),
        ("FONTSIZE", (0, 1), (-1, 1), 12),
    ]))
    elements.append(count_table)
    elements.append(Spacer(1, 0.4 * cm))

    # ── Vaccine/allergen info ─────────────────────────────────────────────────
    elements.append(Paragraph(
        "Препарат / Препарат",
        ParagraphStyle("section", parent=styles["Normal"], fontSize=10,
                       fontName="Helvetica-Bold", textColor=KZ_BLUE, spaceAfter=4),
    ))
    vaccine_name = act.vaccine_name or act.allergen_name or "—"
    drug_data = [
        ["Наименование / Атауы:", vaccine_name],
        ["Производитель / Өндіруші:", act.manufacturer or "—"],
        ["Серия / Сериясы:", act.series or "—"],
        ["№ гос. контроля:", act.state_control_no or "—"],
        ["Метод введения:", act.injection_method or "—"],
        ["Доза (взр./мол.) мл:", f"{act.dose_adult_ml or '—'} / {act.dose_young_ml or '—'}"],
    ]
    drug_table = Table(drug_data, colWidths=[5 * cm, 12 * cm])
    drug_table.setStyle(TableStyle([
        ("FONTSIZE", (0, 0), (-1, -1), 9),
        ("TEXTCOLOR", (0, 0), (0, -1), colors.grey),
        ("FONTNAME", (1, 0), (1, -1), "Helvetica-Bold"),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 3),
        ("TOPPADDING", (0, 0), (-1, -1), 3),
        ("ROWBACKGROUNDS", (0, 0), (-1, -1), [KZ_LIGHT_BLUE, colors.white]),
        ("BOX", (0, 0), (-1, -1), 0.5, colors.lightgrey),
    ]))
    elements.append(drug_table)
    elements.append(Spacer(1, 0.4 * cm))

    # ── Expendable materials (Без названия (3).xls) ───────────────────────────
    materials = []
    if act.materials_json:
        try:
            materials = json.loads(act.materials_json)
        except Exception:
            pass

    if materials:
        elements.append(Paragraph(
            "Расходные материалы / Шығыс материалдары",
            ParagraphStyle("section", parent=styles["Normal"], fontSize=10,
                           fontName="Helvetica-Bold", textColor=KZ_BLUE, spaceAfter=4),
        ))
        mat_data = [["Наименование", "Количество", "Ед. изм."]]
        for m in materials:
            mat_data.append([m.get("name", ""), str(m.get("quantity", "")), m.get("unit", "")])
        mat_table = Table(mat_data, colWidths=[10 * cm, 4 * cm, 3 * cm])
        mat_table.setStyle(TableStyle([
            ("BACKGROUND", (0, 0), (-1, 0), KZ_BLUE),
            ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
            ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
            ("FONTSIZE", (0, 0), (-1, -1), 9),
            ("GRID", (0, 0), (-1, -1), 0.3, colors.lightgrey),
        ]))
        elements.append(mat_table)
        elements.append(Spacer(1, 0.4 * cm))

    # ── Signature block (Без названия (6).xls) ───────────────────────────────
    elements.append(Spacer(1, 1 * cm))
    sig_data = [
        [
            "Ветеринарный специалист / Ветеринариялық маман",
            "Владелец животных / Мал иесі",
        ],
        ["", ""],
        ["_______________________________", "_______________________________"],
        ["(қолы / подпись)", "(қолы / подпись)"],
    ]
    sig_table = Table(sig_data, colWidths=[8.5 * cm, 8.5 * cm])
    sig_table.setStyle(TableStyle([
        ("FONTSIZE", (0, 0), (-1, -1), 9),
        ("ALIGN", (0, 0), (-1, -1), "CENTER"),
        ("TEXTCOLOR", (0, 3), (-1, 3), colors.grey),
        ("TOPPADDING", (0, 2), (-1, 2), 0),
        ("BOTTOMPADDING", (0, 2), (-1, 2), 0),
    ]))
    elements.append(sig_table)

    # ── EDS stamp ─────────────────────────────────────────────────────────────
    if act.status == "signed" and act.signed_at:
        elements.append(Spacer(1, 0.5 * cm))
        elements.append(Paragraph(
            f"✓ ЭЦП подписан: {act.signed_at.strftime('%d.%m.%Y %H:%M')} UTC",
            ParagraphStyle("eds", parent=styles["Normal"], fontSize=8,
                           textColor=colors.green, alignment=TA_RIGHT),
        ))

    doc.build(elements)
    return buffer.getvalue()


async def _upload_to_minio(pdf_bytes: bytes, act) -> Optional[str]:
    """Upload PDF to MinIO and return pre-signed URL."""
    try:
        import boto3
        from botocore.client import Config
        from app.config import settings

        s3 = boto3.client(
            "s3",
            endpoint_url=settings.MINIO_ENDPOINT,
            aws_access_key_id=settings.MINIO_ACCESS_KEY,
            aws_secret_access_key=settings.MINIO_SECRET_KEY,
            config=Config(signature_version="s3v4"),
        )

        bucket = settings.MINIO_BUCKET
        key = f"procedure-acts/{act.id}/{act.act_number}.pdf"

        s3.put_object(
            Bucket=bucket,
            Key=key,
            Body=pdf_bytes,
            ContentType="application/pdf",
        )

        url = s3.generate_presigned_url(
            "get_object",
            Params={"Bucket": bucket, "Key": key},
            ExpiresIn=3600 * 24,  # 24 hours
        )
        logger.info(f"PDF uploaded: {key}")
        return url
    except Exception as e:
        logger.error(f"MinIO upload failed: {e}")
        return None

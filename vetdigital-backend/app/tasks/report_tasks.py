"""Report and document generation tasks."""
from app.tasks.celery_app import celery_app


@celery_app.task(name="app.tasks.report_tasks.generate_procedure_pdf")
def generate_procedure_pdf(act_id: str, language: str = "ru"):
    """Generate a bilingual (KK/RU) PDF for a procedure act and upload to MinIO."""
    # TODO: Phase 3 - Full PDF generation using reportlab
    print(f"PDF generation for act {act_id} in language {language}")
    return {"status": "queued", "act_id": act_id}

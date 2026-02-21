"""Smart Bridge / ISZH data synchronization tasks."""
from app.tasks.celery_app import celery_app


@celery_app.task(name="app.tasks.sync_tasks.sync_iszh_animals")
def sync_iszh_animals():
    """
    Scheduled task: Sync animal identification data from iszh.gov.kz via Smart Bridge.
    Runs every 6 hours.
    TODO: Phase 5 - Implement actual Smart Bridge API calls.
    """
    print("ISZH sync task running (Phase 5 implementation pending)")
    return {"status": "skipped", "reason": "Smart Bridge integration pending Phase 5"}

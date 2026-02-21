from celery import Celery
from celery.schedules import crontab
from app.config import settings

celery_app = Celery(
    "vetdigital",
    broker=settings.CELERY_BROKER_URL,
    backend=settings.CELERY_RESULT_BACKEND,
    include=[
        "app.tasks.gps_tasks",
        "app.tasks.sync_tasks",
        "app.tasks.report_tasks",
        "app.tasks.notification_tasks",
    ],
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="Asia/Almaty",
    enable_utc=True,
    task_track_started=True,
    task_acks_late=True,
    worker_prefetch_multiplier=1,
)

# Scheduled tasks
celery_app.conf.beat_schedule = {
    # Sync animal data from ISZH every 6 hours
    "sync-iszh-every-6h": {
        "task": "app.tasks.sync_tasks.sync_iszh_animals",
        "schedule": crontab(minute=0, hour="*/6"),
    },
    # Check geofence violations every minute
    "check-geofence-violations": {
        "task": "app.tasks.gps_tasks.check_geofence_violations",
        "schedule": 60.0,  # every 60 seconds
    },
    # Send vaccination reminders daily at 9am Almaty time
    "vaccination-reminders": {
        "task": "app.tasks.notification_tasks.send_vaccination_reminders",
        "schedule": crontab(minute=0, hour=9),
    },
}

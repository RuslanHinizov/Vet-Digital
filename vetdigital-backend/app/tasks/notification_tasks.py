"""
Push notification tasks using Firebase Cloud Messaging (FCM).

Prerequisites:
  1. Place firebase-credentials.json in project root (or set FIREBASE_CREDENTIALS_PATH).
  2. firebase-admin already in requirements/base.txt.
  3. FCM token stored in users.fcm_token column.
"""
import logging
import os
from typing import Optional

from app.tasks.celery_app import celery_app
from app.config import settings

logger = logging.getLogger(__name__)

_firebase_initialized = False
_firebase_app = None


def _get_firebase_app():
    global _firebase_initialized, _firebase_app
    if _firebase_initialized:
        return _firebase_app
    try:
        import firebase_admin
        from firebase_admin import credentials
        cred_path = settings.FIREBASE_CREDENTIALS_PATH
        if not os.path.isfile(cred_path):
            logger.warning("Firebase credentials not found at %s. Push notifications disabled.", cred_path)
            _firebase_initialized = True
            _firebase_app = None
            return None
        cred = credentials.Certificate(cred_path)
        _firebase_app = firebase_admin.initialize_app(cred)
        logger.info("Firebase Admin SDK initialised.")
    except Exception as exc:
        logger.error("Failed to initialise Firebase Admin SDK: %s", exc)
        _firebase_app = None
    _firebase_initialized = True
    return _firebase_app


@celery_app.task(
    name="app.tasks.notification_tasks.send_push_notification",
    bind=True, max_retries=3, default_retry_delay=30,
)
def send_push_notification(
    self, fcm_token: str, title: str, body: str,
    data: Optional[dict] = None, image_url: Optional[str] = None,
) -> dict:
    """Send a single FCM push notification to one device."""
    if not fcm_token:
        return {"status": "error", "detail": "Empty FCM token"}
    app = _get_firebase_app()
    if app is None:
        return {"status": "disabled"}
    try:
        from firebase_admin import messaging
        str_data = {k: str(v) for k, v in (data or {}).items()}
        message = messaging.Message(
            notification=messaging.Notification(title=title, body=body, image=image_url),
            data=str_data,
            token=fcm_token,
            android=messaging.AndroidConfig(
                priority="high",
                notification=messaging.AndroidNotification(
                    sound="default", click_action="FLUTTER_NOTIFICATION_CLICK"
                ),
            ),
            apns=messaging.APNSConfig(
                payload=messaging.APNSPayload(aps=messaging.Aps(sound="default"))
            ),
        )
        message_id = messaging.send(message)
        logger.info("FCM sent to %s: %s", fcm_token[:10], message_id)
        return {"status": "sent", "message_id": message_id}
    except Exception as exc:
        logger.error("FCM send failed: %s", exc)
        try:
            raise self.retry(exc=exc)
        except self.MaxRetriesExceededError:
            return {"status": "error", "detail": str(exc)}


@celery_app.task(
    name="app.tasks.notification_tasks.send_multicast_notification",
    bind=True, max_retries=2, default_retry_delay=60,
)
def send_multicast_notification(
    self, fcm_tokens: list, title: str, body: str, data: Optional[dict] = None,
) -> dict:
    """Send one notification to multiple devices (max 500 tokens per batch)."""
    if not fcm_tokens:
        return {"status": "error", "detail": "No FCM tokens"}
    app = _get_firebase_app()
    if app is None:
        return {"status": "disabled"}
    try:
        from firebase_admin import messaging
        str_data = {k: str(v) for k, v in (data or {}).items()}
        total_success, total_failure = 0, 0
        for i in range(0, len(fcm_tokens), 500):
            batch = fcm_tokens[i: i + 500]
            msg = messaging.MulticastMessage(
                notification=messaging.Notification(title=title, body=body),
                data=str_data, tokens=batch,
            )
            response = messaging.send_each_for_multicast(msg)
            total_success += response.success_count
            total_failure += response.failure_count
        logger.info("FCM multicast: %d sent, %d failed", total_success, total_failure)
        return {"status": "sent", "success_count": total_success, "failure_count": total_failure}
    except Exception as exc:
        logger.error("FCM multicast failed: %s", exc)
        try:
            raise self.retry(exc=exc)
        except self.MaxRetriesExceededError:
            return {"status": "error", "detail": str(exc)}


@celery_app.task(name="app.tasks.notification_tasks.send_vaccination_reminders")
def send_vaccination_reminders() -> dict:
    """Daily Celery beat task: remind vets of annual vaccination boosters due."""
    try:
        import asyncio
        from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
        from sqlalchemy.orm import sessionmaker
        from sqlalchemy import text

        async def _run():
            engine = create_async_engine(settings.DATABASE_URL, echo=False)
            factory = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
            rows = []
            async with factory() as db:
                result = await db.execute(text(
                    "SELECT DISTINCT u.fcm_token AS fcm_token, u.language_pref AS lang, "
                    "a.identification_no AS animal_no "
                    "FROM procedure_acts pa "
                    "JOIN users u ON u.id = pa.veterinarian_id "
                    "JOIN procedure_act_animals paa ON paa.procedure_act_id = pa.id "
                    "JOIN animals a ON a.id = paa.animal_id "
                    "WHERE pa.procedure_type = 'vaccination' AND pa.status = 'signed' "
                    "AND pa.act_date BETWEEN CURRENT_DATE - INTERVAL '380 days' "
                    "AND CURRENT_DATE - INTERVAL '358 days' "
                    "AND u.fcm_token IS NOT NULL AND u.is_active = true LIMIT 200"
                ))
                rows = result.fetchall()
            await engine.dispose()
            return rows

        rows = asyncio.run(_run())
        sent = 0
        for row in rows:
            lang = row.lang or "ru"
            if lang == "kk":
                title = "Егу еске салу"
                body = f"No{row.animal_no} мал үшін жылдық егу мерзімі келді."
            else:
                title = "Напоминание о вакцинации"
                body = f"Для животного No{row.animal_no} наступил срок ежегодной вакцинации."
            send_push_notification.delay(
                fcm_token=row.fcm_token, title=title, body=body,
                data={"type": "vaccination_reminder", "animal_no": row.animal_no},
            )
            sent += 1
        logger.info("Vaccination reminders queued: %d", sent)
        return {"status": "ok", "reminders_sent": sent}
    except Exception as exc:
        logger.error("send_vaccination_reminders failed: %s", exc)
        return {"status": "error", "detail": str(exc)}


@celery_app.task(name="app.tasks.notification_tasks.notify_geofence_alert")
def notify_geofence_alert(
    fcm_token: str, animal_no: str, geofence_name: str,
    alert_type: str, lang: str = "ru",
) -> dict:
    """Called by GPS IoT worker when a geofence violation is detected."""
    if lang == "kk":
        title = (f"Геоқоршаудан шығу: {animal_no}" if alert_type == "exit"
                 else f"Геоқоршауға кіру: {animal_no}")
        body = (f"Мал '{geofence_name}' аумағынан шықты." if alert_type == "exit"
                else f"Мал '{geofence_name}' аумағына кірді.")
    else:
        title = (f"Выход из геозоны: {animal_no}" if alert_type == "exit"
                 else f"Вход в геозону: {animal_no}")
        body = (f"Животное покинуло зону '{geofence_name}'." if alert_type == "exit"
                else f"Животное вошло в зону '{geofence_name}'.")
    return send_push_notification.delay(
        fcm_token=fcm_token, title=title, body=body,
        data={"type": "geofence_alert", "alert_type": alert_type,
              "animal_no": animal_no, "geofence_name": geofence_name},
    )


@celery_app.task(name="app.tasks.notification_tasks.notify_document_signed")
def notify_document_signed(fcm_token: str, act_number: str, lang: str = "ru") -> dict:
    """Notify veterinarian that a procedure act has been signed."""
    if lang == "kk":
        title, body = "Кұжат қол қойылды", f"No{act_number} акт қол қойылды."
    else:
        title, body = "Документ подписан", f"Акт No{act_number} успешно подписан."
    return send_push_notification.delay(
        fcm_token=fcm_token, title=title, body=body,
        data={"type": "document_signed", "act_number": act_number},
    )

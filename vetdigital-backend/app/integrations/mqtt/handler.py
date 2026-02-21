"""
MQTT handler for GPS device telemetry.
Subscribes to vetdigital/gps/+/telemetry and processes incoming GPS data.

Run standalone with: python -m app.integrations.mqtt.handler
"""
import asyncio
import json
import logging
from datetime import datetime, timezone

logger = logging.getLogger(__name__)


async def process_gps_message(device_serial: str, payload: dict):
    """Process an incoming GPS telemetry message from an IoT device."""
    from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
    from sqlalchemy import select, update
    from app.config import settings
    from app.models.gps import GPSDevice, GPSReading

    required = {"latitude", "longitude", "timestamp"}
    if not required.issubset(payload.keys()):
        logger.warning(f"GPS message missing fields: {payload}")
        return

    try:
        lat = float(payload["latitude"])
        lon = float(payload["longitude"])
        timestamp = payload["timestamp"]
        speed = float(payload.get("speed", 0))
        heading = float(payload.get("heading", 0))
        accuracy = float(payload.get("accuracy", 0))
        battery = int(payload.get("battery", -1))
    except (ValueError, TypeError) as e:
        logger.error(f"Invalid GPS payload: {e}")
        return

    engine = create_async_engine(settings.DATABASE_URL)
    async_session = async_sessionmaker(engine, expire_on_commit=False)

    async with async_session() as session:
        # Look up device
        result = await session.execute(
            select(GPSDevice).where(GPSDevice.device_serial == device_serial)
        )
        device = result.scalar_one_or_none()

        if not device:
            logger.warning(f"Unknown GPS device: {device_serial}")
            await engine.dispose()
            return

        # Store GPS reading
        reading = GPSReading(
            time=timestamp,
            device_id=device.id,
            animal_id=device.animal_id or "",
            latitude=lat,
            longitude=lon,
            speed=speed,
            heading=heading,
            accuracy=accuracy,
            battery=battery if battery >= 0 else None,
        )
        session.add(reading)

        # Update device last-known position
        device.last_latitude = lat
        device.last_longitude = lon
        device.last_seen_at = datetime.now(timezone.utc).isoformat()
        if battery >= 0:
            device.battery_level = battery

        await session.commit()
        logger.info(f"GPS: {device_serial} -> ({lat:.6f}, {lon:.6f})")

    await engine.dispose()


async def run_mqtt_worker():
    """Main MQTT subscriber loop."""
    try:
        import aiomqtt
    except ImportError:
        logger.error("aiomqtt not installed. Run: pip install aiomqtt")
        return

    from app.config import settings

    logger.info(f"Connecting to MQTT broker at {settings.MQTT_BROKER_HOST}:{settings.MQTT_BROKER_PORT}")

    async with aiomqtt.Client(
        hostname=settings.MQTT_BROKER_HOST,
        port=settings.MQTT_BROKER_PORT,
        username=settings.MQTT_USERNAME,
        password=settings.MQTT_PASSWORD,
    ) as client:
        await client.subscribe("vetdigital/gps/+/telemetry")
        logger.info("Subscribed to vetdigital/gps/+/telemetry")

        async for message in client.messages:
            topic_parts = str(message.topic).split("/")
            if len(topic_parts) >= 4:
                device_serial = topic_parts[2]
                try:
                    payload = json.loads(message.payload.decode())
                    await process_gps_message(device_serial, payload)
                except json.JSONDecodeError:
                    logger.error(f"Invalid JSON from {device_serial}: {message.payload}")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.run(run_mqtt_worker())

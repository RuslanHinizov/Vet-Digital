"""
Geospatial utility functions.
Used for distance calculations, GeoJSON validation, and coordinate helpers.
"""
import json
import math
from typing import Optional
from shapely.geometry import shape, Point, mapping
from shapely.ops import unary_union


def haversine_distance(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """
    Calculate great-circle distance between two GPS points in kilometers.
    Uses Haversine formula.
    """
    R = 6371.0  # Earth radius in km
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    d_phi = math.radians(lat2 - lat1)
    d_lam = math.radians(lon2 - lon1)

    a = math.sin(d_phi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(d_lam / 2) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return R * c


def point_in_geofence(lat: float, lon: float, geojson_str: str) -> bool:
    """
    Check if a GPS point is inside a GeoJSON polygon.
    GeoJSON uses (longitude, latitude) order.
    """
    try:
        geojson = json.loads(geojson_str)
        polygon = shape(geojson)
        point = Point(lon, lat)  # GeoJSON order: (lng, lat)
        return polygon.contains(point)
    except Exception:
        return False


def validate_geojson_polygon(geojson_str: str) -> tuple[bool, Optional[str]]:
    """
    Validate that a string is a valid GeoJSON Polygon.
    Returns (is_valid, error_message).
    """
    try:
        geojson = json.loads(geojson_str)
        if geojson.get("type") not in ("Polygon", "MultiPolygon"):
            return False, "GeoJSON must be a Polygon or MultiPolygon"
        polygon = shape(geojson)
        if not polygon.is_valid:
            return False, f"Invalid polygon geometry: {polygon.explain_validity()}"
        if polygon.area == 0:
            return False, "Polygon has zero area"
        return True, None
    except json.JSONDecodeError:
        return False, "Invalid JSON"
    except Exception as e:
        return False, str(e)


def calculate_polygon_area_sqkm(geojson_str: str) -> float:
    """
    Calculate approximate area of a GeoJSON polygon in km².
    Note: Uses simple equirectangular projection — accurate enough for small areas in Kazakhstan.
    """
    try:
        geojson = json.loads(geojson_str)
        polygon = shape(geojson)
        # Approximate: 1 degree ≈ 111 km
        return polygon.area * 111 * 111
    except Exception:
        return 0.0


def points_to_geojson_polygon(points: list[tuple[float, float]]) -> str:
    """
    Convert list of (lat, lon) tuples to GeoJSON Polygon string.
    Automatically closes the ring.
    """
    coords = [[lon, lat] for lat, lon in points]
    if coords and coords[0] != coords[-1]:
        coords.append(coords[0])  # Close the ring

    return json.dumps({
        "type": "Polygon",
        "coordinates": [coords],
    })


def geojson_to_wkt(geojson_str: str) -> str:
    """Convert GeoJSON string to WKT format (for PostGIS queries)."""
    try:
        geojson = json.loads(geojson_str)
        return shape(geojson).wkt
    except Exception:
        return ""


def compute_track_distance(readings: list[dict]) -> float:
    """
    Calculate total distance of a GPS track in km.
    readings: list of dicts with 'latitude' and 'longitude' keys.
    """
    if len(readings) < 2:
        return 0.0
    total = 0.0
    for i in range(1, len(readings)):
        total += haversine_distance(
            readings[i - 1]["latitude"],
            readings[i - 1]["longitude"],
            readings[i]["latitude"],
            readings[i]["longitude"],
        )
    return round(total, 3)


def kato_to_region_name(kato: str) -> str:
    """Map Kazakhstan KATO code prefix to oblast name."""
    _kato_map = {
        "191": "Абай облысы",
        "231": "Ақмола облысы",
        "111": "Ақтөбе облысы",
        "151": "Алматы облысы",
        "711": "Алматы қаласы",
        "191": "Алматы облысы",
        "271": "Атырау облысы",
        "231": "Батыс Қазақстан облысы",
        "311": "Жамбыл облысы",
        "351": "Жетісу облысы",
        "351": "Жетісу облысы",
        "411": "Қарағанды облысы",
        "451": "Қостанай облысы",
        "491": "Қызылорда облысы",
        "531": "Маңғыстау облысы",
        "751": "Нұр-Сұлтан қаласы",
        "591": "Павлодар облысы",
        "631": "Солтүстік Қазақстан облысы",
        "711": "Алматы қаласы",
        "751": "Астана қаласы",
        "791": "Шымкент қаласы",
        "791": "Шымкент қаласы",
        "151": "Алматы облысы",
        "671": "Түркістан облысы",
        "611": "Ұлытау облысы",
        "551": "Шығыс Қазақстан облысы",
    }
    prefix = kato[:3] if len(kato) >= 3 else kato
    return _kato_map.get(prefix, kato)

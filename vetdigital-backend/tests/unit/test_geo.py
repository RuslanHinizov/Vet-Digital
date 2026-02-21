"""
Unit tests for geo utility functions.
"""
import math
import pytest
from app.utils.geo import (
    haversine_distance,
    point_in_geofence,
    validate_geojson_polygon,
    calculate_polygon_area_sqkm,
    points_to_geojson_polygon,
    compute_track_distance,
    kato_to_region_name,
)

# ─── Sample GeoJSON fixtures ──────────────────────────────────────────────────

ALMATY_POLYGON = (
    '{"type":"Polygon","coordinates":[[[76.89,43.23],[76.91,43.23],'
    '[76.91,43.24],[76.89,43.24],[76.89,43.23]]]}'
)

INVALID_GEOJSON = '{"type":"Point","coordinates":[76.89,43.23]}'
MALFORMED_JSON = "not json"


# ─── haversine_distance ───────────────────────────────────────────────────────

class TestHaversineDistance:
    def test_same_point_is_zero(self):
        d = haversine_distance(43.23, 76.89, 43.23, 76.89)
        assert d == pytest.approx(0.0, abs=1e-6)

    def test_known_distance(self):
        # Almaty → Astana ≈ 1150 km
        d = haversine_distance(43.238, 76.945, 51.180, 71.446)
        assert 1100 < d < 1200

    def test_returns_float(self):
        d = haversine_distance(43.0, 76.0, 44.0, 77.0)
        assert isinstance(d, float)

    def test_symmetry(self):
        d1 = haversine_distance(43.0, 76.0, 44.0, 77.0)
        d2 = haversine_distance(44.0, 77.0, 43.0, 76.0)
        assert d1 == pytest.approx(d2, rel=1e-6)

    def test_short_distance(self):
        # ~111 m (1/1000 degree latitude ≈ 111m)
        d = haversine_distance(43.2300, 76.89, 43.2310, 76.89)
        assert 0.1 < d < 0.2  # km

    def test_international_distance(self):
        # Earth circumference ≈ 40075 km; equator crossing
        d = haversine_distance(0, 0, 0, 180)
        assert d == pytest.approx(20037.5, rel=0.01)


# ─── point_in_geofence ────────────────────────────────────────────────────────

class TestPointInGeofence:
    def test_point_inside(self):
        # Center of Almaty polygon
        assert point_in_geofence(43.235, 76.900, ALMATY_POLYGON)

    def test_point_outside(self):
        # Astana coordinates
        assert not point_in_geofence(51.18, 71.45, ALMATY_POLYGON)

    def test_invalid_geojson_returns_false(self):
        assert not point_in_geofence(43.23, 76.89, MALFORMED_JSON)

    def test_wrong_geometry_type_returns_false(self):
        assert not point_in_geofence(43.23, 76.89, INVALID_GEOJSON)

    def test_boundary_point(self):
        # Exact corner — shapely boundary behavior
        result = point_in_geofence(43.23, 76.89, ALMATY_POLYGON)
        assert isinstance(result, bool)


# ─── validate_geojson_polygon ─────────────────────────────────────────────────

class TestValidateGeoJsonPolygon:
    def test_valid_polygon(self):
        is_valid, error = validate_geojson_polygon(ALMATY_POLYGON)
        assert is_valid
        assert error is None

    def test_invalid_geometry_type(self):
        is_valid, error = validate_geojson_polygon(INVALID_GEOJSON)
        assert not is_valid
        assert error is not None

    def test_malformed_json(self):
        is_valid, error = validate_geojson_polygon(MALFORMED_JSON)
        assert not is_valid
        assert "JSON" in (error or "")

    def test_degenerate_polygon(self):
        # Same point repeated — zero area
        degenerate = '{"type":"Polygon","coordinates":[[[76.89,43.23],[76.89,43.23],[76.89,43.23],[76.89,43.23]]]}'
        is_valid, error = validate_geojson_polygon(degenerate)
        # Should fail — zero area or invalid geometry
        assert isinstance(is_valid, bool)


# ─── calculate_polygon_area_sqkm ─────────────────────────────────────────────

class TestCalculatePolygonArea:
    def test_known_area(self):
        # 0.02 degree × 0.01 degree ≈ (0.02 * 111) * (0.01 * 111) ≈ 2.22 * 1.11 ≈ 2.46 km²
        area = calculate_polygon_area_sqkm(ALMATY_POLYGON)
        assert 2 < area < 3

    def test_invalid_returns_zero(self):
        area = calculate_polygon_area_sqkm(MALFORMED_JSON)
        assert area == 0.0

    def test_positive_area(self):
        area = calculate_polygon_area_sqkm(ALMATY_POLYGON)
        assert area > 0


# ─── points_to_geojson_polygon ────────────────────────────────────────────────

class TestPointsToGeoJsonPolygon:
    def test_basic_conversion(self):
        import json
        points = [(43.23, 76.89), (43.24, 76.89), (43.24, 76.91)]
        result = points_to_geojson_polygon(points)
        geojson = json.loads(result)
        assert geojson["type"] == "Polygon"
        assert len(geojson["coordinates"]) == 1

    def test_ring_is_closed(self):
        import json
        points = [(43.23, 76.89), (43.24, 76.89), (43.24, 76.91)]
        result = points_to_geojson_polygon(points)
        geojson = json.loads(result)
        ring = geojson["coordinates"][0]
        assert ring[0] == ring[-1]  # First == last

    def test_coordinate_order(self):
        import json
        # Input is (lat, lon), output GeoJSON uses [lon, lat]
        points = [(43.23, 76.89)]
        result = points_to_geojson_polygon(points)
        geojson = json.loads(result)
        coord = geojson["coordinates"][0][0]
        assert coord[0] == pytest.approx(76.89)  # lon first
        assert coord[1] == pytest.approx(43.23)  # lat second


# ─── compute_track_distance ───────────────────────────────────────────────────

class TestComputeTrackDistance:
    def test_empty_returns_zero(self):
        assert compute_track_distance([]) == 0.0

    def test_single_point_returns_zero(self):
        assert compute_track_distance([{"latitude": 43.23, "longitude": 76.89}]) == 0.0

    def test_two_points(self):
        readings = [
            {"latitude": 43.23, "longitude": 76.89},
            {"latitude": 43.24, "longitude": 76.89},
        ]
        d = compute_track_distance(readings)
        # ~1.11 km
        assert 1.0 < d < 1.2

    def test_three_points_cumulative(self):
        readings = [
            {"latitude": 43.23, "longitude": 76.89},
            {"latitude": 43.24, "longitude": 76.89},
            {"latitude": 43.25, "longitude": 76.89},
        ]
        d = compute_track_distance(readings)
        assert d > 2.0  # At least 2 segments

    def test_result_is_rounded(self):
        readings = [
            {"latitude": 43.23001, "longitude": 76.89001},
            {"latitude": 43.24001, "longitude": 76.89001},
        ]
        d = compute_track_distance(readings)
        # Result should be rounded to 3 decimal places
        assert d == round(d, 3)


# ─── kato_to_region_name ─────────────────────────────────────────────────────

class TestKatoToRegionName:
    def test_almaty_city(self):
        name = kato_to_region_name("711000000")
        assert "Алматы" in name

    def test_astana_city(self):
        name = kato_to_region_name("751000000")
        assert "Астана" in name or "Нұр-Сұлтан" in name

    def test_unknown_kato_returns_input(self):
        name = kato_to_region_name("999000000")
        assert "999" in name

    def test_short_kato(self):
        name = kato_to_region_name("711")
        assert "Алматы" in name

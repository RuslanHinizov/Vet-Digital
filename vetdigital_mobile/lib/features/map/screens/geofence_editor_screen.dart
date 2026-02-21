import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_colors.dart';

/// Interactive geofence polygon drawing screen.
/// User taps on the map to add polygon vertices.
/// Phase 4 implementation: saves to backend API.
class GeofenceEditorScreen extends StatefulWidget {
  const GeofenceEditorScreen({super.key});

  @override
  State<GeofenceEditorScreen> createState() => _GeofenceEditorScreenState();
}

class _GeofenceEditorScreenState extends State<GeofenceEditorScreen> {
  final MapController _mapController = MapController();
  final List<LatLng> _polygonPoints = [];
  String _selectedType = 'pasture';
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать геозону'),
        actions: [
          if (_polygonPoints.length >= 3)
            TextButton(
              onPressed: _saveGeofence,
              child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Column(
        children: [
          // Geofence settings panel
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Название геозоны',
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedType,
                  items: const [
                    DropdownMenuItem(value: 'pasture', child: Text('Пастбище')),
                    DropdownMenuItem(value: 'farm', child: Text('Ферма')),
                    DropdownMenuItem(value: 'quarantine_zone', child: Text('Карантин')),
                    DropdownMenuItem(value: 'restricted', child: Text('Запрет. зона')),
                  ],
                  onChanged: (v) => setState(() => _selectedType = v!),
                ),
              ],
            ),
          ),

          // Instructions
          Container(
            color: AppColors.info.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.touch_app, size: 16, color: AppColors.info),
                const SizedBox(width: 8),
                Text(
                  _polygonPoints.isEmpty
                      ? 'Нажмите на карту для добавления точек геозоны'
                      : '${_polygonPoints.length} точек. '
                        '${_polygonPoints.length >= 3 ? "Нажмите Сохранить" : "Добавьте минимум 3 точки"}',
                  style: const TextStyle(fontSize: 12, color: AppColors.info),
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(AppConfig.defaultMapLatitude, AppConfig.defaultMapLongitude),
                initialZoom: 12,
                onTap: (_, point) => _addPoint(point),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'kz.gov.vetdigital.app',
                ),
                // Draw polygon
                if (_polygonPoints.length >= 3)
                  PolygonLayer(polygons: [
                    Polygon(
                      points: _polygonPoints,
                      color: _getTypeColor().withOpacity(0.3),
                      borderColor: _getTypeColor(),
                      borderStrokeWidth: 2,
                      isFilled: true,
                    ),
                  ]),
                // Draw lines between points
                if (_polygonPoints.length >= 2)
                  PolylineLayer(polylines: [
                    Polyline(points: _polygonPoints, color: _getTypeColor(), strokeWidth: 2),
                  ]),
                // Point markers
                MarkerLayer(
                  markers: _polygonPoints.asMap().entries.map((e) => Marker(
                    point: e.value,
                    child: GestureDetector(
                      onTap: () => _removePoint(e.key),
                      child: Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          color: _getTypeColor(),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '${e.key + 1}',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Bottom toolbar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _polygonPoints.isEmpty ? null : _undoLastPoint,
                    icon: const Icon(Icons.undo),
                    label: const Text('Удалить последнюю'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _polygonPoints.isEmpty ? null : _clearAll,
                    icon: const Icon(Icons.clear),
                    label: const Text('Очистить'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addPoint(LatLng point) {
    setState(() => _polygonPoints.add(point));
  }

  void _removePoint(int index) {
    setState(() => _polygonPoints.removeAt(index));
  }

  void _undoLastPoint() {
    if (_polygonPoints.isNotEmpty) {
      setState(() => _polygonPoints.removeLast());
    }
  }

  void _clearAll() => setState(() => _polygonPoints.clear());

  Color _getTypeColor() {
    switch (_selectedType) {
      case 'farm': return AppColors.geofenceFarm;
      case 'quarantine_zone': return AppColors.geofenceQuarantine;
      case 'restricted': return AppColors.geofenceRestricted;
      default: return AppColors.geofencePasture;
    }
  }

  void _saveGeofence() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название геозоны')),
      );
      return;
    }

    // Build GeoJSON polygon
    final coordinates = _polygonPoints
        .map((p) => [p.longitude, p.latitude])
        .toList();
    coordinates.add(coordinates.first); // Close polygon

    // TODO: Phase 4 - POST to /api/v1/geofences
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Геозона "${_nameController.text}" сохранена (Phase 4 API)')),
    );
    Navigator.pop(context);
  }
}

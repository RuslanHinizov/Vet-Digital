import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/map/cached_tile_provider.dart';
import '../../../core/network/websocket_client.dart';
import '../../../providers/geofence_providers.dart';

/// Live map screen showing real-time animal GPS locations.
/// Uses OpenStreetMap tiles (free, works offline with local file cache).
/// Real-time updates come via WebSocket (GpsWebSocketClient).
class LiveMapScreen extends ConsumerStatefulWidget {
  const LiveMapScreen({super.key});

  @override
  ConsumerState<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends ConsumerState<LiveMapScreen> {
  final MapController _mapController = MapController();
  bool _showGeofences = true;
  bool _showAnimals = true;

  // Cached tile provider (persists tiles on disk)
  final _tileProvider = CachedOsmTileProvider();

  // Kazakhstan center
  static const LatLng _kazakhstanCenter = LatLng(
    AppConfig.defaultMapLatitude,
    AppConfig.defaultMapLongitude,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта животных'),
        actions: [
          // Toggle geofences visibility
          IconButton(
            icon: Icon(_showGeofences ? Icons.fence : Icons.fence_outlined),
            tooltip: 'Показать/скрыть геозоны',
            onPressed: () => setState(() => _showGeofences = !_showGeofences),
          ),
          // Add geofence button
          IconButton(
            icon: const Icon(Icons.add_location_alt),
            tooltip: 'Создать геозону',
            onPressed: () => context.go('/map/geofence-editor'),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _kazakhstanCenter,
              initialZoom: AppConfig.defaultMapZoom,
              maxZoom: 18,
              minZoom: 3,
            ),
            children: [
              // OpenStreetMap tiles with offline file cache
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'kz.gov.vetdigital.app',
                tileProvider: _tileProvider,
                fallbackUrl: 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),

              // Geofence polygons
              if (_showGeofences)
                PolygonLayer(
                  polygons: _buildGeofencePolygons(),
                ),

              // Animal GPS markers
              if (_showAnimals)
                MarkerLayer(
                  markers: _buildAnimalMarkers(),
                ),
            ],
          ),

          // Legend
          Positioned(
            bottom: 16,
            right: 16,
            child: _MapLegend(),
          ),

          // Offline indicator
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_done, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text('Онлайн', style: TextStyle(color: Colors.white, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Polygon> _buildGeofencePolygons() {
    final geofenceState = ref.watch(geofenceListProvider);
    if (geofenceState.geofences.isEmpty) {
      // Demo polygon while loading
      return [
        Polygon(
          points: const [
            LatLng(43.23, 76.89),
            LatLng(43.24, 76.89),
            LatLng(43.24, 76.91),
            LatLng(43.23, 76.91),
          ],
          color: AppColors.geofencePasture.withOpacity(0.2),
          borderColor: AppColors.geofencePasture,
          borderStrokeWidth: 2,
          isFilled: true,
        ),
      ];
    }

    return geofenceState.geofences.map((g) {
      final color = switch (g.geofenceType) {
        'quarantine_zone' => AppColors.geofenceQuarantine,
        'farm' => AppColors.geofenceFarm,
        _ => AppColors.geofencePasture,
      };
      // Parse GeoJSON coordinates
      final points = _parseGeoJsonPolygon(g.boundaryGeoJson);
      return Polygon(
        points: points,
        color: color.withOpacity(0.2),
        borderColor: color,
        borderStrokeWidth: 2,
        isFilled: true,
      );
    }).toList();
  }

  List<Marker> _buildAnimalMarkers() {
    // Live GPS positions from WebSocket
    final livePositions = ref.watch(gpsPositionAggregatorProvider);
    if (livePositions.isEmpty) {
      // Demo marker while loading
      return [
        Marker(
          point: const LatLng(43.235, 76.895),
          child: GestureDetector(
            onTap: () => _showAnimalInfo('demo-animal-id'),
            child: const _AnimalMapMarker(species: 'cattle'),
          ),
        ),
      ];
    }

    return livePositions.values.map((update) => Marker(
          point: LatLng(update.latitude, update.longitude),
          child: GestureDetector(
            onTap: () => _showAnimalInfo(update.animalId ?? update.deviceId),
            child: const _AnimalMapMarker(species: 'cattle'),
          ),
        )).toList();
  }

  List<LatLng> _parseGeoJsonPolygon(String geoJson) {
    try {
      final coords = RegExp(r'\[(\-?\d+\.?\d*),(\-?\d+\.?\d*)\]')
          .allMatches(geoJson)
          .map((m) => LatLng(
                double.parse(m.group(2)!), // lat
                double.parse(m.group(1)!), // lon
              ))
          .toList();
      return coords;
    } catch (_) {
      return const [LatLng(43.23, 76.89), LatLng(43.24, 76.91)];
    }
  }

  void _showAnimalInfo(String animalId) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Животное', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('ID'),
              trailing: Text(animalId),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Координаты'),
              trailing: const Text('43.235, 76.895'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/animals/$animalId');
              },
              child: const Text('Открыть карточку'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimalMapMarker extends StatelessWidget {
  final String species;
  const _AnimalMapMarker({required this.species});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(6),
      child: const Icon(Icons.pets, color: Colors.white, size: 14),
    );
  }
}

class _MapLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          _LegendItem(color: AppColors.geofencePasture, label: 'Пастбище'),
          _LegendItem(color: AppColors.geofenceFarm, label: 'Ферма'),
          _LegendItem(color: AppColors.geofenceQuarantine, label: 'Карантин'),
          _LegendItem(color: AppColors.primary, label: 'GPS устройство', isCircle: true),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool isCircle;
  const _LegendItem({required this.color, required this.label, this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12, height: 12,
            decoration: BoxDecoration(
              color: color.withOpacity(0.6),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              border: Border.all(color: color),
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

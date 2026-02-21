import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/map/cached_tile_provider.dart';
import '../../../data/models/animal.dart';
import '../../../providers/animal_providers.dart';

/// GPS movement history screen for a single animal.
/// Shows polyline track on map with time range selector.
class MovementHistoryScreen extends ConsumerStatefulWidget {
  final String animalId;
  final String? animalName;

  const MovementHistoryScreen({
    super.key,
    required this.animalId,
    this.animalName,
  });

  @override
  ConsumerState<MovementHistoryScreen> createState() =>
      _MovementHistoryScreenState();
}

class _MovementHistoryScreenState
    extends ConsumerState<MovementHistoryScreen> {
  final MapController _mapController = MapController();
  DateTimeRange _range = DateTimeRange(
    start: DateTime.now().subtract(const Duration(hours: 24)),
    end: DateTime.now(),
  );
  String _selectedPeriod = '24h';

  @override
  Widget build(BuildContext context) {
    final trackAsync = ref.watch(trackHistoryProvider(
      TrackHistoryParams(widget.animalId, _range.start, _range.end),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animalName ?? 'Маршрут животного'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedPeriod,
            onSelected: _setPeriod,
            itemBuilder: (_) => const [
              PopupMenuItem(value: '6h', child: Text('6 часов')),
              PopupMenuItem(value: '24h', child: Text('24 часа')),
              PopupMenuItem(value: '3d', child: Text('3 дня')),
              PopupMenuItem(value: '7d', child: Text('7 дней')),
              PopupMenuItem(value: 'custom', child: Text('Выбрать...')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(_selectedPeriod, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: trackAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _DemoTrackView(
          mapController: _mapController,
          range: _range,
          onFitBounds: _fitBounds,
        ),
        data: (readings) => readings.isEmpty
            ? _DemoTrackView(
                mapController: _mapController,
                range: _range,
                onFitBounds: _fitBounds,
              )
            : _TrackMapView(
                mapController: _mapController,
                readings: readings,
                range: _range,
                onFitBounds: _fitBounds,
              ),
      ),
    );
  }

  void _setPeriod(String period) async {
    setState(() => _selectedPeriod = period);
    final now = DateTime.now();
    switch (period) {
      case '6h':
        _range = DateTimeRange(start: now.subtract(const Duration(hours: 6)), end: now);
        break;
      case '24h':
        _range = DateTimeRange(start: now.subtract(const Duration(hours: 24)), end: now);
        break;
      case '3d':
        _range = DateTimeRange(start: now.subtract(const Duration(days: 3)), end: now);
        break;
      case '7d':
        _range = DateTimeRange(start: now.subtract(const Duration(days: 7)), end: now);
        break;
      case 'custom':
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now(),
          initialDateRange: _range,
        );
        if (picked != null) {
          setState(() => _range = picked);
        }
        return;
    }
    setState(() {});
  }

  void _fitBounds(List<LatLng> points) {
    if (points.isEmpty) return;
    final bounds = LatLngBounds.fromPoints(points);
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(32)),
    );
  }
}

// ─── Real track view ──────────────────────────────────────────────────────────

class _TrackMapView extends StatelessWidget {
  final MapController mapController;
  final List<GpsReading> readings;
  final DateTimeRange range;
  final void Function(List<LatLng>) onFitBounds;

  const _TrackMapView({
    required this.mapController,
    required this.readings,
    required this.range,
    required this.onFitBounds,
  });

  @override
  Widget build(BuildContext context) {
    final points = readings
        .map((r) => LatLng(r.latitude, r.longitude))
        .toList();

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: points.isNotEmpty
                ? points.last
                : const LatLng(
                    AppConfig.defaultMapLatitude, AppConfig.defaultMapLongitude),
            initialZoom: 13,
            onMapReady: () => onFitBounds(points),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'kz.gov.vetdigital.app',
              tileProvider: CachedOsmTileProvider(),
            ),
            // Track polyline
            PolylineLayer(polylines: [
              Polyline(
                points: points,
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            ]),
            // Start marker
            if (points.isNotEmpty)
              MarkerLayer(markers: [
                Marker(
                  point: points.first,
                  child: const _TrackMarker(color: AppColors.success, label: 'S'),
                ),
                Marker(
                  point: points.last,
                  child: const _TrackMarker(color: AppColors.danger, label: 'E'),
                ),
              ]),
          ],
        ),
        // Stats panel
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: _TrackStatsPanel(readings: readings, range: range),
        ),
      ],
    );
  }
}

// ─── Demo track (when API not available) ─────────────────────────────────────

class _DemoTrackView extends StatelessWidget {
  final MapController mapController;
  final DateTimeRange range;
  final void Function(List<LatLng>) onFitBounds;

  const _DemoTrackView({
    required this.mapController,
    required this.range,
    required this.onFitBounds,
  });

  static final _demoPoints = [
    const LatLng(43.230, 76.890),
    const LatLng(43.232, 76.892),
    const LatLng(43.235, 76.895),
    const LatLng(43.237, 76.898),
    const LatLng(43.236, 76.903),
    const LatLng(43.233, 76.905),
    const LatLng(43.231, 76.901),
    const LatLng(43.230, 76.897),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: _demoPoints[3],
            initialZoom: 14,
            onMapReady: () => onFitBounds(_demoPoints),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'kz.gov.vetdigital.app',
              tileProvider: CachedOsmTileProvider(),
            ),
            PolylineLayer(polylines: [
              Polyline(
                points: _demoPoints,
                color: AppColors.primary.withOpacity(0.8),
                strokeWidth: 3,
              ),
            ]),
            MarkerLayer(markers: [
              Marker(
                point: _demoPoints.first,
                child: const _TrackMarker(color: AppColors.success, label: 'S'),
              ),
              Marker(
                point: _demoPoints.last,
                child: const _TrackMarker(color: AppColors.danger, label: 'E'),
              ),
            ]),
          ],
        ),
        // Demo mode banner
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text('Демо-маршрут (Phase 4: реальные GPS данные)',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem('Точек', '${_demoPoints.length}'),
                  _StatItem('Дистанция', '3.2 км'),
                  _StatItem('Период', '24 ч'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Track stats panel ────────────────────────────────────────────────────────

class _TrackStatsPanel extends StatelessWidget {
  final List<GpsReading> readings;
  final DateTimeRange range;
  const _TrackStatsPanel({required this.readings, required this.range});

  @override
  Widget build(BuildContext context) {
    double totalDistance = 0;
    for (int i = 1; i < readings.length; i++) {
      final dist = const Distance().as(
        LengthUnit.Kilometer,
        LatLng(readings[i - 1].latitude, readings[i - 1].longitude),
        LatLng(readings[i].latitude, readings[i].longitude),
      );
      totalDistance += dist;
    }

    final avgSpeed = readings
        .where((r) => r.speedKmh != null)
        .map((r) => r.speedKmh!)
        .fold<double>(0, (a, b) => a + b) /
        (readings.where((r) => r.speedKmh != null).length.clamp(1, double.infinity));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem('Точек', '${readings.length}'),
            _StatItem('Дистанция', '${totalDistance.toStringAsFixed(1)} км'),
            _StatItem('Ср. скорость', '${avgSpeed.toStringAsFixed(1)} км/ч'),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _TrackMarker extends StatelessWidget {
  final Color color;
  final String label;
  const _TrackMarker({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/config/api_endpoints.dart';

// ─── Data Models ──────────────────────────────────────────────────────────────

class DashboardOverview {
  final int totalAnimals;
  final int vaccinatedToday;
  final int activeGeofences;
  final int geofenceViolations;
  final int pendingDocuments;
  final int lowStockItems;
  final Map<String, int> animalsBySpecies;
  final Map<String, int> proceduresByType;

  const DashboardOverview({
    this.totalAnimals = 0,
    this.vaccinatedToday = 0,
    this.activeGeofences = 0,
    this.geofenceViolations = 0,
    this.pendingDocuments = 0,
    this.lowStockItems = 0,
    this.animalsBySpecies = const {},
    this.proceduresByType = const {},
  });

  factory DashboardOverview.fromJson(Map<String, dynamic> json) {
    return DashboardOverview(
      totalAnimals: json['total_animals'] as int? ?? 0,
      vaccinatedToday: json['vaccinated_today'] as int? ?? 0,
      activeGeofences: json['active_geofences'] as int? ?? 0,
      geofenceViolations: json['geofence_violations'] as int? ?? 0,
      pendingDocuments: json['pending_documents'] as int? ?? 0,
      lowStockItems: json['low_stock_items'] as int? ?? 0,
      animalsBySpecies: Map<String, int>.from(
          (json['animals_by_species'] as Map? ?? {})),
      proceduresByType: Map<String, int>.from(
          (json['procedures_by_type'] as Map? ?? {})),
    );
  }

  static DashboardOverview demo() => const DashboardOverview(
    totalAnimals: 1842,
    vaccinatedToday: 37,
    activeGeofences: 14,
    geofenceViolations: 3,
    pendingDocuments: 8,
    lowStockItems: 2,
    animalsBySpecies: {
      'Крупный рогатый скот': 1020,
      'Лошади': 380,
      'Овцы': 342,
      'Козы': 100,
    },
    proceduresByType: {
      'vaccination': 245,
      'allergy_test': 88,
      'deworming': 60,
    },
  );
}

class VaccinationCoverageData {
  final String regionName;
  final int totalAnimals;
  final int vaccinatedAnimals;

  const VaccinationCoverageData({
    required this.regionName,
    required this.totalAnimals,
    required this.vaccinatedAnimals,
  });

  double get coveragePercent =>
      totalAnimals > 0 ? (vaccinatedAnimals / totalAnimals) * 100 : 0;

  factory VaccinationCoverageData.fromJson(Map<String, dynamic> json) {
    return VaccinationCoverageData(
      regionName: json['region_name'] as String? ?? '—',
      totalAnimals: json['total_animals'] as int? ?? 0,
      vaccinatedAnimals: json['vaccinated_animals'] as int? ?? 0,
    );
  }

  static List<VaccinationCoverageData> demoList() => [
        const VaccinationCoverageData(
            regionName: 'Алматы облысы', totalAnimals: 4200, vaccinatedAnimals: 3900),
        const VaccinationCoverageData(
            regionName: 'Қарағанды облысы', totalAnimals: 3100, vaccinatedAnimals: 2600),
        const VaccinationCoverageData(
            regionName: 'Шығыс Қазақстан', totalAnimals: 2800, vaccinatedAnimals: 2100),
        const VaccinationCoverageData(
            regionName: 'Ақмола облысы', totalAnimals: 1900, vaccinatedAnimals: 1800),
        const VaccinationCoverageData(
            regionName: 'Жамбыл облысы', totalAnimals: 1600, vaccinatedAnimals: 1200),
      ];
}

class ActivityPoint {
  final DateTime date;
  final int proceduresCount;

  const ActivityPoint({required this.date, required this.proceduresCount});

  factory ActivityPoint.fromJson(Map<String, dynamic> json) => ActivityPoint(
        date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
        proceduresCount: json['count'] as int? ?? 0,
      );

  static List<ActivityPoint> demoList() {
    final now = DateTime.now();
    return List.generate(
      7,
      (i) => ActivityPoint(
        date: now.subtract(Duration(days: 6 - i)),
        proceduresCount: [12, 8, 20, 15, 25, 18, 37][i],
      ),
    );
  }
}

// ─── State ────────────────────────────────────────────────────────────────────

class DashboardState {
  final DashboardOverview? overview;
  final List<VaccinationCoverageData> coverage;
  final List<ActivityPoint> activity;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.overview,
    this.coverage = const [],
    this.activity = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardOverview? overview,
    List<VaccinationCoverageData>? coverage,
    List<ActivityPoint>? activity,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      DashboardState(
        overview: overview ?? this.overview,
        coverage: coverage ?? this.coverage,
        activity: activity ?? this.activity,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class DashboardNotifier extends StateNotifier<DashboardState> {
  final _dio = ApiClient.instance.dio;

  DashboardNotifier() : super(const DashboardState()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Try real API first, fall back to demo data
      final results = await Future.wait([
        _fetchOverview(),
        _fetchCoverage(),
        _fetchActivity(),
      ]);
      state = state.copyWith(
        overview: results[0] as DashboardOverview,
        coverage: results[1] as List<VaccinationCoverageData>,
        activity: results[2] as List<ActivityPoint>,
        isLoading: false,
      );
    } catch (e) {
      // Use demo data when API not available
      state = DashboardState(
        overview: DashboardOverview.demo(),
        coverage: VaccinationCoverageData.demoList(),
        activity: ActivityPoint.demoList(),
        isLoading: false,
      );
    }
  }

  Future<DashboardOverview> _fetchOverview() async {
    final response = await _dio.get(ApiEndpoints.dashboardOverview);
    return DashboardOverview.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<VaccinationCoverageData>> _fetchCoverage() async {
    final response = await _dio.get(ApiEndpoints.vaccinationCoverage);
    final data = response.data;
    final items = data is List ? data : (data as Map)['items'] as List? ?? [];
    return items
        .cast<Map<String, dynamic>>()
        .map(VaccinationCoverageData.fromJson)
        .toList();
  }

  Future<List<ActivityPoint>> _fetchActivity() async {
    final response = await _dio.get(
      ApiEndpoints.dashboardOverview,
      queryParameters: {'include_activity': true},
    );
    final activityData =
        (response.data as Map<String, dynamic>)['activity'] as List? ?? [];
    return activityData
        .cast<Map<String, dynamic>>()
        .map(ActivityPoint.fromJson)
        .toList();
  }

  Future<void> refresh() => load();
}

// ─── Providers ────────────────────────────────────────────────────────────────

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (_) => DashboardNotifier(),
);

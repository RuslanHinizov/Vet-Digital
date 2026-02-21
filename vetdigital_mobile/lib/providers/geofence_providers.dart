import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/config/api_endpoints.dart';
import '../data/models/geofence.dart';

// ─── Remote datasource ────────────────────────────────────────────────────────

class GeofenceRemoteDataSource {
  final _dio = ApiClient.instance.dio;

  Future<List<GeofenceModel>> getGeofences({
    String? type,
    bool? isActive,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.geofences,
      queryParameters: {
        if (type != null) 'geofence_type': type,
        if (isActive != null) 'is_active': isActive,
        'page_size': 100,
      },
    );
    final data = response.data;
    final items = data is List ? data : (data as Map)['items'] as List? ?? [];
    return items
        .cast<Map<String, dynamic>>()
        .map(GeofenceModel.fromJson)
        .toList();
  }

  Future<GeofenceModel> createGeofence(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.geofences, data: data);
    return GeofenceModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<GeofenceModel> updateGeofence(
      String id, Map<String, dynamic> data) async {
    final response = await _dio.put(ApiEndpoints.geofenceById(id), data: data);
    return GeofenceModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteGeofence(String id) async {
    await _dio.delete(ApiEndpoints.geofenceById(id));
  }

  Future<List<GeofenceAlert>> getAlerts(String geofenceId,
      {bool? acknowledged}) async {
    final response = await _dio.get(
      ApiEndpoints.geofenceAlerts(geofenceId),
      queryParameters: {
        if (acknowledged != null) 'acknowledged': acknowledged,
        'page_size': 50,
      },
    );
    final data = response.data;
    final items = data is List ? data : (data as Map)['items'] as List? ?? [];
    return items
        .cast<Map<String, dynamic>>()
        .map(GeofenceAlert.fromJson)
        .toList();
  }

  Future<void> acknowledgeAlert(String geofenceId, String alertId) async {
    await _dio.post(
        '${ApiEndpoints.geofenceAlerts(geofenceId)}/$alertId/acknowledge');
  }
}

// ─── Geofence list state ──────────────────────────────────────────────────────

class GeofenceListState {
  final List<GeofenceModel> geofences;
  final bool isLoading;
  final String? error;
  final String? typeFilter;

  const GeofenceListState({
    this.geofences = const [],
    this.isLoading = false,
    this.error,
    this.typeFilter,
  });

  GeofenceListState copyWith({
    List<GeofenceModel>? geofences,
    bool? isLoading,
    String? error,
    String? typeFilter,
    bool clearError = false,
  }) =>
      GeofenceListState(
        geofences: geofences ?? this.geofences,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
        typeFilter: typeFilter ?? this.typeFilter,
      );
}

class GeofenceListNotifier extends StateNotifier<GeofenceListState> {
  final GeofenceRemoteDataSource _ds;

  GeofenceListNotifier(this._ds) : super(const GeofenceListState()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final geofences = await _ds.getGeofences(type: state.typeFilter);
      state = state.copyWith(geofences: geofences, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterByType(String? type) {
    state = state.copyWith(typeFilter: type);
    load();
  }

  Future<void> refresh() => load();

  Future<GeofenceModel?> create(Map<String, dynamic> data) async {
    try {
      final geofence = await _ds.createGeofence(data);
      await load();
      return geofence;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await _ds.deleteGeofence(id);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}

// ─── Alerts state ─────────────────────────────────────────────────────────────

class GeofenceAlertsState {
  final List<GeofenceAlert> alerts;
  final bool isLoading;
  final String? error;

  const GeofenceAlertsState({
    this.alerts = const [],
    this.isLoading = false,
    this.error,
  });
}

class GeofenceAlertsNotifier extends StateNotifier<GeofenceAlertsState> {
  final GeofenceRemoteDataSource _ds;
  final String geofenceId;

  GeofenceAlertsNotifier(this._ds, this.geofenceId)
      : super(const GeofenceAlertsState()) {
    load();
  }

  Future<void> load() async {
    state = const GeofenceAlertsState(isLoading: true);
    try {
      final alerts =
          await _ds.getAlerts(geofenceId, acknowledged: false);
      state = GeofenceAlertsState(alerts: alerts);
    } catch (e) {
      state = GeofenceAlertsState(error: e.toString());
    }
  }

  Future<void> acknowledge(String alertId) async {
    try {
      await _ds.acknowledgeAlert(geofenceId, alertId);
      await load();
    } catch (_) {}
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

final geofenceDsProvider = Provider<GeofenceRemoteDataSource>(
  (_) => GeofenceRemoteDataSource(),
);

final geofenceListProvider =
    StateNotifierProvider<GeofenceListNotifier, GeofenceListState>((ref) {
  return GeofenceListNotifier(ref.watch(geofenceDsProvider));
});

final geofenceAlertsProvider = StateNotifierProvider.family<
    GeofenceAlertsNotifier, GeofenceAlertsState, String>((ref, geofenceId) {
  return GeofenceAlertsNotifier(ref.watch(geofenceDsProvider), geofenceId);
});

/// Unacknowledged alert count across all geofences
final totalAlertCountProvider = Provider<int>((ref) {
  final geofences = ref.watch(geofenceListProvider).geofences;
  // Sum alerts from first few active geofences (limited for performance)
  int total = 0;
  for (final g in geofences.take(5)) {
    final alerts = ref.watch(geofenceAlertsProvider(g.id)).alerts;
    total += alerts.where((a) => !a.acknowledged).length;
  }
  return total;
});

import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../config/app_config.dart';
import '../config/api_endpoints.dart';
import '../storage/secure_storage.dart';

// ─── GPS Update Model ──────────────────────────────────────────────────────────

class LiveGpsUpdate {
  final String deviceId;
  final String? animalId;
  final double latitude;
  final double longitude;
  final double? speedKmh;
  final double? batteryLevel;
  final DateTime timestamp;
  final String? alertType; // 'geofence_exit', 'geofence_entry', or null

  const LiveGpsUpdate({
    required this.deviceId,
    this.animalId,
    required this.latitude,
    required this.longitude,
    this.speedKmh,
    this.batteryLevel,
    required this.timestamp,
    this.alertType,
  });

  factory LiveGpsUpdate.fromJson(Map<String, dynamic> json) {
    return LiveGpsUpdate(
      deviceId: json['device_id'] as String? ?? '',
      animalId: json['animal_id'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      speedKmh: (json['speed_kmh'] as num?)?.toDouble(),
      batteryLevel: (json['battery_level'] as num?)?.toDouble(),
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.now(),
      alertType: json['alert_type'] as String?,
    );
  }
}

// ─── WebSocket client ─────────────────────────────────────────────────────────

class GpsWebSocketClient {
  WebSocketChannel? _channel;
  StreamController<LiveGpsUpdate>? _controller;
  bool _isConnected = false;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  static const Duration _pingInterval = Duration(seconds: 30);
  static const Duration _reconnectDelay = Duration(seconds: 5);

  Stream<LiveGpsUpdate> get stream {
    _controller ??= StreamController<LiveGpsUpdate>.broadcast();
    return _controller!.stream;
  }

  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnected) return;
    try {
      final token = await SecureStorage.instance.getAccessToken();
      final wsUrl = Uri.parse(
        '${AppConfig.wsBaseUrl}${ApiEndpoints.gpsLive}'
        '${token != null ? "?token=$token" : ""}',
      );

      _channel = WebSocketChannel.connect(wsUrl);
      _isConnected = true;
      _startPing();

      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );
    } catch (e) {
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic raw) {
    try {
      final json = jsonDecode(raw as String) as Map<String, dynamic>;
      final msgType = json['type'] as String?;

      if (msgType == 'gps_update') {
        final update = LiveGpsUpdate.fromJson(
          json['data'] as Map<String, dynamic>,
        );
        _controller?.add(update);
      } else if (msgType == 'pong') {
        // Heartbeat response — connection alive
      }
    } catch (_) {
      // Ignore malformed messages
    }
  }

  void _onError(Object error) {
    _isConnected = false;
    _scheduleReconnect();
  }

  void _onDone() {
    _isConnected = false;
    _pingTimer?.cancel();
    _scheduleReconnect();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(_pingInterval, (_) {
      if (_isConnected) {
        _channel?.sink.add(jsonEncode({'type': 'ping'}));
      }
    });
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, connect);
  }

  /// Subscribe to GPS updates for specific animals
  void subscribeToAnimals(List<String> animalIds) {
    if (!_isConnected) return;
    _channel?.sink.add(jsonEncode({
      'type': 'subscribe',
      'animal_ids': animalIds,
    }));
  }

  /// Subscribe to all animals in a region
  void subscribeToRegion(String regionKato) {
    if (!_isConnected) return;
    _channel?.sink.add(jsonEncode({
      'type': 'subscribe_region',
      'region_kato': regionKato,
    }));
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _isConnected = false;
    await _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    disconnect();
    _controller?.close();
    _controller = null;
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

/// Singleton GPS WebSocket client
final gpsWebSocketClientProvider = Provider<GpsWebSocketClient>((ref) {
  final client = GpsWebSocketClient();
  ref.onDispose(client.dispose);
  return client;
});

/// Stream of live GPS updates — auto-connects when watched
final liveGpsStreamProvider = StreamProvider<LiveGpsUpdate>((ref) async* {
  final client = ref.watch(gpsWebSocketClientProvider);
  await client.connect();
  yield* client.stream;
});

/// Latest GPS position per device ID
final liveGpsPositionsProvider =
    StateProvider<Map<String, LiveGpsUpdate>>((ref) => {});

/// GPS update processor — accumulates positions in a map
class GpsPositionAggregator extends StateNotifier<Map<String, LiveGpsUpdate>> {
  GpsPositionAggregator() : super({});

  void updatePosition(LiveGpsUpdate update) {
    state = {...state, update.deviceId: update};
  }

  void clear() {
    state = {};
  }
}

final gpsPositionAggregatorProvider =
    StateNotifierProvider<GpsPositionAggregator, Map<String, LiveGpsUpdate>>(
  (_) => GpsPositionAggregator(),
);

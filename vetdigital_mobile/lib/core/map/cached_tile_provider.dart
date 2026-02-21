import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Cache configuration constants
const _kCacheMaxAgeDays = 30;
const _kCacheMaxSizeMb = 512;

/// Tile cache manager using local file system.
///
/// Tiles are stored at: {appCacheDir}/map_tiles/{z}/{x}/{y}.png
/// Cache TTL: [_kCacheMaxAgeDays] days
class MapTileCache {
  static MapTileCache? _instance;
  late final Directory _cacheDir;
  bool _initialized = false;

  MapTileCache._();
  static MapTileCache get instance => _instance ??= MapTileCache._();

  Future<void> init() async {
    if (_initialized) return;
    final appCacheDir = await getApplicationCacheDirectory();
    _cacheDir = Directory(p.join(appCacheDir.path, 'map_tiles'));
    await _cacheDir.create(recursive: true);
    _initialized = true;
  }

  File _tileFile(int z, int x, int y) {
    return File(p.join(_cacheDir.path, '$z', '$x', '$y.png'));
  }

  Future<File?> get(int z, int x, int y) async {
    await init();
    final file = _tileFile(z, x, y);
    if (!await file.exists()) return null;

    final stat = await file.stat();
    final age = DateTime.now().difference(stat.modified);
    if (age.inDays > _kCacheMaxAgeDays) {
      await file.delete();
      return null;
    }
    return file;
  }

  Future<void> put(int z, int x, int y, List<int> bytes) async {
    await init();
    final file = _tileFile(z, x, y);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  /// Estimate cache size in MB
  Future<double> cacheSize() async {
    await init();
    int total = 0;
    await for (final entity in _cacheDir.list(recursive: true)) {
      if (entity is File) {
        total += await entity.length();
      }
    }
    return total / (1024 * 1024);
  }

  /// Delete all cached tiles
  Future<void> clear() async {
    await init();
    if (await _cacheDir.exists()) {
      await _cacheDir.delete(recursive: true);
      await _cacheDir.create(recursive: true);
    }
  }
}

/// Custom [TileProvider] for [FlutterMap] that caches OSM tiles locally.
///
/// Tile fetch flow:
/// 1. Check local file cache
/// 2. If miss (or expired), fetch from OSM tile server
/// 3. Write to cache, return image bytes
class CachedOsmTileProvider extends TileProvider {
  final MapTileCache _cache;
  final Dio _dio;

  CachedOsmTileProvider({MapTileCache? cache, Dio? dio})
      : _cache = cache ?? MapTileCache.instance,
        _dio = dio ?? Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'User-Agent': 'VetDigital/1.0 (kz.gov.vetdigital; livestock-tracking)',
          },
        ));

  @override
  ImageProvider<Object> getImage(TileCoordinates coordinates, TileLayer options) {
    return _CachedTileImageProvider(
      coordinates: coordinates,
      urlTemplate: options.urlTemplate!,
      cache: _cache,
      dio: _dio,
    );
  }
}

class _CachedTileImageProvider extends ImageProvider<_CachedTileImageProvider> {
  final TileCoordinates coordinates;
  final String urlTemplate;
  final MapTileCache cache;
  final Dio dio;

  const _CachedTileImageProvider({
    required this.coordinates,
    required this.urlTemplate,
    required this.cache,
    required this.dio,
  });

  String get _tileUrl => urlTemplate
      .replaceAll('{z}', coordinates.z.toString())
      .replaceAll('{x}', coordinates.x.toString())
      .replaceAll('{y}', coordinates.y.toString());

  @override
  Future<_CachedTileImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
      _CachedTileImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadBytes().then(decode),
      scale: 1.0,
    );
  }

  Future<List<int>> _loadBytes() async {
    final z = coordinates.z.toInt();
    final x = coordinates.x;
    final y = coordinates.y;

    // 1. Try cache
    final cached = await cache.get(z, x, y);
    if (cached != null) {
      return cached.readAsBytes();
    }

    // 2. Fetch from network
    try {
      final response = await dio.get<List<int>>(
        _tileUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data!;
      await cache.put(z, x, y, bytes);
      return bytes;
    } catch (e) {
      // Return transparent 1×1 tile on failure
      return _transparentPng;
    }
  }

  @override
  bool operator ==(Object other) =>
      other is _CachedTileImageProvider &&
      coordinates == other.coordinates &&
      urlTemplate == other.urlTemplate;

  @override
  int get hashCode => Object.hash(coordinates, urlTemplate);
}

// Minimal 1×1 transparent PNG fallback
const List<int> _transparentPng = [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x62, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

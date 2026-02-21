import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';

/// Riverpod provider that exposes the shared Dio instance.
final dioProvider = Provider<Dio>((ref) => ApiClient.instance.dio);

/// Central Dio HTTP client with auth interceptor, retry logic, and error handling.
class ApiClient {
  static ApiClient? _instance;
  late final Dio _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConfig.connectionTimeoutMs),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeoutMs),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );
    _dio.interceptors.addAll([
      _AuthInterceptor(),
      if (AppConfig.isDevelopment) LogInterceptor(responseBody: true, requestBody: true),
    ]);
  }

  static ApiClient get instance => _instance ??= ApiClient._internal();

  Dio get dio => _dio;

  // Convenience methods
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get<T>(path, queryParameters: queryParameters);

  Future<Response<T>> post<T>(String path, {dynamic data}) =>
      _dio.post<T>(path, data: data);

  Future<Response<T>> put<T>(String path, {dynamic data}) =>
      _dio.put<T>(path, data: data);

  Future<Response<T>> delete<T>(String path) =>
      _dio.delete<T>(path);
}

/// Attaches JWT access token to every request; refreshes on 401.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get token from secure storage
    final token = await _getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Try token refresh
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        // Retry original request
        final opts = err.requestOptions;
        final token = await _getAccessToken();
        opts.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await ApiClient.instance.dio.fetch(opts);
          handler.resolve(response);
          return;
        } catch (_) {}
      }
      // Refresh failed - trigger logout
      _onAuthFailure();
    }
    handler.next(err);
  }

  Future<String?> _getAccessToken() async {
    // TODO: Read from flutter_secure_storage
    // return await SecureStorage.instance.read('access_token');
    return null;
  }

  Future<bool> _tryRefreshToken() async {
    // TODO: Call /api/v1/auth/refresh
    return false;
  }

  void _onAuthFailure() {
    // TODO: Navigate to login screen via GoRouter
  }
}

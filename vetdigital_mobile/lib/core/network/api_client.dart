import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../config/api_endpoints.dart';
import '../storage/secure_storage.dart';

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
    final token = await SecureStorage.instance.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Don't try to refresh if the failing request was the login or refresh endpoint
      final path = err.requestOptions.path;
      if (path.contains('/auth/login') || path.contains('/auth/refresh')) {
        handler.next(err);
        return;
      }

      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        final opts = err.requestOptions;
        final token = await SecureStorage.instance.getAccessToken();
        opts.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await ApiClient.instance.dio.fetch(opts);
          handler.resolve(response);
          return;
        } catch (_) {}
      }
    }
    handler.next(err);
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await SecureStorage.instance.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      // Use a separate Dio instance to avoid interceptor loop
      final dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
      final response = await dio.post(
        ApiEndpoints.refresh,
        data: {'refresh_token': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      await SecureStorage.instance.saveTokens(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

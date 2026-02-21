import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../core/config/api_endpoints.dart';
import '../core/network/api_client.dart';
import '../core/storage/secure_storage.dart';

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? userId;
  final String? role;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.userId,
    this.role,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? userId,
    String? role,
    String? error,
  }) => AuthState(
    isLoading: isLoading ?? this.isLoading,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    error: error,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _checkExistingSession();
  }

  Future<void> _checkExistingSession() async {
    final loggedIn = await SecureStorage.instance.isLoggedIn();
    if (loggedIn) {
      final userId = await SecureStorage.instance.getUserId();
      final role = await SecureStorage.instance.getUserRole();
      state = AuthState(isLoggedIn: true, userId: userId, role: role);
    }
  }

  Future<bool> login({required String iin, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ApiClient.instance.post(
        ApiEndpoints.login,
        data: {'iin': iin, 'password': password},
      );
      final data = response.data as Map<String, dynamic>;

      await SecureStorage.instance.saveTokens(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
      );
      await SecureStorage.instance.saveUserInfo(
        userId: data['user_id'],
        role: data['role'],
        language: data['language'],
      );

      state = AuthState(
        isLoading: false,
        isLoggedIn: true,
        userId: data['user_id'],
        role: data['role'],
      );
      return true;
    } on DioException catch (e) {
      String message = 'Ошибка подключения к серверу';
      if (e.response?.statusCode == 401) {
        message = 'Неверный ИИН или пароль';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Превышено время ожидания. Проверьте соединение.';
      }
      state = state.copyWith(isLoading: false, error: message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Неизвестная ошибка: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.instance.clearAll();
    state = const AuthState(isLoggedIn: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

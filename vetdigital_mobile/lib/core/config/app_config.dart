/// Environment-based application configuration.
/// Supports: development, staging, production.
class AppConfig {
  static const String _env = String.fromEnvironment('ENV', defaultValue: 'development');

  static bool get isDevelopment => _env == 'development';
  static bool get isProduction => _env == 'production';

  // Base URL for VetDigital FastAPI backend
  static String get baseUrl {
    switch (_env) {
      case 'production':
        return 'https://api.vetdigital.gov.kz';
      case 'staging':
        return 'https://staging-api.vetdigital.gov.kz';
      default:
        // Development: use local Docker container or ngrok tunnel
        return 'http://localhost:8000';
    }
  }

  // WebSocket for live GPS
  static String get wsBaseUrl => baseUrl.replaceFirst('http', 'ws');

  static const String appName = 'VetDigital';
  static const String appVersion = '1.0.0';

  // Supported languages
  static const List<String> supportedLocales = ['ru', 'kk', 'en'];
  static const String defaultLocale = 'ru';

  // Timeouts
  static const int connectionTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;

  // Offline sync
  static const int syncIntervalMinutes = 15;
  static const int maxSyncRetries = 3;

  // Map
  static const double defaultMapLatitude = 48.0196;   // Kazakhstan center
  static const double defaultMapLongitude = 66.9237;
  static const double defaultMapZoom = 5.0;
}

/// All API endpoint paths (relative to base URL + /api/v1)
class ApiEndpoints {
  static const String _v1 = '/api/v1';

  // Authentication
  static const String login = '$_v1/auth/login';
  static const String loginEds = '$_v1/auth/login/eds';
  static const String challenge = '$_v1/auth/challenge';
  static const String refresh = '$_v1/auth/refresh';
  static const String logout = '$_v1/auth/logout';

  // Users
  static const String me = '$_v1/users/me';
  static const String updateFcmToken = '$_v1/users/me/fcm-token';
  static const String updateLanguage = '$_v1/users/me/language';

  // Animals
  static const String animals = '$_v1/animals';
  static String animalById(String id) => '$_v1/animals/$id';
  static String animalLocation(String id) => '$_v1/animals/$id/location';
  static String animalTrack(String id) => '$_v1/animals/$id/track';
  static String animalHealth(String id) => '$_v1/animals/$id/health';
  static const String rfidLookup = '$_v1/animals/rfid-lookup';

  // Owners
  static const String owners = '$_v1/owners';
  static String ownerById(String id) => '$_v1/owners/$id';
  static String ownerAnimals(String id) => '$_v1/owners/$id/animals';

  // Procedures
  static const String procedures = '$_v1/procedures';
  static String procedureById(String id) => '$_v1/procedures/$id';
  static String procedureAnimals(String id) => '$_v1/procedures/$id/animals';
  static String procedureSign(String id) => '$_v1/procedures/$id/sign';
  static String procedurePdf(String id) => '$_v1/procedures/$id/pdf';

  // Geofences
  static const String geofences = '$_v1/geofences';
  static String geofenceById(String id) => '$_v1/geofences/$id';
  static String geofenceAlerts(String id) => '$_v1/geofences/$id/alerts';

  // GPS
  static const String gpsDevices = '$_v1/gps/devices';
  static String gpsDeviceById(String id) => '$_v1/gps/devices/$id';
  static String gpsDeviceReadings(String id) => '$_v1/gps/devices/$id/readings';
  static const String gpsLive = '/api/v1/gps/live'; // WebSocket

  // Inventory
  static const String inventory = '$_v1/inventory';
  static String consumeInventory(String id) => '$_v1/inventory/$id/consume';

  // Dashboard
  static const String dashboardOverview = '$_v1/dashboard/overview';
  static const String vaccinationCoverage = '$_v1/dashboard/vaccination-coverage';
  static const String geofenceViolations = '$_v1/dashboard/geofence-violations';

  // Sync
  static const String syncPush = '$_v1/sync/push';
  static const String syncPull = '$_v1/sync/pull';
  static const String syncStatus = '$_v1/sync/status';
}

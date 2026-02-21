import 'package:freezed_annotation/freezed_annotation.dart';

part 'geofence.freezed.dart';
part 'geofence.g.dart';

@freezed
class GeofenceModel with _$GeofenceModel {
  const factory GeofenceModel({
    required String id,
    required String name,
    required String geofenceType,   // pasture / farm / quarantine_zone / restricted
    required String boundaryGeoJson,
    String? description,
    String? regionKato,
    String? ownerOrgId,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _GeofenceModel;

  factory GeofenceModel.fromJson(Map<String, dynamic> json) =>
      _$GeofenceModelFromJson(json);
}

@freezed
class GeofenceAlert with _$GeofenceAlert {
  const factory GeofenceAlert({
    required String id,
    required String geofenceId,
    required String geofenceName,
    required String alertType,      // exit / entry
    String? animalId,
    String? gpsDeviceId,
    required double latitude,
    required double longitude,
    required DateTime detectedAt,
    @Default(false) bool acknowledged,
    DateTime? acknowledgedAt,
  }) = _GeofenceAlert;

  factory GeofenceAlert.fromJson(Map<String, dynamic> json) =>
      _$GeofenceAlertFromJson(json);
}

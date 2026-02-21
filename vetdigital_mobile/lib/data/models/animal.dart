import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal.freezed.dart';
part 'animal.g.dart';

@freezed
class AnimalModel with _$AnimalModel {
  const factory AnimalModel({
    required String id,
    String? identificationNo,
    String? microchipNo,
    String? rfidTagNo,
    required String speciesId,
    String? speciesName,
    String? breedId,
    String? breedName,
    String? sex,            // male / female
    DateTime? birthDate,
    int? birthYear,
    String? color,
    double? weightKg,
    String? status,         // active / deceased / sold / lost
    String? ownerId,
    String? ownerName,
    String? ownerIin,
    String? farmAddress,
    double? farmLatitude,
    double? farmLongitude,
    String? regionKato,
    String? regionName,
    String? gpsDeviceId,
    double? lastLatitude,
    double? lastLongitude,
    DateTime? lastSeenAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isSynced,
    String? localId,        // for offline-created records
  }) = _AnimalModel;

  factory AnimalModel.fromJson(Map<String, dynamic> json) =>
      _$AnimalModelFromJson(json);
}

/// Paginated list response for animals
@freezed
class AnimalListResponse with _$AnimalListResponse {
  const factory AnimalListResponse({
    required List<AnimalModel> items,
    required int total,
    required int page,
    required int pageSize,
    required int pages,
  }) = _AnimalListResponse;

  factory AnimalListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnimalListResponseFromJson(json);
}

/// GPS location point for track history
@freezed
class GpsReading with _$GpsReading {
  const factory GpsReading({
    required String id,
    required String deviceId,
    required double latitude,
    required double longitude,
    double? altitude,
    double? speedKmh,
    double? batteryLevel,
    required DateTime timestamp,
  }) = _GpsReading;

  factory GpsReading.fromJson(Map<String, dynamic> json) =>
      _$GpsReadingFromJson(json);
}

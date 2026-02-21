// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeofenceModelImpl _$$GeofenceModelImplFromJson(Map<String, dynamic> json) =>
    _$GeofenceModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      geofenceType: json['geofenceType'] as String,
      boundaryGeoJson: json['boundaryGeoJson'] as String,
      description: json['description'] as String?,
      regionKato: json['regionKato'] as String?,
      ownerOrgId: json['ownerOrgId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GeofenceModelImplToJson(_$GeofenceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'geofenceType': instance.geofenceType,
      'boundaryGeoJson': instance.boundaryGeoJson,
      'description': instance.description,
      'regionKato': instance.regionKato,
      'ownerOrgId': instance.ownerOrgId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$GeofenceAlertImpl _$$GeofenceAlertImplFromJson(Map<String, dynamic> json) =>
    _$GeofenceAlertImpl(
      id: json['id'] as String,
      geofenceId: json['geofenceId'] as String,
      geofenceName: json['geofenceName'] as String,
      alertType: json['alertType'] as String,
      animalId: json['animalId'] as String?,
      gpsDeviceId: json['gpsDeviceId'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      acknowledged: json['acknowledged'] as bool? ?? false,
      acknowledgedAt: json['acknowledgedAt'] == null
          ? null
          : DateTime.parse(json['acknowledgedAt'] as String),
    );

Map<String, dynamic> _$$GeofenceAlertImplToJson(_$GeofenceAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'geofenceId': instance.geofenceId,
      'geofenceName': instance.geofenceName,
      'alertType': instance.alertType,
      'animalId': instance.animalId,
      'gpsDeviceId': instance.gpsDeviceId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'detectedAt': instance.detectedAt.toIso8601String(),
      'acknowledged': instance.acknowledged,
      'acknowledgedAt': instance.acknowledgedAt?.toIso8601String(),
    };

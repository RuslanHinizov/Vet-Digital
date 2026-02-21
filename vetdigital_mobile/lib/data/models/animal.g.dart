// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimalModelImpl _$$AnimalModelImplFromJson(Map<String, dynamic> json) =>
    _$AnimalModelImpl(
      id: json['id'] as String,
      identificationNo: json['identificationNo'] as String?,
      microchipNo: json['microchipNo'] as String?,
      rfidTagNo: json['rfidTagNo'] as String?,
      speciesId: json['speciesId'] as String,
      speciesName: json['speciesName'] as String?,
      breedId: json['breedId'] as String?,
      breedName: json['breedName'] as String?,
      sex: json['sex'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      birthYear: (json['birthYear'] as num?)?.toInt(),
      color: json['color'] as String?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      status: json['status'] as String?,
      ownerId: json['ownerId'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerIin: json['ownerIin'] as String?,
      farmAddress: json['farmAddress'] as String?,
      farmLatitude: (json['farmLatitude'] as num?)?.toDouble(),
      farmLongitude: (json['farmLongitude'] as num?)?.toDouble(),
      regionKato: json['regionKato'] as String?,
      regionName: json['regionName'] as String?,
      gpsDeviceId: json['gpsDeviceId'] as String?,
      lastLatitude: (json['lastLatitude'] as num?)?.toDouble(),
      lastLongitude: (json['lastLongitude'] as num?)?.toDouble(),
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
      localId: json['localId'] as String?,
    );

Map<String, dynamic> _$$AnimalModelImplToJson(_$AnimalModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identificationNo': instance.identificationNo,
      'microchipNo': instance.microchipNo,
      'rfidTagNo': instance.rfidTagNo,
      'speciesId': instance.speciesId,
      'speciesName': instance.speciesName,
      'breedId': instance.breedId,
      'breedName': instance.breedName,
      'sex': instance.sex,
      'birthDate': instance.birthDate?.toIso8601String(),
      'birthYear': instance.birthYear,
      'color': instance.color,
      'weightKg': instance.weightKg,
      'status': instance.status,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'ownerIin': instance.ownerIin,
      'farmAddress': instance.farmAddress,
      'farmLatitude': instance.farmLatitude,
      'farmLongitude': instance.farmLongitude,
      'regionKato': instance.regionKato,
      'regionName': instance.regionName,
      'gpsDeviceId': instance.gpsDeviceId,
      'lastLatitude': instance.lastLatitude,
      'lastLongitude': instance.lastLongitude,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSynced': instance.isSynced,
      'localId': instance.localId,
    };

_$AnimalListResponseImpl _$$AnimalListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AnimalListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => AnimalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$$AnimalListResponseImplToJson(
        _$AnimalListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
    };

_$GpsReadingImpl _$$GpsReadingImplFromJson(Map<String, dynamic> json) =>
    _$GpsReadingImpl(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
      speedKmh: (json['speedKmh'] as num?)?.toDouble(),
      batteryLevel: (json['batteryLevel'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$GpsReadingImplToJson(_$GpsReadingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'speedKmh': instance.speedKmh,
      'batteryLevel': instance.batteryLevel,
      'timestamp': instance.timestamp.toIso8601String(),
    };

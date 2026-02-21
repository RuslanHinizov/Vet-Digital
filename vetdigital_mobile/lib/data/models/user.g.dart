// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      iin: json['iin'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      organizationId: json['organizationId'] as String?,
      organizationName: json['organizationName'] as String?,
      regionKato: json['regionKato'] as String?,
      regionName: json['regionName'] as String?,
      edsCertSerial: json['edsCertSerial'] as String?,
      edsCertExpiry: json['edsCertExpiry'] == null
          ? null
          : DateTime.parse(json['edsCertExpiry'] as String),
      language: json['language'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iin': instance.iin,
      'fullName': instance.fullName,
      'role': instance.role,
      'phone': instance.phone,
      'email': instance.email,
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'regionKato': instance.regionKato,
      'regionName': instance.regionName,
      'edsCertSerial': instance.edsCertSerial,
      'edsCertExpiry': instance.edsCertExpiry?.toIso8601String(),
      'language': instance.language,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$AuthTokensImpl _$$AuthTokensImplFromJson(Map<String, dynamic> json) =>
    _$AuthTokensImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthTokensImplToJson(_$AuthTokensImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
    };

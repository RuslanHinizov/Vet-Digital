// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geofence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeofenceModel _$GeofenceModelFromJson(Map<String, dynamic> json) {
  return _GeofenceModel.fromJson(json);
}

/// @nodoc
mixin _$GeofenceModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get geofenceType =>
      throw _privateConstructorUsedError; // pasture / farm / quarantine_zone / restricted
  String get boundaryGeoJson => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get regionKato => throw _privateConstructorUsedError;
  String? get ownerOrgId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GeofenceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeofenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeofenceModelCopyWith<GeofenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeofenceModelCopyWith<$Res> {
  factory $GeofenceModelCopyWith(
          GeofenceModel value, $Res Function(GeofenceModel) then) =
      _$GeofenceModelCopyWithImpl<$Res, GeofenceModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String geofenceType,
      String boundaryGeoJson,
      String? description,
      String? regionKato,
      String? ownerOrgId,
      bool isActive,
      DateTime? createdAt});
}

/// @nodoc
class _$GeofenceModelCopyWithImpl<$Res, $Val extends GeofenceModel>
    implements $GeofenceModelCopyWith<$Res> {
  _$GeofenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeofenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? geofenceType = null,
    Object? boundaryGeoJson = null,
    Object? description = freezed,
    Object? regionKato = freezed,
    Object? ownerOrgId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceType: null == geofenceType
          ? _value.geofenceType
          : geofenceType // ignore: cast_nullable_to_non_nullable
              as String,
      boundaryGeoJson: null == boundaryGeoJson
          ? _value.boundaryGeoJson
          : boundaryGeoJson // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerOrgId: freezed == ownerOrgId
          ? _value.ownerOrgId
          : ownerOrgId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeofenceModelImplCopyWith<$Res>
    implements $GeofenceModelCopyWith<$Res> {
  factory _$$GeofenceModelImplCopyWith(
          _$GeofenceModelImpl value, $Res Function(_$GeofenceModelImpl) then) =
      __$$GeofenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String geofenceType,
      String boundaryGeoJson,
      String? description,
      String? regionKato,
      String? ownerOrgId,
      bool isActive,
      DateTime? createdAt});
}

/// @nodoc
class __$$GeofenceModelImplCopyWithImpl<$Res>
    extends _$GeofenceModelCopyWithImpl<$Res, _$GeofenceModelImpl>
    implements _$$GeofenceModelImplCopyWith<$Res> {
  __$$GeofenceModelImplCopyWithImpl(
      _$GeofenceModelImpl _value, $Res Function(_$GeofenceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeofenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? geofenceType = null,
    Object? boundaryGeoJson = null,
    Object? description = freezed,
    Object? regionKato = freezed,
    Object? ownerOrgId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$GeofenceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceType: null == geofenceType
          ? _value.geofenceType
          : geofenceType // ignore: cast_nullable_to_non_nullable
              as String,
      boundaryGeoJson: null == boundaryGeoJson
          ? _value.boundaryGeoJson
          : boundaryGeoJson // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerOrgId: freezed == ownerOrgId
          ? _value.ownerOrgId
          : ownerOrgId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeofenceModelImpl implements _GeofenceModel {
  const _$GeofenceModelImpl(
      {required this.id,
      required this.name,
      required this.geofenceType,
      required this.boundaryGeoJson,
      this.description,
      this.regionKato,
      this.ownerOrgId,
      this.isActive = true,
      this.createdAt});

  factory _$GeofenceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeofenceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String geofenceType;
// pasture / farm / quarantine_zone / restricted
  @override
  final String boundaryGeoJson;
  @override
  final String? description;
  @override
  final String? regionKato;
  @override
  final String? ownerOrgId;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GeofenceModel(id: $id, name: $name, geofenceType: $geofenceType, boundaryGeoJson: $boundaryGeoJson, description: $description, regionKato: $regionKato, ownerOrgId: $ownerOrgId, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeofenceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.geofenceType, geofenceType) ||
                other.geofenceType == geofenceType) &&
            (identical(other.boundaryGeoJson, boundaryGeoJson) ||
                other.boundaryGeoJson == boundaryGeoJson) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.regionKato, regionKato) ||
                other.regionKato == regionKato) &&
            (identical(other.ownerOrgId, ownerOrgId) ||
                other.ownerOrgId == ownerOrgId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      geofenceType,
      boundaryGeoJson,
      description,
      regionKato,
      ownerOrgId,
      isActive,
      createdAt);

  /// Create a copy of GeofenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeofenceModelImplCopyWith<_$GeofenceModelImpl> get copyWith =>
      __$$GeofenceModelImplCopyWithImpl<_$GeofenceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeofenceModelImplToJson(
      this,
    );
  }
}

abstract class _GeofenceModel implements GeofenceModel {
  const factory _GeofenceModel(
      {required final String id,
      required final String name,
      required final String geofenceType,
      required final String boundaryGeoJson,
      final String? description,
      final String? regionKato,
      final String? ownerOrgId,
      final bool isActive,
      final DateTime? createdAt}) = _$GeofenceModelImpl;

  factory _GeofenceModel.fromJson(Map<String, dynamic> json) =
      _$GeofenceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get geofenceType; // pasture / farm / quarantine_zone / restricted
  @override
  String get boundaryGeoJson;
  @override
  String? get description;
  @override
  String? get regionKato;
  @override
  String? get ownerOrgId;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;

  /// Create a copy of GeofenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeofenceModelImplCopyWith<_$GeofenceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeofenceAlert _$GeofenceAlertFromJson(Map<String, dynamic> json) {
  return _GeofenceAlert.fromJson(json);
}

/// @nodoc
mixin _$GeofenceAlert {
  String get id => throw _privateConstructorUsedError;
  String get geofenceId => throw _privateConstructorUsedError;
  String get geofenceName => throw _privateConstructorUsedError;
  String get alertType => throw _privateConstructorUsedError; // exit / entry
  String? get animalId => throw _privateConstructorUsedError;
  String? get gpsDeviceId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  DateTime get detectedAt => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  DateTime? get acknowledgedAt => throw _privateConstructorUsedError;

  /// Serializes this GeofenceAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeofenceAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeofenceAlertCopyWith<GeofenceAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeofenceAlertCopyWith<$Res> {
  factory $GeofenceAlertCopyWith(
          GeofenceAlert value, $Res Function(GeofenceAlert) then) =
      _$GeofenceAlertCopyWithImpl<$Res, GeofenceAlert>;
  @useResult
  $Res call(
      {String id,
      String geofenceId,
      String geofenceName,
      String alertType,
      String? animalId,
      String? gpsDeviceId,
      double latitude,
      double longitude,
      DateTime detectedAt,
      bool acknowledged,
      DateTime? acknowledgedAt});
}

/// @nodoc
class _$GeofenceAlertCopyWithImpl<$Res, $Val extends GeofenceAlert>
    implements $GeofenceAlertCopyWith<$Res> {
  _$GeofenceAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeofenceAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? geofenceId = null,
    Object? geofenceName = null,
    Object? alertType = null,
    Object? animalId = freezed,
    Object? gpsDeviceId = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? detectedAt = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceId: null == geofenceId
          ? _value.geofenceId
          : geofenceId // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceName: null == geofenceName
          ? _value.geofenceName
          : geofenceName // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      animalId: freezed == animalId
          ? _value.animalId
          : animalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gpsDeviceId: freezed == gpsDeviceId
          ? _value.gpsDeviceId
          : gpsDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      detectedAt: null == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeofenceAlertImplCopyWith<$Res>
    implements $GeofenceAlertCopyWith<$Res> {
  factory _$$GeofenceAlertImplCopyWith(
          _$GeofenceAlertImpl value, $Res Function(_$GeofenceAlertImpl) then) =
      __$$GeofenceAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String geofenceId,
      String geofenceName,
      String alertType,
      String? animalId,
      String? gpsDeviceId,
      double latitude,
      double longitude,
      DateTime detectedAt,
      bool acknowledged,
      DateTime? acknowledgedAt});
}

/// @nodoc
class __$$GeofenceAlertImplCopyWithImpl<$Res>
    extends _$GeofenceAlertCopyWithImpl<$Res, _$GeofenceAlertImpl>
    implements _$$GeofenceAlertImplCopyWith<$Res> {
  __$$GeofenceAlertImplCopyWithImpl(
      _$GeofenceAlertImpl _value, $Res Function(_$GeofenceAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeofenceAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? geofenceId = null,
    Object? geofenceName = null,
    Object? alertType = null,
    Object? animalId = freezed,
    Object? gpsDeviceId = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? detectedAt = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
  }) {
    return _then(_$GeofenceAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceId: null == geofenceId
          ? _value.geofenceId
          : geofenceId // ignore: cast_nullable_to_non_nullable
              as String,
      geofenceName: null == geofenceName
          ? _value.geofenceName
          : geofenceName // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      animalId: freezed == animalId
          ? _value.animalId
          : animalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gpsDeviceId: freezed == gpsDeviceId
          ? _value.gpsDeviceId
          : gpsDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      detectedAt: null == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeofenceAlertImpl implements _GeofenceAlert {
  const _$GeofenceAlertImpl(
      {required this.id,
      required this.geofenceId,
      required this.geofenceName,
      required this.alertType,
      this.animalId,
      this.gpsDeviceId,
      required this.latitude,
      required this.longitude,
      required this.detectedAt,
      this.acknowledged = false,
      this.acknowledgedAt});

  factory _$GeofenceAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeofenceAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String geofenceId;
  @override
  final String geofenceName;
  @override
  final String alertType;
// exit / entry
  @override
  final String? animalId;
  @override
  final String? gpsDeviceId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DateTime detectedAt;
  @override
  @JsonKey()
  final bool acknowledged;
  @override
  final DateTime? acknowledgedAt;

  @override
  String toString() {
    return 'GeofenceAlert(id: $id, geofenceId: $geofenceId, geofenceName: $geofenceName, alertType: $alertType, animalId: $animalId, gpsDeviceId: $gpsDeviceId, latitude: $latitude, longitude: $longitude, detectedAt: $detectedAt, acknowledged: $acknowledged, acknowledgedAt: $acknowledgedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeofenceAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.geofenceId, geofenceId) ||
                other.geofenceId == geofenceId) &&
            (identical(other.geofenceName, geofenceName) ||
                other.geofenceName == geofenceName) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.animalId, animalId) ||
                other.animalId == animalId) &&
            (identical(other.gpsDeviceId, gpsDeviceId) ||
                other.gpsDeviceId == gpsDeviceId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.detectedAt, detectedAt) ||
                other.detectedAt == detectedAt) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      geofenceId,
      geofenceName,
      alertType,
      animalId,
      gpsDeviceId,
      latitude,
      longitude,
      detectedAt,
      acknowledged,
      acknowledgedAt);

  /// Create a copy of GeofenceAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeofenceAlertImplCopyWith<_$GeofenceAlertImpl> get copyWith =>
      __$$GeofenceAlertImplCopyWithImpl<_$GeofenceAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeofenceAlertImplToJson(
      this,
    );
  }
}

abstract class _GeofenceAlert implements GeofenceAlert {
  const factory _GeofenceAlert(
      {required final String id,
      required final String geofenceId,
      required final String geofenceName,
      required final String alertType,
      final String? animalId,
      final String? gpsDeviceId,
      required final double latitude,
      required final double longitude,
      required final DateTime detectedAt,
      final bool acknowledged,
      final DateTime? acknowledgedAt}) = _$GeofenceAlertImpl;

  factory _GeofenceAlert.fromJson(Map<String, dynamic> json) =
      _$GeofenceAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get geofenceId;
  @override
  String get geofenceName;
  @override
  String get alertType; // exit / entry
  @override
  String? get animalId;
  @override
  String? get gpsDeviceId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  DateTime get detectedAt;
  @override
  bool get acknowledged;
  @override
  DateTime? get acknowledgedAt;

  /// Create a copy of GeofenceAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeofenceAlertImplCopyWith<_$GeofenceAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

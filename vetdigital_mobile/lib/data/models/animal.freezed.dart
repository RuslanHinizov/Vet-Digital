// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnimalModel _$AnimalModelFromJson(Map<String, dynamic> json) {
  return _AnimalModel.fromJson(json);
}

/// @nodoc
mixin _$AnimalModel {
  String get id => throw _privateConstructorUsedError;
  String? get identificationNo => throw _privateConstructorUsedError;
  String? get microchipNo => throw _privateConstructorUsedError;
  String? get rfidTagNo => throw _privateConstructorUsedError;
  String get speciesId => throw _privateConstructorUsedError;
  String? get speciesName => throw _privateConstructorUsedError;
  String? get breedId => throw _privateConstructorUsedError;
  String? get breedName => throw _privateConstructorUsedError;
  String? get sex => throw _privateConstructorUsedError; // male / female
  DateTime? get birthDate => throw _privateConstructorUsedError;
  int? get birthYear => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  double? get weightKg => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // active / deceased / sold / lost
  String? get ownerId => throw _privateConstructorUsedError;
  String? get ownerName => throw _privateConstructorUsedError;
  String? get ownerIin => throw _privateConstructorUsedError;
  String? get farmAddress => throw _privateConstructorUsedError;
  double? get farmLatitude => throw _privateConstructorUsedError;
  double? get farmLongitude => throw _privateConstructorUsedError;
  String? get regionKato => throw _privateConstructorUsedError;
  String? get regionName => throw _privateConstructorUsedError;
  String? get gpsDeviceId => throw _privateConstructorUsedError;
  double? get lastLatitude => throw _privateConstructorUsedError;
  double? get lastLongitude => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  String? get localId => throw _privateConstructorUsedError;

  /// Serializes this AnimalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnimalModelCopyWith<AnimalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimalModelCopyWith<$Res> {
  factory $AnimalModelCopyWith(
          AnimalModel value, $Res Function(AnimalModel) then) =
      _$AnimalModelCopyWithImpl<$Res, AnimalModel>;
  @useResult
  $Res call(
      {String id,
      String? identificationNo,
      String? microchipNo,
      String? rfidTagNo,
      String speciesId,
      String? speciesName,
      String? breedId,
      String? breedName,
      String? sex,
      DateTime? birthDate,
      int? birthYear,
      String? color,
      double? weightKg,
      String? status,
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
      bool isSynced,
      String? localId});
}

/// @nodoc
class _$AnimalModelCopyWithImpl<$Res, $Val extends AnimalModel>
    implements $AnimalModelCopyWith<$Res> {
  _$AnimalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identificationNo = freezed,
    Object? microchipNo = freezed,
    Object? rfidTagNo = freezed,
    Object? speciesId = null,
    Object? speciesName = freezed,
    Object? breedId = freezed,
    Object? breedName = freezed,
    Object? sex = freezed,
    Object? birthDate = freezed,
    Object? birthYear = freezed,
    Object? color = freezed,
    Object? weightKg = freezed,
    Object? status = freezed,
    Object? ownerId = freezed,
    Object? ownerName = freezed,
    Object? ownerIin = freezed,
    Object? farmAddress = freezed,
    Object? farmLatitude = freezed,
    Object? farmLongitude = freezed,
    Object? regionKato = freezed,
    Object? regionName = freezed,
    Object? gpsDeviceId = freezed,
    Object? lastLatitude = freezed,
    Object? lastLongitude = freezed,
    Object? lastSeenAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isSynced = null,
    Object? localId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identificationNo: freezed == identificationNo
          ? _value.identificationNo
          : identificationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      microchipNo: freezed == microchipNo
          ? _value.microchipNo
          : microchipNo // ignore: cast_nullable_to_non_nullable
              as String?,
      rfidTagNo: freezed == rfidTagNo
          ? _value.rfidTagNo
          : rfidTagNo // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      speciesName: freezed == speciesName
          ? _value.speciesName
          : speciesName // ignore: cast_nullable_to_non_nullable
              as String?,
      breedId: freezed == breedId
          ? _value.breedId
          : breedId // ignore: cast_nullable_to_non_nullable
              as String?,
      breedName: freezed == breedName
          ? _value.breedName
          : breedName // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthYear: freezed == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      weightKg: freezed == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerIin: freezed == ownerIin
          ? _value.ownerIin
          : ownerIin // ignore: cast_nullable_to_non_nullable
              as String?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      farmLatitude: freezed == farmLatitude
          ? _value.farmLatitude
          : farmLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLongitude: freezed == farmLongitude
          ? _value.farmLongitude
          : farmLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      gpsDeviceId: freezed == gpsDeviceId
          ? _value.gpsDeviceId
          : gpsDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLatitude: freezed == lastLatitude
          ? _value.lastLatitude
          : lastLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLongitude: freezed == lastLongitude
          ? _value.lastLongitude
          : lastLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      localId: freezed == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimalModelImplCopyWith<$Res>
    implements $AnimalModelCopyWith<$Res> {
  factory _$$AnimalModelImplCopyWith(
          _$AnimalModelImpl value, $Res Function(_$AnimalModelImpl) then) =
      __$$AnimalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? identificationNo,
      String? microchipNo,
      String? rfidTagNo,
      String speciesId,
      String? speciesName,
      String? breedId,
      String? breedName,
      String? sex,
      DateTime? birthDate,
      int? birthYear,
      String? color,
      double? weightKg,
      String? status,
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
      bool isSynced,
      String? localId});
}

/// @nodoc
class __$$AnimalModelImplCopyWithImpl<$Res>
    extends _$AnimalModelCopyWithImpl<$Res, _$AnimalModelImpl>
    implements _$$AnimalModelImplCopyWith<$Res> {
  __$$AnimalModelImplCopyWithImpl(
      _$AnimalModelImpl _value, $Res Function(_$AnimalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identificationNo = freezed,
    Object? microchipNo = freezed,
    Object? rfidTagNo = freezed,
    Object? speciesId = null,
    Object? speciesName = freezed,
    Object? breedId = freezed,
    Object? breedName = freezed,
    Object? sex = freezed,
    Object? birthDate = freezed,
    Object? birthYear = freezed,
    Object? color = freezed,
    Object? weightKg = freezed,
    Object? status = freezed,
    Object? ownerId = freezed,
    Object? ownerName = freezed,
    Object? ownerIin = freezed,
    Object? farmAddress = freezed,
    Object? farmLatitude = freezed,
    Object? farmLongitude = freezed,
    Object? regionKato = freezed,
    Object? regionName = freezed,
    Object? gpsDeviceId = freezed,
    Object? lastLatitude = freezed,
    Object? lastLongitude = freezed,
    Object? lastSeenAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isSynced = null,
    Object? localId = freezed,
  }) {
    return _then(_$AnimalModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identificationNo: freezed == identificationNo
          ? _value.identificationNo
          : identificationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      microchipNo: freezed == microchipNo
          ? _value.microchipNo
          : microchipNo // ignore: cast_nullable_to_non_nullable
              as String?,
      rfidTagNo: freezed == rfidTagNo
          ? _value.rfidTagNo
          : rfidTagNo // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      speciesName: freezed == speciesName
          ? _value.speciesName
          : speciesName // ignore: cast_nullable_to_non_nullable
              as String?,
      breedId: freezed == breedId
          ? _value.breedId
          : breedId // ignore: cast_nullable_to_non_nullable
              as String?,
      breedName: freezed == breedName
          ? _value.breedName
          : breedName // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthYear: freezed == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      weightKg: freezed == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerIin: freezed == ownerIin
          ? _value.ownerIin
          : ownerIin // ignore: cast_nullable_to_non_nullable
              as String?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      farmLatitude: freezed == farmLatitude
          ? _value.farmLatitude
          : farmLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLongitude: freezed == farmLongitude
          ? _value.farmLongitude
          : farmLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      gpsDeviceId: freezed == gpsDeviceId
          ? _value.gpsDeviceId
          : gpsDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLatitude: freezed == lastLatitude
          ? _value.lastLatitude
          : lastLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLongitude: freezed == lastLongitude
          ? _value.lastLongitude
          : lastLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      localId: freezed == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimalModelImpl implements _AnimalModel {
  const _$AnimalModelImpl(
      {required this.id,
      this.identificationNo,
      this.microchipNo,
      this.rfidTagNo,
      required this.speciesId,
      this.speciesName,
      this.breedId,
      this.breedName,
      this.sex,
      this.birthDate,
      this.birthYear,
      this.color,
      this.weightKg,
      this.status,
      this.ownerId,
      this.ownerName,
      this.ownerIin,
      this.farmAddress,
      this.farmLatitude,
      this.farmLongitude,
      this.regionKato,
      this.regionName,
      this.gpsDeviceId,
      this.lastLatitude,
      this.lastLongitude,
      this.lastSeenAt,
      this.createdAt,
      this.updatedAt,
      this.isSynced = false,
      this.localId});

  factory _$AnimalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? identificationNo;
  @override
  final String? microchipNo;
  @override
  final String? rfidTagNo;
  @override
  final String speciesId;
  @override
  final String? speciesName;
  @override
  final String? breedId;
  @override
  final String? breedName;
  @override
  final String? sex;
// male / female
  @override
  final DateTime? birthDate;
  @override
  final int? birthYear;
  @override
  final String? color;
  @override
  final double? weightKg;
  @override
  final String? status;
// active / deceased / sold / lost
  @override
  final String? ownerId;
  @override
  final String? ownerName;
  @override
  final String? ownerIin;
  @override
  final String? farmAddress;
  @override
  final double? farmLatitude;
  @override
  final double? farmLongitude;
  @override
  final String? regionKato;
  @override
  final String? regionName;
  @override
  final String? gpsDeviceId;
  @override
  final double? lastLatitude;
  @override
  final double? lastLongitude;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final String? localId;

  @override
  String toString() {
    return 'AnimalModel(id: $id, identificationNo: $identificationNo, microchipNo: $microchipNo, rfidTagNo: $rfidTagNo, speciesId: $speciesId, speciesName: $speciesName, breedId: $breedId, breedName: $breedName, sex: $sex, birthDate: $birthDate, birthYear: $birthYear, color: $color, weightKg: $weightKg, status: $status, ownerId: $ownerId, ownerName: $ownerName, ownerIin: $ownerIin, farmAddress: $farmAddress, farmLatitude: $farmLatitude, farmLongitude: $farmLongitude, regionKato: $regionKato, regionName: $regionName, gpsDeviceId: $gpsDeviceId, lastLatitude: $lastLatitude, lastLongitude: $lastLongitude, lastSeenAt: $lastSeenAt, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced, localId: $localId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.identificationNo, identificationNo) ||
                other.identificationNo == identificationNo) &&
            (identical(other.microchipNo, microchipNo) ||
                other.microchipNo == microchipNo) &&
            (identical(other.rfidTagNo, rfidTagNo) ||
                other.rfidTagNo == rfidTagNo) &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.speciesName, speciesName) ||
                other.speciesName == speciesName) &&
            (identical(other.breedId, breedId) || other.breedId == breedId) &&
            (identical(other.breedName, breedName) ||
                other.breedName == breedName) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.birthYear, birthYear) ||
                other.birthYear == birthYear) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.ownerIin, ownerIin) ||
                other.ownerIin == ownerIin) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.farmLatitude, farmLatitude) ||
                other.farmLatitude == farmLatitude) &&
            (identical(other.farmLongitude, farmLongitude) ||
                other.farmLongitude == farmLongitude) &&
            (identical(other.regionKato, regionKato) ||
                other.regionKato == regionKato) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.gpsDeviceId, gpsDeviceId) ||
                other.gpsDeviceId == gpsDeviceId) &&
            (identical(other.lastLatitude, lastLatitude) ||
                other.lastLatitude == lastLatitude) &&
            (identical(other.lastLongitude, lastLongitude) ||
                other.lastLongitude == lastLongitude) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.localId, localId) || other.localId == localId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        identificationNo,
        microchipNo,
        rfidTagNo,
        speciesId,
        speciesName,
        breedId,
        breedName,
        sex,
        birthDate,
        birthYear,
        color,
        weightKg,
        status,
        ownerId,
        ownerName,
        ownerIin,
        farmAddress,
        farmLatitude,
        farmLongitude,
        regionKato,
        regionName,
        gpsDeviceId,
        lastLatitude,
        lastLongitude,
        lastSeenAt,
        createdAt,
        updatedAt,
        isSynced,
        localId
      ]);

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimalModelImplCopyWith<_$AnimalModelImpl> get copyWith =>
      __$$AnimalModelImplCopyWithImpl<_$AnimalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimalModelImplToJson(
      this,
    );
  }
}

abstract class _AnimalModel implements AnimalModel {
  const factory _AnimalModel(
      {required final String id,
      final String? identificationNo,
      final String? microchipNo,
      final String? rfidTagNo,
      required final String speciesId,
      final String? speciesName,
      final String? breedId,
      final String? breedName,
      final String? sex,
      final DateTime? birthDate,
      final int? birthYear,
      final String? color,
      final double? weightKg,
      final String? status,
      final String? ownerId,
      final String? ownerName,
      final String? ownerIin,
      final String? farmAddress,
      final double? farmLatitude,
      final double? farmLongitude,
      final String? regionKato,
      final String? regionName,
      final String? gpsDeviceId,
      final double? lastLatitude,
      final double? lastLongitude,
      final DateTime? lastSeenAt,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final bool isSynced,
      final String? localId}) = _$AnimalModelImpl;

  factory _AnimalModel.fromJson(Map<String, dynamic> json) =
      _$AnimalModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get identificationNo;
  @override
  String? get microchipNo;
  @override
  String? get rfidTagNo;
  @override
  String get speciesId;
  @override
  String? get speciesName;
  @override
  String? get breedId;
  @override
  String? get breedName;
  @override
  String? get sex; // male / female
  @override
  DateTime? get birthDate;
  @override
  int? get birthYear;
  @override
  String? get color;
  @override
  double? get weightKg;
  @override
  String? get status; // active / deceased / sold / lost
  @override
  String? get ownerId;
  @override
  String? get ownerName;
  @override
  String? get ownerIin;
  @override
  String? get farmAddress;
  @override
  double? get farmLatitude;
  @override
  double? get farmLongitude;
  @override
  String? get regionKato;
  @override
  String? get regionName;
  @override
  String? get gpsDeviceId;
  @override
  double? get lastLatitude;
  @override
  double? get lastLongitude;
  @override
  DateTime? get lastSeenAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isSynced;
  @override
  String? get localId;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnimalModelImplCopyWith<_$AnimalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnimalListResponse _$AnimalListResponseFromJson(Map<String, dynamic> json) {
  return _AnimalListResponse.fromJson(json);
}

/// @nodoc
mixin _$AnimalListResponse {
  List<AnimalModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get pages => throw _privateConstructorUsedError;

  /// Serializes this AnimalListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnimalListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnimalListResponseCopyWith<AnimalListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimalListResponseCopyWith<$Res> {
  factory $AnimalListResponseCopyWith(
          AnimalListResponse value, $Res Function(AnimalListResponse) then) =
      _$AnimalListResponseCopyWithImpl<$Res, AnimalListResponse>;
  @useResult
  $Res call(
      {List<AnimalModel> items, int total, int page, int pageSize, int pages});
}

/// @nodoc
class _$AnimalListResponseCopyWithImpl<$Res, $Val extends AnimalListResponse>
    implements $AnimalListResponseCopyWith<$Res> {
  _$AnimalListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnimalListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AnimalModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimalListResponseImplCopyWith<$Res>
    implements $AnimalListResponseCopyWith<$Res> {
  factory _$$AnimalListResponseImplCopyWith(_$AnimalListResponseImpl value,
          $Res Function(_$AnimalListResponseImpl) then) =
      __$$AnimalListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AnimalModel> items, int total, int page, int pageSize, int pages});
}

/// @nodoc
class __$$AnimalListResponseImplCopyWithImpl<$Res>
    extends _$AnimalListResponseCopyWithImpl<$Res, _$AnimalListResponseImpl>
    implements _$$AnimalListResponseImplCopyWith<$Res> {
  __$$AnimalListResponseImplCopyWithImpl(_$AnimalListResponseImpl _value,
      $Res Function(_$AnimalListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnimalListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? pages = null,
  }) {
    return _then(_$AnimalListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AnimalModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimalListResponseImpl implements _AnimalListResponse {
  const _$AnimalListResponseImpl(
      {required final List<AnimalModel> items,
      required this.total,
      required this.page,
      required this.pageSize,
      required this.pages})
      : _items = items;

  factory _$AnimalListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimalListResponseImplFromJson(json);

  final List<AnimalModel> _items;
  @override
  List<AnimalModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int pages;

  @override
  String toString() {
    return 'AnimalListResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimalListResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.pages, pages) || other.pages == pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      total,
      page,
      pageSize,
      pages);

  /// Create a copy of AnimalListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimalListResponseImplCopyWith<_$AnimalListResponseImpl> get copyWith =>
      __$$AnimalListResponseImplCopyWithImpl<_$AnimalListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimalListResponseImplToJson(
      this,
    );
  }
}

abstract class _AnimalListResponse implements AnimalListResponse {
  const factory _AnimalListResponse(
      {required final List<AnimalModel> items,
      required final int total,
      required final int page,
      required final int pageSize,
      required final int pages}) = _$AnimalListResponseImpl;

  factory _AnimalListResponse.fromJson(Map<String, dynamic> json) =
      _$AnimalListResponseImpl.fromJson;

  @override
  List<AnimalModel> get items;
  @override
  int get total;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get pages;

  /// Create a copy of AnimalListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnimalListResponseImplCopyWith<_$AnimalListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GpsReading _$GpsReadingFromJson(Map<String, dynamic> json) {
  return _GpsReading.fromJson(json);
}

/// @nodoc
mixin _$GpsReading {
  String get id => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get altitude => throw _privateConstructorUsedError;
  double? get speedKmh => throw _privateConstructorUsedError;
  double? get batteryLevel => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this GpsReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GpsReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GpsReadingCopyWith<GpsReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpsReadingCopyWith<$Res> {
  factory $GpsReadingCopyWith(
          GpsReading value, $Res Function(GpsReading) then) =
      _$GpsReadingCopyWithImpl<$Res, GpsReading>;
  @useResult
  $Res call(
      {String id,
      String deviceId,
      double latitude,
      double longitude,
      double? altitude,
      double? speedKmh,
      double? batteryLevel,
      DateTime timestamp});
}

/// @nodoc
class _$GpsReadingCopyWithImpl<$Res, $Val extends GpsReading>
    implements $GpsReadingCopyWith<$Res> {
  _$GpsReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GpsReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitude = freezed,
    Object? speedKmh = freezed,
    Object? batteryLevel = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: freezed == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double?,
      speedKmh: freezed == speedKmh
          ? _value.speedKmh
          : speedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GpsReadingImplCopyWith<$Res>
    implements $GpsReadingCopyWith<$Res> {
  factory _$$GpsReadingImplCopyWith(
          _$GpsReadingImpl value, $Res Function(_$GpsReadingImpl) then) =
      __$$GpsReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String deviceId,
      double latitude,
      double longitude,
      double? altitude,
      double? speedKmh,
      double? batteryLevel,
      DateTime timestamp});
}

/// @nodoc
class __$$GpsReadingImplCopyWithImpl<$Res>
    extends _$GpsReadingCopyWithImpl<$Res, _$GpsReadingImpl>
    implements _$$GpsReadingImplCopyWith<$Res> {
  __$$GpsReadingImplCopyWithImpl(
      _$GpsReadingImpl _value, $Res Function(_$GpsReadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GpsReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitude = freezed,
    Object? speedKmh = freezed,
    Object? batteryLevel = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$GpsReadingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: freezed == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double?,
      speedKmh: freezed == speedKmh
          ? _value.speedKmh
          : speedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GpsReadingImpl implements _GpsReading {
  const _$GpsReadingImpl(
      {required this.id,
      required this.deviceId,
      required this.latitude,
      required this.longitude,
      this.altitude,
      this.speedKmh,
      this.batteryLevel,
      required this.timestamp});

  factory _$GpsReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$GpsReadingImplFromJson(json);

  @override
  final String id;
  @override
  final String deviceId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? altitude;
  @override
  final double? speedKmh;
  @override
  final double? batteryLevel;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'GpsReading(id: $id, deviceId: $deviceId, latitude: $latitude, longitude: $longitude, altitude: $altitude, speedKmh: $speedKmh, batteryLevel: $batteryLevel, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GpsReadingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.speedKmh, speedKmh) ||
                other.speedKmh == speedKmh) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, deviceId, latitude,
      longitude, altitude, speedKmh, batteryLevel, timestamp);

  /// Create a copy of GpsReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GpsReadingImplCopyWith<_$GpsReadingImpl> get copyWith =>
      __$$GpsReadingImplCopyWithImpl<_$GpsReadingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GpsReadingImplToJson(
      this,
    );
  }
}

abstract class _GpsReading implements GpsReading {
  const factory _GpsReading(
      {required final String id,
      required final String deviceId,
      required final double latitude,
      required final double longitude,
      final double? altitude,
      final double? speedKmh,
      final double? batteryLevel,
      required final DateTime timestamp}) = _$GpsReadingImpl;

  factory _GpsReading.fromJson(Map<String, dynamic> json) =
      _$GpsReadingImpl.fromJson;

  @override
  String get id;
  @override
  String get deviceId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get altitude;
  @override
  double? get speedKmh;
  @override
  double? get batteryLevel;
  @override
  DateTime get timestamp;

  /// Create a copy of GpsReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GpsReadingImplCopyWith<_$GpsReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

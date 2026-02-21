// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcedureActModel _$ProcedureActModelFromJson(Map<String, dynamic> json) {
  return _ProcedureActModel.fromJson(json);
}

/// @nodoc
mixin _$ProcedureActModel {
  String get id => throw _privateConstructorUsedError;
  String get actNumber => throw _privateConstructorUsedError;
  DateTime get actDate => throw _privateConstructorUsedError;
  String get procedureType =>
      throw _privateConstructorUsedError; // vaccination / allergy_test / deworming / treatment
  String? get diseaseName => throw _privateConstructorUsedError;
  String? get regionKato => throw _privateConstructorUsedError;
  String? get regionName => throw _privateConstructorUsedError;
  String? get settlement => throw _privateConstructorUsedError;
  String get specialistId => throw _privateConstructorUsedError;
  String? get specialistName => throw _privateConstructorUsedError;
  String? get participantsJson =>
      throw _privateConstructorUsedError; // JSON list of participant names
  String? get ownerIin => throw _privateConstructorUsedError;
  String? get ownerName => throw _privateConstructorUsedError;
  String? get speciesId => throw _privateConstructorUsedError;
  String? get speciesName => throw _privateConstructorUsedError;
  int? get maleCount => throw _privateConstructorUsedError;
  int? get femaleCount => throw _privateConstructorUsedError;
  int? get youngCount => throw _privateConstructorUsedError;
  int? get totalVaccinated => throw _privateConstructorUsedError;
  String? get vaccineName => throw _privateConstructorUsedError;
  String? get allergenName => throw _privateConstructorUsedError;
  String? get manufacturer => throw _privateConstructorUsedError;
  DateTime? get productionDate => throw _privateConstructorUsedError;
  String? get series => throw _privateConstructorUsedError;
  String? get stateControlNo => throw _privateConstructorUsedError;
  String? get injectionMethod => throw _privateConstructorUsedError;
  double? get doseAdultMl => throw _privateConstructorUsedError;
  double? get doseYoungMl => throw _privateConstructorUsedError;
  int? get allergenReadingHours => throw _privateConstructorUsedError;
  String? get materialsJson =>
      throw _privateConstructorUsedError; // JSON list of expendable materials
  String? get status =>
      throw _privateConstructorUsedError; // draft / pending_signature / signed / archived
  String? get pdfUrl => throw _privateConstructorUsedError;
  DateTime? get signedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<ProcedureActAnimalModel> get animals =>
      throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  String? get localId => throw _privateConstructorUsedError;

  /// Serializes this ProcedureActModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcedureActModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcedureActModelCopyWith<ProcedureActModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureActModelCopyWith<$Res> {
  factory $ProcedureActModelCopyWith(
          ProcedureActModel value, $Res Function(ProcedureActModel) then) =
      _$ProcedureActModelCopyWithImpl<$Res, ProcedureActModel>;
  @useResult
  $Res call(
      {String id,
      String actNumber,
      DateTime actDate,
      String procedureType,
      String? diseaseName,
      String? regionKato,
      String? regionName,
      String? settlement,
      String specialistId,
      String? specialistName,
      String? participantsJson,
      String? ownerIin,
      String? ownerName,
      String? speciesId,
      String? speciesName,
      int? maleCount,
      int? femaleCount,
      int? youngCount,
      int? totalVaccinated,
      String? vaccineName,
      String? allergenName,
      String? manufacturer,
      DateTime? productionDate,
      String? series,
      String? stateControlNo,
      String? injectionMethod,
      double? doseAdultMl,
      double? doseYoungMl,
      int? allergenReadingHours,
      String? materialsJson,
      String? status,
      String? pdfUrl,
      DateTime? signedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<ProcedureActAnimalModel> animals,
      bool isSynced,
      String? localId});
}

/// @nodoc
class _$ProcedureActModelCopyWithImpl<$Res, $Val extends ProcedureActModel>
    implements $ProcedureActModelCopyWith<$Res> {
  _$ProcedureActModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProcedureActModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actNumber = null,
    Object? actDate = null,
    Object? procedureType = null,
    Object? diseaseName = freezed,
    Object? regionKato = freezed,
    Object? regionName = freezed,
    Object? settlement = freezed,
    Object? specialistId = null,
    Object? specialistName = freezed,
    Object? participantsJson = freezed,
    Object? ownerIin = freezed,
    Object? ownerName = freezed,
    Object? speciesId = freezed,
    Object? speciesName = freezed,
    Object? maleCount = freezed,
    Object? femaleCount = freezed,
    Object? youngCount = freezed,
    Object? totalVaccinated = freezed,
    Object? vaccineName = freezed,
    Object? allergenName = freezed,
    Object? manufacturer = freezed,
    Object? productionDate = freezed,
    Object? series = freezed,
    Object? stateControlNo = freezed,
    Object? injectionMethod = freezed,
    Object? doseAdultMl = freezed,
    Object? doseYoungMl = freezed,
    Object? allergenReadingHours = freezed,
    Object? materialsJson = freezed,
    Object? status = freezed,
    Object? pdfUrl = freezed,
    Object? signedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? animals = null,
    Object? isSynced = null,
    Object? localId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actNumber: null == actNumber
          ? _value.actNumber
          : actNumber // ignore: cast_nullable_to_non_nullable
              as String,
      actDate: null == actDate
          ? _value.actDate
          : actDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      procedureType: null == procedureType
          ? _value.procedureType
          : procedureType // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseName: freezed == diseaseName
          ? _value.diseaseName
          : diseaseName // ignore: cast_nullable_to_non_nullable
              as String?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      settlement: freezed == settlement
          ? _value.settlement
          : settlement // ignore: cast_nullable_to_non_nullable
              as String?,
      specialistId: null == specialistId
          ? _value.specialistId
          : specialistId // ignore: cast_nullable_to_non_nullable
              as String,
      specialistName: freezed == specialistName
          ? _value.specialistName
          : specialistName // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsJson: freezed == participantsJson
          ? _value.participantsJson
          : participantsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerIin: freezed == ownerIin
          ? _value.ownerIin
          : ownerIin // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesId: freezed == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesName: freezed == speciesName
          ? _value.speciesName
          : speciesName // ignore: cast_nullable_to_non_nullable
              as String?,
      maleCount: freezed == maleCount
          ? _value.maleCount
          : maleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      femaleCount: freezed == femaleCount
          ? _value.femaleCount
          : femaleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      youngCount: freezed == youngCount
          ? _value.youngCount
          : youngCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVaccinated: freezed == totalVaccinated
          ? _value.totalVaccinated
          : totalVaccinated // ignore: cast_nullable_to_non_nullable
              as int?,
      vaccineName: freezed == vaccineName
          ? _value.vaccineName
          : vaccineName // ignore: cast_nullable_to_non_nullable
              as String?,
      allergenName: freezed == allergenName
          ? _value.allergenName
          : allergenName // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      stateControlNo: freezed == stateControlNo
          ? _value.stateControlNo
          : stateControlNo // ignore: cast_nullable_to_non_nullable
              as String?,
      injectionMethod: freezed == injectionMethod
          ? _value.injectionMethod
          : injectionMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      doseAdultMl: freezed == doseAdultMl
          ? _value.doseAdultMl
          : doseAdultMl // ignore: cast_nullable_to_non_nullable
              as double?,
      doseYoungMl: freezed == doseYoungMl
          ? _value.doseYoungMl
          : doseYoungMl // ignore: cast_nullable_to_non_nullable
              as double?,
      allergenReadingHours: freezed == allergenReadingHours
          ? _value.allergenReadingHours
          : allergenReadingHours // ignore: cast_nullable_to_non_nullable
              as int?,
      materialsJson: freezed == materialsJson
          ? _value.materialsJson
          : materialsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      signedAt: freezed == signedAt
          ? _value.signedAt
          : signedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      animals: null == animals
          ? _value.animals
          : animals // ignore: cast_nullable_to_non_nullable
              as List<ProcedureActAnimalModel>,
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
abstract class _$$ProcedureActModelImplCopyWith<$Res>
    implements $ProcedureActModelCopyWith<$Res> {
  factory _$$ProcedureActModelImplCopyWith(_$ProcedureActModelImpl value,
          $Res Function(_$ProcedureActModelImpl) then) =
      __$$ProcedureActModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String actNumber,
      DateTime actDate,
      String procedureType,
      String? diseaseName,
      String? regionKato,
      String? regionName,
      String? settlement,
      String specialistId,
      String? specialistName,
      String? participantsJson,
      String? ownerIin,
      String? ownerName,
      String? speciesId,
      String? speciesName,
      int? maleCount,
      int? femaleCount,
      int? youngCount,
      int? totalVaccinated,
      String? vaccineName,
      String? allergenName,
      String? manufacturer,
      DateTime? productionDate,
      String? series,
      String? stateControlNo,
      String? injectionMethod,
      double? doseAdultMl,
      double? doseYoungMl,
      int? allergenReadingHours,
      String? materialsJson,
      String? status,
      String? pdfUrl,
      DateTime? signedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<ProcedureActAnimalModel> animals,
      bool isSynced,
      String? localId});
}

/// @nodoc
class __$$ProcedureActModelImplCopyWithImpl<$Res>
    extends _$ProcedureActModelCopyWithImpl<$Res, _$ProcedureActModelImpl>
    implements _$$ProcedureActModelImplCopyWith<$Res> {
  __$$ProcedureActModelImplCopyWithImpl(_$ProcedureActModelImpl _value,
      $Res Function(_$ProcedureActModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProcedureActModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actNumber = null,
    Object? actDate = null,
    Object? procedureType = null,
    Object? diseaseName = freezed,
    Object? regionKato = freezed,
    Object? regionName = freezed,
    Object? settlement = freezed,
    Object? specialistId = null,
    Object? specialistName = freezed,
    Object? participantsJson = freezed,
    Object? ownerIin = freezed,
    Object? ownerName = freezed,
    Object? speciesId = freezed,
    Object? speciesName = freezed,
    Object? maleCount = freezed,
    Object? femaleCount = freezed,
    Object? youngCount = freezed,
    Object? totalVaccinated = freezed,
    Object? vaccineName = freezed,
    Object? allergenName = freezed,
    Object? manufacturer = freezed,
    Object? productionDate = freezed,
    Object? series = freezed,
    Object? stateControlNo = freezed,
    Object? injectionMethod = freezed,
    Object? doseAdultMl = freezed,
    Object? doseYoungMl = freezed,
    Object? allergenReadingHours = freezed,
    Object? materialsJson = freezed,
    Object? status = freezed,
    Object? pdfUrl = freezed,
    Object? signedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? animals = null,
    Object? isSynced = null,
    Object? localId = freezed,
  }) {
    return _then(_$ProcedureActModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actNumber: null == actNumber
          ? _value.actNumber
          : actNumber // ignore: cast_nullable_to_non_nullable
              as String,
      actDate: null == actDate
          ? _value.actDate
          : actDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      procedureType: null == procedureType
          ? _value.procedureType
          : procedureType // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseName: freezed == diseaseName
          ? _value.diseaseName
          : diseaseName // ignore: cast_nullable_to_non_nullable
              as String?,
      regionKato: freezed == regionKato
          ? _value.regionKato
          : regionKato // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      settlement: freezed == settlement
          ? _value.settlement
          : settlement // ignore: cast_nullable_to_non_nullable
              as String?,
      specialistId: null == specialistId
          ? _value.specialistId
          : specialistId // ignore: cast_nullable_to_non_nullable
              as String,
      specialistName: freezed == specialistName
          ? _value.specialistName
          : specialistName // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsJson: freezed == participantsJson
          ? _value.participantsJson
          : participantsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerIin: freezed == ownerIin
          ? _value.ownerIin
          : ownerIin // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesId: freezed == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String?,
      speciesName: freezed == speciesName
          ? _value.speciesName
          : speciesName // ignore: cast_nullable_to_non_nullable
              as String?,
      maleCount: freezed == maleCount
          ? _value.maleCount
          : maleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      femaleCount: freezed == femaleCount
          ? _value.femaleCount
          : femaleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      youngCount: freezed == youngCount
          ? _value.youngCount
          : youngCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVaccinated: freezed == totalVaccinated
          ? _value.totalVaccinated
          : totalVaccinated // ignore: cast_nullable_to_non_nullable
              as int?,
      vaccineName: freezed == vaccineName
          ? _value.vaccineName
          : vaccineName // ignore: cast_nullable_to_non_nullable
              as String?,
      allergenName: freezed == allergenName
          ? _value.allergenName
          : allergenName // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      stateControlNo: freezed == stateControlNo
          ? _value.stateControlNo
          : stateControlNo // ignore: cast_nullable_to_non_nullable
              as String?,
      injectionMethod: freezed == injectionMethod
          ? _value.injectionMethod
          : injectionMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      doseAdultMl: freezed == doseAdultMl
          ? _value.doseAdultMl
          : doseAdultMl // ignore: cast_nullable_to_non_nullable
              as double?,
      doseYoungMl: freezed == doseYoungMl
          ? _value.doseYoungMl
          : doseYoungMl // ignore: cast_nullable_to_non_nullable
              as double?,
      allergenReadingHours: freezed == allergenReadingHours
          ? _value.allergenReadingHours
          : allergenReadingHours // ignore: cast_nullable_to_non_nullable
              as int?,
      materialsJson: freezed == materialsJson
          ? _value.materialsJson
          : materialsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      signedAt: freezed == signedAt
          ? _value.signedAt
          : signedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      animals: null == animals
          ? _value._animals
          : animals // ignore: cast_nullable_to_non_nullable
              as List<ProcedureActAnimalModel>,
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
class _$ProcedureActModelImpl implements _ProcedureActModel {
  const _$ProcedureActModelImpl(
      {required this.id,
      required this.actNumber,
      required this.actDate,
      required this.procedureType,
      this.diseaseName,
      this.regionKato,
      this.regionName,
      this.settlement,
      required this.specialistId,
      this.specialistName,
      this.participantsJson,
      this.ownerIin,
      this.ownerName,
      this.speciesId,
      this.speciesName,
      this.maleCount,
      this.femaleCount,
      this.youngCount,
      this.totalVaccinated,
      this.vaccineName,
      this.allergenName,
      this.manufacturer,
      this.productionDate,
      this.series,
      this.stateControlNo,
      this.injectionMethod,
      this.doseAdultMl,
      this.doseYoungMl,
      this.allergenReadingHours,
      this.materialsJson,
      this.status,
      this.pdfUrl,
      this.signedAt,
      this.createdAt,
      this.updatedAt,
      final List<ProcedureActAnimalModel> animals = const [],
      this.isSynced = false,
      this.localId})
      : _animals = animals;

  factory _$ProcedureActModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureActModelImplFromJson(json);

  @override
  final String id;
  @override
  final String actNumber;
  @override
  final DateTime actDate;
  @override
  final String procedureType;
// vaccination / allergy_test / deworming / treatment
  @override
  final String? diseaseName;
  @override
  final String? regionKato;
  @override
  final String? regionName;
  @override
  final String? settlement;
  @override
  final String specialistId;
  @override
  final String? specialistName;
  @override
  final String? participantsJson;
// JSON list of participant names
  @override
  final String? ownerIin;
  @override
  final String? ownerName;
  @override
  final String? speciesId;
  @override
  final String? speciesName;
  @override
  final int? maleCount;
  @override
  final int? femaleCount;
  @override
  final int? youngCount;
  @override
  final int? totalVaccinated;
  @override
  final String? vaccineName;
  @override
  final String? allergenName;
  @override
  final String? manufacturer;
  @override
  final DateTime? productionDate;
  @override
  final String? series;
  @override
  final String? stateControlNo;
  @override
  final String? injectionMethod;
  @override
  final double? doseAdultMl;
  @override
  final double? doseYoungMl;
  @override
  final int? allergenReadingHours;
  @override
  final String? materialsJson;
// JSON list of expendable materials
  @override
  final String? status;
// draft / pending_signature / signed / archived
  @override
  final String? pdfUrl;
  @override
  final DateTime? signedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<ProcedureActAnimalModel> _animals;
  @override
  @JsonKey()
  List<ProcedureActAnimalModel> get animals {
    if (_animals is EqualUnmodifiableListView) return _animals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_animals);
  }

  @override
  @JsonKey()
  final bool isSynced;
  @override
  final String? localId;

  @override
  String toString() {
    return 'ProcedureActModel(id: $id, actNumber: $actNumber, actDate: $actDate, procedureType: $procedureType, diseaseName: $diseaseName, regionKato: $regionKato, regionName: $regionName, settlement: $settlement, specialistId: $specialistId, specialistName: $specialistName, participantsJson: $participantsJson, ownerIin: $ownerIin, ownerName: $ownerName, speciesId: $speciesId, speciesName: $speciesName, maleCount: $maleCount, femaleCount: $femaleCount, youngCount: $youngCount, totalVaccinated: $totalVaccinated, vaccineName: $vaccineName, allergenName: $allergenName, manufacturer: $manufacturer, productionDate: $productionDate, series: $series, stateControlNo: $stateControlNo, injectionMethod: $injectionMethod, doseAdultMl: $doseAdultMl, doseYoungMl: $doseYoungMl, allergenReadingHours: $allergenReadingHours, materialsJson: $materialsJson, status: $status, pdfUrl: $pdfUrl, signedAt: $signedAt, createdAt: $createdAt, updatedAt: $updatedAt, animals: $animals, isSynced: $isSynced, localId: $localId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureActModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actNumber, actNumber) ||
                other.actNumber == actNumber) &&
            (identical(other.actDate, actDate) || other.actDate == actDate) &&
            (identical(other.procedureType, procedureType) ||
                other.procedureType == procedureType) &&
            (identical(other.diseaseName, diseaseName) ||
                other.diseaseName == diseaseName) &&
            (identical(other.regionKato, regionKato) ||
                other.regionKato == regionKato) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.settlement, settlement) ||
                other.settlement == settlement) &&
            (identical(other.specialistId, specialistId) ||
                other.specialistId == specialistId) &&
            (identical(other.specialistName, specialistName) ||
                other.specialistName == specialistName) &&
            (identical(other.participantsJson, participantsJson) ||
                other.participantsJson == participantsJson) &&
            (identical(other.ownerIin, ownerIin) ||
                other.ownerIin == ownerIin) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.speciesName, speciesName) ||
                other.speciesName == speciesName) &&
            (identical(other.maleCount, maleCount) ||
                other.maleCount == maleCount) &&
            (identical(other.femaleCount, femaleCount) ||
                other.femaleCount == femaleCount) &&
            (identical(other.youngCount, youngCount) ||
                other.youngCount == youngCount) &&
            (identical(other.totalVaccinated, totalVaccinated) ||
                other.totalVaccinated == totalVaccinated) &&
            (identical(other.vaccineName, vaccineName) ||
                other.vaccineName == vaccineName) &&
            (identical(other.allergenName, allergenName) ||
                other.allergenName == allergenName) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.stateControlNo, stateControlNo) ||
                other.stateControlNo == stateControlNo) &&
            (identical(other.injectionMethod, injectionMethod) ||
                other.injectionMethod == injectionMethod) &&
            (identical(other.doseAdultMl, doseAdultMl) ||
                other.doseAdultMl == doseAdultMl) &&
            (identical(other.doseYoungMl, doseYoungMl) ||
                other.doseYoungMl == doseYoungMl) &&
            (identical(other.allergenReadingHours, allergenReadingHours) ||
                other.allergenReadingHours == allergenReadingHours) &&
            (identical(other.materialsJson, materialsJson) ||
                other.materialsJson == materialsJson) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.signedAt, signedAt) ||
                other.signedAt == signedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._animals, _animals) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.localId, localId) || other.localId == localId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        actNumber,
        actDate,
        procedureType,
        diseaseName,
        regionKato,
        regionName,
        settlement,
        specialistId,
        specialistName,
        participantsJson,
        ownerIin,
        ownerName,
        speciesId,
        speciesName,
        maleCount,
        femaleCount,
        youngCount,
        totalVaccinated,
        vaccineName,
        allergenName,
        manufacturer,
        productionDate,
        series,
        stateControlNo,
        injectionMethod,
        doseAdultMl,
        doseYoungMl,
        allergenReadingHours,
        materialsJson,
        status,
        pdfUrl,
        signedAt,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_animals),
        isSynced,
        localId
      ]);

  /// Create a copy of ProcedureActModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcedureActModelImplCopyWith<_$ProcedureActModelImpl> get copyWith =>
      __$$ProcedureActModelImplCopyWithImpl<_$ProcedureActModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcedureActModelImplToJson(
      this,
    );
  }
}

abstract class _ProcedureActModel implements ProcedureActModel {
  const factory _ProcedureActModel(
      {required final String id,
      required final String actNumber,
      required final DateTime actDate,
      required final String procedureType,
      final String? diseaseName,
      final String? regionKato,
      final String? regionName,
      final String? settlement,
      required final String specialistId,
      final String? specialistName,
      final String? participantsJson,
      final String? ownerIin,
      final String? ownerName,
      final String? speciesId,
      final String? speciesName,
      final int? maleCount,
      final int? femaleCount,
      final int? youngCount,
      final int? totalVaccinated,
      final String? vaccineName,
      final String? allergenName,
      final String? manufacturer,
      final DateTime? productionDate,
      final String? series,
      final String? stateControlNo,
      final String? injectionMethod,
      final double? doseAdultMl,
      final double? doseYoungMl,
      final int? allergenReadingHours,
      final String? materialsJson,
      final String? status,
      final String? pdfUrl,
      final DateTime? signedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<ProcedureActAnimalModel> animals,
      final bool isSynced,
      final String? localId}) = _$ProcedureActModelImpl;

  factory _ProcedureActModel.fromJson(Map<String, dynamic> json) =
      _$ProcedureActModelImpl.fromJson;

  @override
  String get id;
  @override
  String get actNumber;
  @override
  DateTime get actDate;
  @override
  String
      get procedureType; // vaccination / allergy_test / deworming / treatment
  @override
  String? get diseaseName;
  @override
  String? get regionKato;
  @override
  String? get regionName;
  @override
  String? get settlement;
  @override
  String get specialistId;
  @override
  String? get specialistName;
  @override
  String? get participantsJson; // JSON list of participant names
  @override
  String? get ownerIin;
  @override
  String? get ownerName;
  @override
  String? get speciesId;
  @override
  String? get speciesName;
  @override
  int? get maleCount;
  @override
  int? get femaleCount;
  @override
  int? get youngCount;
  @override
  int? get totalVaccinated;
  @override
  String? get vaccineName;
  @override
  String? get allergenName;
  @override
  String? get manufacturer;
  @override
  DateTime? get productionDate;
  @override
  String? get series;
  @override
  String? get stateControlNo;
  @override
  String? get injectionMethod;
  @override
  double? get doseAdultMl;
  @override
  double? get doseYoungMl;
  @override
  int? get allergenReadingHours;
  @override
  String? get materialsJson; // JSON list of expendable materials
  @override
  String? get status; // draft / pending_signature / signed / archived
  @override
  String? get pdfUrl;
  @override
  DateTime? get signedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<ProcedureActAnimalModel> get animals;
  @override
  bool get isSynced;
  @override
  String? get localId;

  /// Create a copy of ProcedureActModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureActModelImplCopyWith<_$ProcedureActModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProcedureActAnimalModel _$ProcedureActAnimalModelFromJson(
    Map<String, dynamic> json) {
  return _ProcedureActAnimalModel.fromJson(json);
}

/// @nodoc
mixin _$ProcedureActAnimalModel {
  String get id => throw _privateConstructorUsedError;
  String get actId => throw _privateConstructorUsedError;
  String? get animalId => throw _privateConstructorUsedError;
  String? get identificationNo => throw _privateConstructorUsedError;
  String? get sex => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError; // adult / young
  String? get color => throw _privateConstructorUsedError;
  double? get skinMeasurementMm =>
      throw _privateConstructorUsedError; // allergy test: initial measurement
  double? get resultMm =>
      throw _privateConstructorUsedError; // allergy test: result reading
  double? get differenceMm =>
      throw _privateConstructorUsedError; // computed: result - initial
  String? get allergyResult =>
      throw _privateConstructorUsedError; // negative / positive / doubtful
  DateTime? get vaccinationDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ProcedureActAnimalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcedureActAnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcedureActAnimalModelCopyWith<ProcedureActAnimalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureActAnimalModelCopyWith<$Res> {
  factory $ProcedureActAnimalModelCopyWith(ProcedureActAnimalModel value,
          $Res Function(ProcedureActAnimalModel) then) =
      _$ProcedureActAnimalModelCopyWithImpl<$Res, ProcedureActAnimalModel>;
  @useResult
  $Res call(
      {String id,
      String actId,
      String? animalId,
      String? identificationNo,
      String? sex,
      String? ageGroup,
      String? color,
      double? skinMeasurementMm,
      double? resultMm,
      double? differenceMm,
      String? allergyResult,
      DateTime? vaccinationDate,
      String? notes});
}

/// @nodoc
class _$ProcedureActAnimalModelCopyWithImpl<$Res,
        $Val extends ProcedureActAnimalModel>
    implements $ProcedureActAnimalModelCopyWith<$Res> {
  _$ProcedureActAnimalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProcedureActAnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actId = null,
    Object? animalId = freezed,
    Object? identificationNo = freezed,
    Object? sex = freezed,
    Object? ageGroup = freezed,
    Object? color = freezed,
    Object? skinMeasurementMm = freezed,
    Object? resultMm = freezed,
    Object? differenceMm = freezed,
    Object? allergyResult = freezed,
    Object? vaccinationDate = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actId: null == actId
          ? _value.actId
          : actId // ignore: cast_nullable_to_non_nullable
              as String,
      animalId: freezed == animalId
          ? _value.animalId
          : animalId // ignore: cast_nullable_to_non_nullable
              as String?,
      identificationNo: freezed == identificationNo
          ? _value.identificationNo
          : identificationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      skinMeasurementMm: freezed == skinMeasurementMm
          ? _value.skinMeasurementMm
          : skinMeasurementMm // ignore: cast_nullable_to_non_nullable
              as double?,
      resultMm: freezed == resultMm
          ? _value.resultMm
          : resultMm // ignore: cast_nullable_to_non_nullable
              as double?,
      differenceMm: freezed == differenceMm
          ? _value.differenceMm
          : differenceMm // ignore: cast_nullable_to_non_nullable
              as double?,
      allergyResult: freezed == allergyResult
          ? _value.allergyResult
          : allergyResult // ignore: cast_nullable_to_non_nullable
              as String?,
      vaccinationDate: freezed == vaccinationDate
          ? _value.vaccinationDate
          : vaccinationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcedureActAnimalModelImplCopyWith<$Res>
    implements $ProcedureActAnimalModelCopyWith<$Res> {
  factory _$$ProcedureActAnimalModelImplCopyWith(
          _$ProcedureActAnimalModelImpl value,
          $Res Function(_$ProcedureActAnimalModelImpl) then) =
      __$$ProcedureActAnimalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String actId,
      String? animalId,
      String? identificationNo,
      String? sex,
      String? ageGroup,
      String? color,
      double? skinMeasurementMm,
      double? resultMm,
      double? differenceMm,
      String? allergyResult,
      DateTime? vaccinationDate,
      String? notes});
}

/// @nodoc
class __$$ProcedureActAnimalModelImplCopyWithImpl<$Res>
    extends _$ProcedureActAnimalModelCopyWithImpl<$Res,
        _$ProcedureActAnimalModelImpl>
    implements _$$ProcedureActAnimalModelImplCopyWith<$Res> {
  __$$ProcedureActAnimalModelImplCopyWithImpl(
      _$ProcedureActAnimalModelImpl _value,
      $Res Function(_$ProcedureActAnimalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProcedureActAnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actId = null,
    Object? animalId = freezed,
    Object? identificationNo = freezed,
    Object? sex = freezed,
    Object? ageGroup = freezed,
    Object? color = freezed,
    Object? skinMeasurementMm = freezed,
    Object? resultMm = freezed,
    Object? differenceMm = freezed,
    Object? allergyResult = freezed,
    Object? vaccinationDate = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$ProcedureActAnimalModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actId: null == actId
          ? _value.actId
          : actId // ignore: cast_nullable_to_non_nullable
              as String,
      animalId: freezed == animalId
          ? _value.animalId
          : animalId // ignore: cast_nullable_to_non_nullable
              as String?,
      identificationNo: freezed == identificationNo
          ? _value.identificationNo
          : identificationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      skinMeasurementMm: freezed == skinMeasurementMm
          ? _value.skinMeasurementMm
          : skinMeasurementMm // ignore: cast_nullable_to_non_nullable
              as double?,
      resultMm: freezed == resultMm
          ? _value.resultMm
          : resultMm // ignore: cast_nullable_to_non_nullable
              as double?,
      differenceMm: freezed == differenceMm
          ? _value.differenceMm
          : differenceMm // ignore: cast_nullable_to_non_nullable
              as double?,
      allergyResult: freezed == allergyResult
          ? _value.allergyResult
          : allergyResult // ignore: cast_nullable_to_non_nullable
              as String?,
      vaccinationDate: freezed == vaccinationDate
          ? _value.vaccinationDate
          : vaccinationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcedureActAnimalModelImpl implements _ProcedureActAnimalModel {
  const _$ProcedureActAnimalModelImpl(
      {required this.id,
      required this.actId,
      this.animalId,
      this.identificationNo,
      this.sex,
      this.ageGroup,
      this.color,
      this.skinMeasurementMm,
      this.resultMm,
      this.differenceMm,
      this.allergyResult,
      this.vaccinationDate,
      this.notes});

  factory _$ProcedureActAnimalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureActAnimalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String actId;
  @override
  final String? animalId;
  @override
  final String? identificationNo;
  @override
  final String? sex;
  @override
  final String? ageGroup;
// adult / young
  @override
  final String? color;
  @override
  final double? skinMeasurementMm;
// allergy test: initial measurement
  @override
  final double? resultMm;
// allergy test: result reading
  @override
  final double? differenceMm;
// computed: result - initial
  @override
  final String? allergyResult;
// negative / positive / doubtful
  @override
  final DateTime? vaccinationDate;
  @override
  final String? notes;

  @override
  String toString() {
    return 'ProcedureActAnimalModel(id: $id, actId: $actId, animalId: $animalId, identificationNo: $identificationNo, sex: $sex, ageGroup: $ageGroup, color: $color, skinMeasurementMm: $skinMeasurementMm, resultMm: $resultMm, differenceMm: $differenceMm, allergyResult: $allergyResult, vaccinationDate: $vaccinationDate, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureActAnimalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actId, actId) || other.actId == actId) &&
            (identical(other.animalId, animalId) ||
                other.animalId == animalId) &&
            (identical(other.identificationNo, identificationNo) ||
                other.identificationNo == identificationNo) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.skinMeasurementMm, skinMeasurementMm) ||
                other.skinMeasurementMm == skinMeasurementMm) &&
            (identical(other.resultMm, resultMm) ||
                other.resultMm == resultMm) &&
            (identical(other.differenceMm, differenceMm) ||
                other.differenceMm == differenceMm) &&
            (identical(other.allergyResult, allergyResult) ||
                other.allergyResult == allergyResult) &&
            (identical(other.vaccinationDate, vaccinationDate) ||
                other.vaccinationDate == vaccinationDate) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      actId,
      animalId,
      identificationNo,
      sex,
      ageGroup,
      color,
      skinMeasurementMm,
      resultMm,
      differenceMm,
      allergyResult,
      vaccinationDate,
      notes);

  /// Create a copy of ProcedureActAnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcedureActAnimalModelImplCopyWith<_$ProcedureActAnimalModelImpl>
      get copyWith => __$$ProcedureActAnimalModelImplCopyWithImpl<
          _$ProcedureActAnimalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcedureActAnimalModelImplToJson(
      this,
    );
  }
}

abstract class _ProcedureActAnimalModel implements ProcedureActAnimalModel {
  const factory _ProcedureActAnimalModel(
      {required final String id,
      required final String actId,
      final String? animalId,
      final String? identificationNo,
      final String? sex,
      final String? ageGroup,
      final String? color,
      final double? skinMeasurementMm,
      final double? resultMm,
      final double? differenceMm,
      final String? allergyResult,
      final DateTime? vaccinationDate,
      final String? notes}) = _$ProcedureActAnimalModelImpl;

  factory _ProcedureActAnimalModel.fromJson(Map<String, dynamic> json) =
      _$ProcedureActAnimalModelImpl.fromJson;

  @override
  String get id;
  @override
  String get actId;
  @override
  String? get animalId;
  @override
  String? get identificationNo;
  @override
  String? get sex;
  @override
  String? get ageGroup; // adult / young
  @override
  String? get color;
  @override
  double? get skinMeasurementMm; // allergy test: initial measurement
  @override
  double? get resultMm; // allergy test: result reading
  @override
  double? get differenceMm; // computed: result - initial
  @override
  String? get allergyResult; // negative / positive / doubtful
  @override
  DateTime? get vaccinationDate;
  @override
  String? get notes;

  /// Create a copy of ProcedureActAnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureActAnimalModelImplCopyWith<_$ProcedureActAnimalModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProcedureListResponse _$ProcedureListResponseFromJson(
    Map<String, dynamic> json) {
  return _ProcedureListResponse.fromJson(json);
}

/// @nodoc
mixin _$ProcedureListResponse {
  List<ProcedureActModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get pages => throw _privateConstructorUsedError;

  /// Serializes this ProcedureListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcedureListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcedureListResponseCopyWith<ProcedureListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureListResponseCopyWith<$Res> {
  factory $ProcedureListResponseCopyWith(ProcedureListResponse value,
          $Res Function(ProcedureListResponse) then) =
      _$ProcedureListResponseCopyWithImpl<$Res, ProcedureListResponse>;
  @useResult
  $Res call(
      {List<ProcedureActModel> items,
      int total,
      int page,
      int pageSize,
      int pages});
}

/// @nodoc
class _$ProcedureListResponseCopyWithImpl<$Res,
        $Val extends ProcedureListResponse>
    implements $ProcedureListResponseCopyWith<$Res> {
  _$ProcedureListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProcedureListResponse
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
              as List<ProcedureActModel>,
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
abstract class _$$ProcedureListResponseImplCopyWith<$Res>
    implements $ProcedureListResponseCopyWith<$Res> {
  factory _$$ProcedureListResponseImplCopyWith(
          _$ProcedureListResponseImpl value,
          $Res Function(_$ProcedureListResponseImpl) then) =
      __$$ProcedureListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProcedureActModel> items,
      int total,
      int page,
      int pageSize,
      int pages});
}

/// @nodoc
class __$$ProcedureListResponseImplCopyWithImpl<$Res>
    extends _$ProcedureListResponseCopyWithImpl<$Res,
        _$ProcedureListResponseImpl>
    implements _$$ProcedureListResponseImplCopyWith<$Res> {
  __$$ProcedureListResponseImplCopyWithImpl(_$ProcedureListResponseImpl _value,
      $Res Function(_$ProcedureListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProcedureListResponse
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
    return _then(_$ProcedureListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ProcedureActModel>,
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
class _$ProcedureListResponseImpl implements _ProcedureListResponse {
  const _$ProcedureListResponseImpl(
      {required final List<ProcedureActModel> items,
      required this.total,
      required this.page,
      required this.pageSize,
      required this.pages})
      : _items = items;

  factory _$ProcedureListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureListResponseImplFromJson(json);

  final List<ProcedureActModel> _items;
  @override
  List<ProcedureActModel> get items {
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
    return 'ProcedureListResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureListResponseImpl &&
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

  /// Create a copy of ProcedureListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcedureListResponseImplCopyWith<_$ProcedureListResponseImpl>
      get copyWith => __$$ProcedureListResponseImplCopyWithImpl<
          _$ProcedureListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcedureListResponseImplToJson(
      this,
    );
  }
}

abstract class _ProcedureListResponse implements ProcedureListResponse {
  const factory _ProcedureListResponse(
      {required final List<ProcedureActModel> items,
      required final int total,
      required final int page,
      required final int pageSize,
      required final int pages}) = _$ProcedureListResponseImpl;

  factory _ProcedureListResponse.fromJson(Map<String, dynamic> json) =
      _$ProcedureListResponseImpl.fromJson;

  @override
  List<ProcedureActModel> get items;
  @override
  int get total;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get pages;

  /// Create a copy of ProcedureListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureListResponseImplCopyWith<_$ProcedureListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

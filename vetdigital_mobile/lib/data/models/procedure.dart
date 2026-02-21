import 'package:freezed_annotation/freezed_annotation.dart';

part 'procedure.freezed.dart';
part 'procedure.g.dart';

/// Mirrors backend ProcedureAct model (Excel template fields)
@freezed
class ProcedureActModel with _$ProcedureActModel {
  const factory ProcedureActModel({
    required String id,
    required String actNumber,
    required DateTime actDate,
    required String procedureType,   // vaccination / allergy_test / deworming / treatment
    String? diseaseName,
    String? regionKato,
    String? regionName,
    String? settlement,
    required String specialistId,
    String? specialistName,
    String? participantsJson,        // JSON list of participant names
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
    String? materialsJson,           // JSON list of expendable materials
    String? status,                  // draft / pending_signature / signed / archived
    String? pdfUrl,
    DateTime? signedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<ProcedureActAnimalModel> animals,
    @Default(false) bool isSynced,
    String? localId,
  }) = _ProcedureActModel;

  factory ProcedureActModel.fromJson(Map<String, dynamic> json) =>
      _$ProcedureActModelFromJson(json);
}

/// Animal record within a procedure act
/// (from Excel template Без названия (5).xls)
@freezed
class ProcedureActAnimalModel with _$ProcedureActAnimalModel {
  const factory ProcedureActAnimalModel({
    required String id,
    required String actId,
    String? animalId,
    String? identificationNo,
    String? sex,
    String? ageGroup,                // adult / young
    String? color,
    double? skinMeasurementMm,       // allergy test: initial measurement
    double? resultMm,                // allergy test: result reading
    double? differenceMm,            // computed: result - initial
    String? allergyResult,           // negative / positive / doubtful
    DateTime? vaccinationDate,
    String? notes,
  }) = _ProcedureActAnimalModel;

  factory ProcedureActAnimalModel.fromJson(Map<String, dynamic> json) =>
      _$ProcedureActAnimalModelFromJson(json);
}

/// Paginated procedure acts response
@freezed
class ProcedureListResponse with _$ProcedureListResponse {
  const factory ProcedureListResponse({
    required List<ProcedureActModel> items,
    required int total,
    required int page,
    required int pageSize,
    required int pages,
  }) = _ProcedureListResponse;

  factory ProcedureListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcedureListResponseFromJson(json);
}

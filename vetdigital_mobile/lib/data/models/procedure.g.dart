// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcedureActModelImpl _$$ProcedureActModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcedureActModelImpl(
      id: json['id'] as String,
      actNumber: json['actNumber'] as String,
      actDate: DateTime.parse(json['actDate'] as String),
      procedureType: json['procedureType'] as String,
      diseaseName: json['diseaseName'] as String?,
      regionKato: json['regionKato'] as String?,
      regionName: json['regionName'] as String?,
      settlement: json['settlement'] as String?,
      specialistId: json['specialistId'] as String,
      specialistName: json['specialistName'] as String?,
      participantsJson: json['participantsJson'] as String?,
      ownerIin: json['ownerIin'] as String?,
      ownerName: json['ownerName'] as String?,
      speciesId: json['speciesId'] as String?,
      speciesName: json['speciesName'] as String?,
      maleCount: (json['maleCount'] as num?)?.toInt(),
      femaleCount: (json['femaleCount'] as num?)?.toInt(),
      youngCount: (json['youngCount'] as num?)?.toInt(),
      totalVaccinated: (json['totalVaccinated'] as num?)?.toInt(),
      vaccineName: json['vaccineName'] as String?,
      allergenName: json['allergenName'] as String?,
      manufacturer: json['manufacturer'] as String?,
      productionDate: json['productionDate'] == null
          ? null
          : DateTime.parse(json['productionDate'] as String),
      series: json['series'] as String?,
      stateControlNo: json['stateControlNo'] as String?,
      injectionMethod: json['injectionMethod'] as String?,
      doseAdultMl: (json['doseAdultMl'] as num?)?.toDouble(),
      doseYoungMl: (json['doseYoungMl'] as num?)?.toDouble(),
      allergenReadingHours: (json['allergenReadingHours'] as num?)?.toInt(),
      materialsJson: json['materialsJson'] as String?,
      status: json['status'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      signedAt: json['signedAt'] == null
          ? null
          : DateTime.parse(json['signedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      animals: (json['animals'] as List<dynamic>?)
              ?.map((e) =>
                  ProcedureActAnimalModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isSynced: json['isSynced'] as bool? ?? false,
      localId: json['localId'] as String?,
    );

Map<String, dynamic> _$$ProcedureActModelImplToJson(
        _$ProcedureActModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actNumber': instance.actNumber,
      'actDate': instance.actDate.toIso8601String(),
      'procedureType': instance.procedureType,
      'diseaseName': instance.diseaseName,
      'regionKato': instance.regionKato,
      'regionName': instance.regionName,
      'settlement': instance.settlement,
      'specialistId': instance.specialistId,
      'specialistName': instance.specialistName,
      'participantsJson': instance.participantsJson,
      'ownerIin': instance.ownerIin,
      'ownerName': instance.ownerName,
      'speciesId': instance.speciesId,
      'speciesName': instance.speciesName,
      'maleCount': instance.maleCount,
      'femaleCount': instance.femaleCount,
      'youngCount': instance.youngCount,
      'totalVaccinated': instance.totalVaccinated,
      'vaccineName': instance.vaccineName,
      'allergenName': instance.allergenName,
      'manufacturer': instance.manufacturer,
      'productionDate': instance.productionDate?.toIso8601String(),
      'series': instance.series,
      'stateControlNo': instance.stateControlNo,
      'injectionMethod': instance.injectionMethod,
      'doseAdultMl': instance.doseAdultMl,
      'doseYoungMl': instance.doseYoungMl,
      'allergenReadingHours': instance.allergenReadingHours,
      'materialsJson': instance.materialsJson,
      'status': instance.status,
      'pdfUrl': instance.pdfUrl,
      'signedAt': instance.signedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'animals': instance.animals,
      'isSynced': instance.isSynced,
      'localId': instance.localId,
    };

_$ProcedureActAnimalModelImpl _$$ProcedureActAnimalModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcedureActAnimalModelImpl(
      id: json['id'] as String,
      actId: json['actId'] as String,
      animalId: json['animalId'] as String?,
      identificationNo: json['identificationNo'] as String?,
      sex: json['sex'] as String?,
      ageGroup: json['ageGroup'] as String?,
      color: json['color'] as String?,
      skinMeasurementMm: (json['skinMeasurementMm'] as num?)?.toDouble(),
      resultMm: (json['resultMm'] as num?)?.toDouble(),
      differenceMm: (json['differenceMm'] as num?)?.toDouble(),
      allergyResult: json['allergyResult'] as String?,
      vaccinationDate: json['vaccinationDate'] == null
          ? null
          : DateTime.parse(json['vaccinationDate'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ProcedureActAnimalModelImplToJson(
        _$ProcedureActAnimalModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actId': instance.actId,
      'animalId': instance.animalId,
      'identificationNo': instance.identificationNo,
      'sex': instance.sex,
      'ageGroup': instance.ageGroup,
      'color': instance.color,
      'skinMeasurementMm': instance.skinMeasurementMm,
      'resultMm': instance.resultMm,
      'differenceMm': instance.differenceMm,
      'allergyResult': instance.allergyResult,
      'vaccinationDate': instance.vaccinationDate?.toIso8601String(),
      'notes': instance.notes,
    };

_$ProcedureListResponseImpl _$$ProcedureListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcedureListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProcedureActModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$$ProcedureListResponseImplToJson(
        _$ProcedureListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
    };

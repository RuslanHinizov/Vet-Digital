import 'package:dio/dio.dart';
import '../../models/procedure.dart';
import '../../../core/config/api_endpoints.dart';

class ProcedureRemoteDataSource {
  final Dio _dio;

  ProcedureRemoteDataSource(this._dio);

  /// GET /api/v1/procedures
  Future<ProcedureListResponse> getProcedures({
    int page = 1,
    int pageSize = 20,
    String? status,
    String? procedureType,
    String? species,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.procedures,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (status != null) 'status': status,
        if (procedureType != null) 'procedure_type': procedureType,
        if (species != null) 'species': species,
        if (dateFrom != null) 'date_from': dateFrom.toIso8601String(),
        if (dateTo != null) 'date_to': dateTo.toIso8601String(),
      },
    );
    return ProcedureListResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/procedures/{id}
  Future<ProcedureActModel> getProcedureById(String id) async {
    final response = await _dio.get(ApiEndpoints.procedureById(id));
    return ProcedureActModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/procedures
  Future<ProcedureActModel> createProcedure(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.procedures, data: data);
    return ProcedureActModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// PUT /api/v1/procedures/{id}
  Future<ProcedureActModel> updateProcedure(
      String id, Map<String, dynamic> data) async {
    final response =
        await _dio.put(ApiEndpoints.procedureById(id), data: data);
    return ProcedureActModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/procedures/{id}/sign — initiate EDS signing (legacy)
  Future<Map<String, dynamic>> requestSign(String id) async {
    final response =
        await _dio.post('${ApiEndpoints.procedureById(id)}/sign');
    return response.data as Map<String, dynamic>;
  }

  /// POST /api/v1/documents/{id}/sign/initiate — initiate eGov Mobile QR signing
  Future<Map<String, dynamic>> initiateSign(String id) async {
    final response = await _dio.post(
      '/api/v1/documents/$id/sign/initiate',
      queryParameters: {'doc_type': 'procedure_act'},
    );
    return response.data as Map<String, dynamic>;
  }

  /// POST /api/v1/documents/{id}/sign/complete — complete EDS signing
  Future<Map<String, dynamic>> completeSign(
      String id, String challengeToken, String signatureData) async {
    final response = await _dio.post(
      '/api/v1/documents/$id/sign/complete',
      data: {
        'challenge_token': challengeToken,
        'signature_data': signatureData,
      },
      queryParameters: {'doc_type': 'procedure_act'},
    );
    return response.data as Map<String, dynamic>;
  }

  /// GET /api/v1/procedures/{id}/pdf — download PDF URL
  Future<String> getPdfUrl(String id) async {
    final response =
        await _dio.get('${ApiEndpoints.procedureById(id)}/pdf');
    return (response.data as Map<String, dynamic>)['url'] as String;
  }
}

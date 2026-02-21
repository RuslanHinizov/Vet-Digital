import 'package:dio/dio.dart';
import '../../models/animal.dart';
import '../../../core/config/api_endpoints.dart';

/// Remote data source for animal API calls.
/// All methods throw DioException on network errors.
class AnimalRemoteDataSource {
  final Dio _dio;

  AnimalRemoteDataSource(this._dio);

  /// GET /api/v1/animals — paginated, with optional filters
  Future<AnimalListResponse> getAnimals({
    int page = 1,
    int pageSize = 20,
    String? species,
    String? status,
    String? ownerIin,
    String? search,
    String? regionKato,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.animals,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (species != null) 'species': species,
        if (status != null) 'status': status,
        if (ownerIin != null) 'owner_iin': ownerIin,
        if (search != null) 'search': search,
        if (regionKato != null) 'region_kato': regionKato,
      },
    );
    return AnimalListResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/animals/{id}
  Future<AnimalModel> getAnimalById(String id) async {
    final response = await _dio.get(ApiEndpoints.animalById(id));
    return AnimalModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/animals
  Future<AnimalModel> createAnimal(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.animals, data: data);
    return AnimalModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// PUT /api/v1/animals/{id}
  Future<AnimalModel> updateAnimal(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(ApiEndpoints.animalById(id), data: data);
    return AnimalModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// DELETE /api/v1/animals/{id} (soft delete)
  Future<void> deleteAnimal(String id) async {
    await _dio.delete(ApiEndpoints.animalById(id));
  }

  /// GET /api/v1/animals/{id}/location — latest GPS position
  Future<Map<String, dynamic>> getAnimalLocation(String id) async {
    final response = await _dio.get('${ApiEndpoints.animalById(id)}/location');
    return response.data as Map<String, dynamic>;
  }

  /// GET /api/v1/animals/{id}/track — GPS history
  Future<List<GpsReading>> getAnimalTrack(
    String id, {
    DateTime? from,
    DateTime? to,
    int limit = 500,
  }) async {
    final response = await _dio.get(
      '${ApiEndpoints.animalById(id)}/track',
      queryParameters: {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        'limit': limit,
      },
    );
    final data = response.data as Map<String, dynamic>;
    final readings = data['readings'] as List<dynamic>;
    return readings
        .map((r) => GpsReading.fromJson(r as Map<String, dynamic>))
        .toList();
  }

  /// POST /api/v1/animals/rfid-lookup — look up animal by RFID tag
  Future<AnimalModel?> lookupByRfid(String rfidTagNo) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.animals}/rfid-lookup',
        data: {'rfid_tag_no': rfidTagNo},
      );
      return AnimalModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'api_client.dart';

class MaterialService {
  final Dio _dio = ApiClient.dio;

  Future<List<Map<String, dynamic>>> listarMateriales({String? q, int? idEmpresa}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (q != null && q.trim().isNotEmpty) queryParams['q'] = q.trim();
      if (idEmpresa != null) queryParams['id_empresa'] = idEmpresa;

      final response = await _dio.get(
        '/api/materiales',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final data = response.data;
      if (data == null || data['success'] != true) {
        return [];
      }

      final list = data['data'] as List<dynamic>?;
      return list?.map((e) => Map<String, dynamic>.from(e as Map)).toList() ?? [];
    } catch (_) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> listarCategorias() async {
    try {
      final response = await _dio.get('/api/materiales/categorias');
      final data = response.data;
      if (data == null || data['success'] != true) return [];
      final list = data['data'] as List<dynamic>?;
      return list?.map((e) => Map<String, dynamic>.from(e as Map)).toList() ?? [];
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> obtenerMaterial(int idMaterial) async {
    try {
      final response = await _dio.get('/api/materiales/$idMaterial');
      final data = response.data;
      if (data != null && data['success'] == true && data['data'] != null) {
        return Map<String, dynamic>.from(data['data'] as Map);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> modificarMaterial(int idMaterial, Map<String, dynamic> datos) async {
    try {
      final response = await _dio.put('/api/materiales/$idMaterial', data: datos);
      return response.data?['success'] == true;
    } catch (_) {
      return false;
    }
  }
}

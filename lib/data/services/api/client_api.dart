import 'package:dio/dio.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';

class ClientApi {
  final _dio = Dio();
  // Localhost 4 emulators
  final host = "http://10.0.2.2:8080/api/v1";

  Future<List<WarningEntity>> getWarnings() async {
    try {
      final response = await _dio.get('$host/warnings');

      final listData = response.data as List;

      final warnings = listData
          .map((json) => WarningEntity.fromJson(json))
          .toList();

      return warnings;
    } on DioException catch (e) {
      throw Exception('Falha ao conectar no servidor: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao processar os dados: $e');
    }
  }
}

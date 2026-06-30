import 'package:dio/dio.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';

class ClientApi {
  final _dio = Dio();
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
      // O DIO EXCEPTION PEGA ERROS DE REDE
      // Coloque um breakpoint na linha do print abaixo!
      // Se a URL estiver errada ou o Spring Boot desligado, ele vai parar aqui.
      print('=== ERRO DE REDE ===');
      print('Mensagem: ${e.message}');
      print('Status: ${e.response?.statusCode}');

      // Relança o erro para o WarningRepository capturar lá no Result.Failure
      throw Exception('Falha ao conectar no servidor: ${e.message}');
    } catch (e) {
      // O CATCH GENÉRICO PEGA ERROS DE CÓDIGO (como um JSON mal formatado)
      // Coloque um breakpoint aqui também!
      print('=== ERRO DE CÓDIGO/JSON ===');
      print('Detalhe: $e');
      throw Exception('Erro ao processar os dados: $e');
    }
  }
}

import 'package:firebase_notify_app/data/services/api/client_api.dart';
import 'package:firebase_notify_app/data/services/local/local_data.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';
import 'package:result_dart/result_dart.dart';

class WarningRepository {
  WarningRepository(this._service);

  //final LocalData _service;
  final ClientApi _service;

  Future<Result<List<WarningEntity>>> getWarnings() async {
    try {
      final alerts = await _service.getWarnings();
      return Success(alerts);
    } on Exception catch (error) {
      return Failure(error);
    }
  }
}

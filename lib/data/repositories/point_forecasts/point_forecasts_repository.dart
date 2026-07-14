import 'package:firebase_notify_app/data/services/firestore/firestore_data.dart';
import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';

class PointForecastsRepository {
  PointForecastsRepository(this._service);

  final FirestoreData _service;

  Stream<List<PointForecastsData>> subPoints() {
    return _service.getPointsStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        final payload = doc.data();
        return PointForecastsData.fromJson(payload);
      }).toList();
    });
  }
}

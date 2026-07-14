import 'package:firebase_notify_app/domain/models/forecast.dart';
import 'package:firebase_notify_app/domain/models/history_data.dart';
import 'package:latlong2/latlong.dart';

class PointForecastsData {
  final String pointId;
  final LatLng coordinates;
  final HistoryData historyData;
  final List<Forecast> forecasts;

  PointForecastsData({
    required this.pointId,
    required this.coordinates,
    required this.historyData,
    required this.forecasts,
  });

  factory PointForecastsData.fromJson(Map<String, dynamic> json) {
    return PointForecastsData(
      pointId: json['pointId'],
      coordinates: LatLng(json['latitude'], json['longitude']),
      historyData: HistoryData.fromJson(json['historyData']),
      forecasts:
          (json['forecasts'] as List?)
              ?.map((item) => Forecast.fromJson(item))
              .toList() ??
          [],
    );
  }

  PointForecastsData copyWith({
    String? pointId,
    LatLng? coordinates,
    HistoryData? historyData,
    List<Forecast>? forecasts,
  }) {
    return PointForecastsData(
      pointId: pointId ?? this.pointId,
      coordinates: coordinates ?? this.coordinates,
      historyData: historyData ?? this.historyData,
      forecasts: forecasts ?? this.forecasts,
    );
  }
}

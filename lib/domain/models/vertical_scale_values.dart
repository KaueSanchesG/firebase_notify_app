import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';

class VerticalScaleValues {
  final double avgValue;
  final double rtValue;
  final double maxValue;
  final double minValue;

  const VerticalScaleValues({
    this.maxValue = 0.0,
    this.minValue = 0.0,
    this.avgValue = 0.25,
    this.rtValue = 0.0,
  });

  factory VerticalScaleValues.fromPoint(PointForecastsData point) {
    return VerticalScaleValues(
      maxValue: point.historyData.max,
      minValue: point.historyData.min,
      avgValue: point.historyData.avg,
      rtValue: point.forecasts[0].riverDischarge,
    );
  }
}

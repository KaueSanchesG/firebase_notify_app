import 'package:firebase_notify_app/domain/models/vertical_scale_values.dart';
import 'package:firebase_notify_app/utils/math_formulas.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VerticalScale extends StatelessWidget {
  final VerticalScaleValues pointValues;

  const VerticalScale({
    super.key,
    this.pointValues = const VerticalScaleValues(),
  });

  static final _minColor = Color.fromRGBO(33, 149, 243, 1);
  static final _avgColor = Color.fromRGBO(76, 175, 80, 1);
  static final _warningColor = Color.fromARGB(255, 255, 153, 1);
  static final _maxColor = Color.fromRGBO(244, 67, 54, 1);

  @override
  Widget build(BuildContext context) {
    double avgValue = 25.0;
    double rtValue = 0.0;

    if (pointValues.maxValue != 0.0) {
      avgValue = MathFormulas.scaleValueOf(
        pointValues.maxValue,
        pointValues.minValue,
        pointValues.avgValue,
      );
      rtValue = MathFormulas.scaleValueOf(
        pointValues.maxValue,
        pointValues.minValue,
        pointValues.rtValue,
      );
    }

    final double avgValueClampped = avgValue.clamp(0.0, 1.0);

    final double warningValue = avgValue * 3;

    var sfLinearGauge = SfLinearGauge(
      orientation: LinearGaugeOrientation.vertical,
      minimum: 0.0,
      maximum: 1.0,
      showTicks: false,
      axisTrackStyle: const LinearAxisTrackStyle(thickness: 15),
      labelFormatterCallback: (String label) {
        final double? labelValue = double.tryParse(label);
        if (labelValue == null) return '';

        bool isCloseTo(double target) => (labelValue - target).abs() < 0.05;

        if (isCloseTo(0.0)) {
          return pointValues.minValue.toStringAsFixed(1);
        }

        if (isCloseTo(1.0)) {
          return pointValues.maxValue.toStringAsFixed(1);
        }

        if (isCloseTo(avgValueClampped)) {
          return pointValues.avgValue.toStringAsFixed(1);
        }

        if (isCloseTo(warningValue)) {
          return (pointValues.avgValue * 3).toStringAsFixed(1);
        }

        return '';
      },
      ranges: [
        LinearGaugeRange(
          startValue: 0.0,
          endValue: 1.0,
          startWidth: 15,
          endWidth: 15,
          edgeStyle: LinearEdgeStyle.bothFlat,
          position: LinearElementPosition.cross,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [_minColor, _avgColor, _warningColor, _maxColor],
              stops: [0.0, avgValueClampped, warningValue, 1.0],
            ).createShader(bounds);
          },
        ),
      ],
      markerPointers: plotPointersWhenNotDefault(rtValue, pointValues.rtValue),
    );
    return sfLinearGauge;
  }

  List<LinearWidgetPointer>? plotPointersWhenNotDefault(
    double rtValue,
    double pRtValue,
  ) {
    if (rtValue != -1.0) {
      return [
        LinearWidgetPointer(
          value: rtValue,
          position: LinearElementPosition.cross,
          child: Container(
            height: 2,
            width: 15,
            color: Colors.blueGrey.shade900,
          ),
        ),
        LinearWidgetPointer(
          value: rtValue,
          position: LinearElementPosition.inside,
          offset: 12.0,
          child: Text(
            "$pRtValue m³/s",
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ];
    }
    return null;
  }

  static Color getColor(double avgValue, double curtValue) {
    double curtClampped = curtValue.clamp(0.0, 100.0);
    double avgClampped = avgValue.clamp(0.0, 100.0);
    double warningValue = avgClampped * 3;

    double result = 0.0;

    if (avgClampped == 0.0) {
      return Color.lerp(_avgColor, _maxColor, curtClampped / 100) ?? _avgColor;
    }
    if (avgClampped == 100.0) {
      return Color.lerp(_minColor, _avgColor, curtClampped / 100) ?? _minColor;
    }

    if (curtClampped <= avgClampped) {
      result = curtClampped / avgClampped;
      return Color.lerp(_minColor, _avgColor, result) ?? _minColor;
    } else if (curtClampped <= warningValue) {
      result = (curtClampped - avgClampped) / (warningValue - avgClampped);
      return Color.lerp(_avgColor, _warningColor, result) ?? _avgColor;
    } else {
      result = (curtClampped - warningValue) / (100.0 - avgClampped);
      return Color.lerp(_warningColor, _maxColor, result) ?? _warningColor;
    }
  }
}

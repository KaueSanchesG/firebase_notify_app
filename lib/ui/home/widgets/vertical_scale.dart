import 'package:flutter/material.dart';

class VerticalScale {
  static Color getColor(double avgValue, double curtValue) {
    double curtClampped = curtValue.clamp(0.0, 100.0);
    double avgClampped = avgValue.clamp(0.0, 100.0);

    const minColor = Color.fromRGBO(33, 149, 243, 0.5);
    const avgColor = Color.fromRGBO(76, 175, 80, 0.5);
    const maxColor = Color.fromRGBO(244, 67, 54, 0.5);

    if (avgClampped == 0.0) {
      return Color.lerp(avgColor, maxColor, curtClampped / 100) ?? avgColor;
    }
    if (avgClampped == 100.0) {
      return Color.lerp(minColor, avgColor, curtClampped / 100) ?? minColor;
    }

    if (curtClampped <= avgClampped) {
      double result = curtClampped / avgClampped;
      return Color.lerp(minColor, avgColor, result) ?? minColor;
    } else {
      double result = (curtClampped - avgClampped) / (100.0 - avgClampped);
      return Color.lerp(avgColor, maxColor, result) ?? avgColor;
    }
  }
}

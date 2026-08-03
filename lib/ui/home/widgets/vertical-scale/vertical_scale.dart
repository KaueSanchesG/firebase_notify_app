import 'package:firebase_notify_app/domain/models/vertical_scale_values.dart';
import 'package:flutter/material.dart';

class VerticalScale extends StatelessWidget {
  final double avgValue;
  final double rtValue;

  //final VerticalScaleValues pointValues;

  // adicionar parametro opc de pointValues aqui, transformat os valores com MathFormular.scaleOf() e passar os parâmetros aos metodos
  const VerticalScale({super.key, this.avgValue = 0.25, this.rtValue = 0.0});

  static final _minColor = Color.fromRGBO(33, 149, 243, 1);
  static final _avgColor = Color.fromRGBO(76, 175, 80, 1);
  static final _warningColor = Color.fromARGB(255, 255, 153, 1);
  static final _maxColor = Color.fromRGBO(244, 67, 54, 1);

  @override
  Widget build(BuildContext context) {
    final double avgValueClampped = avgValue.clamp(0.0, 1.0);

    final double warningValue = avgValueClampped * 3;

    return Container(
      width: 40,
      height: 350,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [_minColor, _avgColor, _warningColor, _maxColor],
          stops: [0.0, avgValueClampped, warningValue, 1.0],
        ),
      ),
      child: Align(
        alignment: Alignment(0.0, (1.0 - (rtValue * 2))),
        child: Divider(
          height: 2,
          thickness: 2,
          color: Colors.blueGrey.shade600,
        ),
      ),
    );
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
      result = (curtClampped - avgClampped) / (100.0 - avgClampped);
      return Color.lerp(_warningColor, _maxColor, result) ?? _warningColor;
    }
  }
}

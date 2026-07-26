import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';
import 'package:firebase_notify_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomPanel extends StatelessWidget {
  final PointForecastsData _point;
  final VoidCallback onClose;

  const BottomPanel({super.key, required point, required this.onClose})
    : _point = point;

  @override
  Widget build(BuildContext context) {
    const divisor = Divider(color: Colors.white54, thickness: 1);

    return Positioned(
      bottom: 10,
      right: 5,
      left: 5,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Informações sobre o ponto ${_point.pointId}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => onClose(),
                    icon: Icon(Icons.close_sharp, color: Colors.white),
                    iconSize: 30,
                  ),
                ],
              ),
              divisor,
              _textSet(
                "Ponto:",
                "${_point.coordinates.latitude}, ${_point.coordinates.longitude}",
              ),
              _textSet(
                "Consenso dos modelos:",
                "${_point.forecasts[0].trustability}%",
              ),
              _textSet(
                "Descarga atual:",
                "${_point.forecasts[0].riverDischarge} m³/s",
              ),
              _textSet(
                "Maior descarga histórica:",
                "${_point.historyData.max} m³/s",
              ),
              _textSet(
                "Menor descarga histórica:",
                "${_point.historyData.min} m³/s",
              ),
              _textSet("Descarga padrão:", "${_point.historyData.avg} m³/s"),
              divisor,
              Padding(
                padding: EdgeInsetsGeometry.directional(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Previsão para o dia: ${DateFormatter.format(_point.forecasts[0].date)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textSet(String label, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        Text(data),
      ],
    );
  }
}

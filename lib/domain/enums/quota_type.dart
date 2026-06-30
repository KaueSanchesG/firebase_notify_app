import 'package:flutter/material.dart';

enum QuotaType {
  minor('MINOR', 'Alerta', Colors.green),
  moderate('MODERATE', 'Enchente', Colors.orange),
  major('MAJOR', 'Inundação', Colors.red);

  final String key;
  final String label;
  final Color color;

  const QuotaType(this.key, this.label, this.color);

  static QuotaType fromJson(String value) {
    return QuotaType.values.firstWhere((e) => e.key == value);
  }
}

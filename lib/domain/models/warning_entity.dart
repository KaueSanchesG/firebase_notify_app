import 'package:firebase_notify_app/domain/enums/quota_type.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class WarningEntity {
  final int id;
  final String message;
  final DateTime timestamp;
  final QuotaType quota;
  final LatLng point;

  const WarningEntity({
    required this.id,
    required this.message,
    required this.quota,
    required this.timestamp,
    required this.point,
  });

  String get formattedTimestamp {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return formatter.format(timestamp);
  }

  factory WarningEntity.fromJson(Map<String, dynamic> json) {
    return WarningEntity(
      id: json['id'],
      message: json['message'],
      quota: QuotaType.fromJson(json['quota']),
      timestamp: DateTime.parse(json['timestamp']),
      point: LatLng(json['latitude'] as double, json['longitude'] as double),
    );
  }
}

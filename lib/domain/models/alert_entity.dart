import 'package:firebase_notify_app/domain/enums/quota_type.dart';
import 'package:intl/intl.dart';

class AlertEntity {
  final int id;
  final String message;
  final DateTime timestamp;
  final QuotaType quota;

  AlertEntity({
    required this.id,
    required this.message,
    required this.quota,
    required this.timestamp,
  });

  String get formattedTimestamp {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return formatter.format(timestamp);
  }
}

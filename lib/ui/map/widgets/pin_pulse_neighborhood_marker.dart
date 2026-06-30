import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_notify_app/domain/enums/quota_type.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';
import 'package:flutter/material.dart';

class PinPulseNeighborhoodMarker extends StatelessWidget {
  const PinPulseNeighborhoodMarker({super.key, required this.warningEntity});
  final WarningEntity warningEntity;

  Color get _pinColor {
    switch (warningEntity.quota) {
      case QuotaType.major:
        return Colors.red;
      case QuotaType.moderate:
        return Colors.orange;
      case QuotaType.minor:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: _pinColor,
      duration: const Duration(milliseconds: 2000),
      child: Material(
        color: _pinColor,
        elevation: 5.0,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(backgroundColor: _pinColor, radius: 12.0),
        ),
      ),
    );
  }
}

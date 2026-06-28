import 'package:firebase_notify_app/data/repositories/warning/warning_repository.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command_pattern/flutter_command_pattern.dart';

class WarningViewmodel extends ChangeNotifier {
  final WarningRepository _repository;

  late final Command loadWarnings;
  List<WarningEntity> warnings = [];

  WarningViewmodel(this._repository) {
    loadWarnings = Command(() async {
      final result = await _repository.getWarnings();

      result.fold(
        (success) {
          warnings = success;
        },
        (failure) {
          throw failure;
        },
      );
      notifyListeners();
    });
  }
}

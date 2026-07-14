import 'dart:async';

import 'package:firebase_notify_app/data/repositories/point_forecasts/point_forecasts_repository.dart';
import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final PointForecastsRepository _repository;
  StreamSubscription? _subscription;

  List<PointForecastsData> _pointsCached = [];

  DateTime _selectedDate = DateTime.now();

  bool isLoading = true;

  HomeViewModel(this._repository) {
    _subListener();
  }

  DateTime get selectedDate => _selectedDate;

  List<PointForecastsData> get currentPoints {
    return _pointsCached.map((point) {
      return point.copyWith(
        forecasts: point.forecasts
            .where((f) => f.date == _selectedDate)
            .toList(),
      );
    }).toList();
  }

  void _subListener() {
    _subscription = _repository.subPoints().listen((receivedData) {
      _pointsCached = receivedData;
      isLoading = false;

      notifyListeners();
    });
  }

  void changeDate(DateTime date) {
    if (_selectedDate != date) {
      _selectedDate = date;

      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

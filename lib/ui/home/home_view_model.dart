import 'dart:async';

import 'package:firebase_notify_app/data/repositories/point_forecasts/point_forecasts_repository.dart';
import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';
import 'package:firebase_notify_app/domain/models/vertical_scale_values.dart';
import 'package:firebase_notify_app/ui/home/widgets/vertical-scale/vertical_scale.dart';
import 'package:firebase_notify_app/utils/math_formulas.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final PointForecastsRepository _repository;
  StreamSubscription? _subscription;

  List<PointForecastsData> _pointsCached = [];
  PointForecastsData? clickedPoint;

  DateTime _selectedDate = DateTime.now();

  bool isLoading = true;

  HomeViewModel(this._repository) {
    _subListener();
  }

  DateTime get selectedDate => _selectedDate;

  List<PointForecastsData> get currentPoints {
    return _pointsCached.map((point) {
      return point.copyWith(
        forecasts: point.forecasts.where((f) {
          return f.date.year == _selectedDate.year &&
              f.date.month == _selectedDate.month &&
              f.date.day == _selectedDate.day;
        }).toList(),
      );
    }).toList();
  }

  Color getColor(PointForecastsData point) {
    return VerticalScale.getColor(
      MathFormulas.scaleValueOf(
        point.historyData.max,
        point.historyData.min,
        point.historyData.avg,
      ),
      MathFormulas.scaleValueOf(
        point.historyData.max,
        point.historyData.min,
        point.forecasts
            .firstWhere(
              (forecast) => forecast.date == _selectedDate,
              orElse: () => point.forecasts.last,
            )
            .riverDischarge,
      ),
    );
  }

  Widget getVerticalScale({PointForecastsData? point}) {
    VerticalScaleValues pointValues = VerticalScaleValues();

    if (point != null) {
      pointValues = point.toScaleValues(_selectedDate);
    }

    return Positioned(
      top: 60,
      left: 10,
      child: VerticalScale(pointValues: pointValues),
    );
  }

  void _subListener() {
    _subscription = _repository.subPoints().listen(
      (receivedData) {
        _pointsCached = receivedData;
        isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      currentDate: _selectedDate,
      lastDate: DateTime.now().add(Duration(days: 90)),
    );

    if (picked != null) {
      _selectedDate = picked;
      clickedPoint = null;

      notifyListeners();
    }
  }

  void closeBottomPanel() {
    clickedPoint = null;

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

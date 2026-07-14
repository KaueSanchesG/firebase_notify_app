import 'package:firebase_notify_app/data/repositories/point_forecasts/point_forecasts_repository.dart';
import 'package:firebase_notify_app/data/services/firestore/firestore_data.dart';
import 'package:firebase_notify_app/ui/home/home_view_model.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  getIt.registerLazySingleton<FirestoreData>(() => FirestoreData());

  getIt.registerLazySingleton<PointForecastsRepository>(
    () => PointForecastsRepository(getIt<FirestoreData>()),
  );

  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(getIt<PointForecastsRepository>()),
  );
}

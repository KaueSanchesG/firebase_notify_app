import 'package:firebase_notify_app/data/repositories/warning/warning_repository.dart';
import 'package:firebase_notify_app/data/services/local/local_data.dart';
import 'package:firebase_notify_app/ui/warning/warning_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  getIt.registerSingleton<LocalData>(LocalData());

  getIt.registerSingleton<WarningRepository>(
    WarningRepository(getIt<LocalData>()),
  );

  getIt.registerSingleton<WarningViewmodel>(
    WarningViewmodel(getIt<WarningRepository>()),
  );
}

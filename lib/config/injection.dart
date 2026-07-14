import 'package:firebase_notify_app/data/services/firestore/firestore_data.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  getIt.registerSingleton<FirestoreData>(FirestoreData());
}

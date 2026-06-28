import 'package:firebase_notify_app/config/injection.dart';
import 'package:firebase_notify_app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency Injection
  setupLocator();
  await GetIt.I.allReady();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MonI', home: Home());
  }
}

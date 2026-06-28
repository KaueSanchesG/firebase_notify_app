import 'package:firebase_notify_app/ui/configuration/configuration_page.dart';
import 'package:firebase_notify_app/ui/warning/warning_page.dart';
import 'package:firebase_notify_app/ui/map/map_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.warning_amber), text: 'Alertas'),
            Tab(icon: Icon(Icons.map_outlined), text: 'Mapa'),
            Tab(icon: Icon(Icons.settings), text: 'Configurações'),
          ],
        ),
        body: TabBarView(
          children: [Warning(), const Map(), const Configuration()],
        ),
      ),
    );
  }
}

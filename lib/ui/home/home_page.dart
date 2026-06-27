import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade400,
          title: const Text('Monitoramento de enchentes'),
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.warning_amber)),
            Tab(icon: Icon(Icons.map_outlined)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
        body: const TabBarView(
          children: [
            Placeholder(),
            Text('Mapa em construção'),
            Text('Configuração em construção'),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_notify_app/config/injection.dart';
import 'package:firebase_notify_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final vm = getIt<HomeViewModel>();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OraKlast')),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, child) {
          if (widget.vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.vm.currentPoints.isEmpty) {
            return const Text('Algo deu errado');
          }

          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              cameraConstraint: const CameraConstraint.containLatitude(),
              initialCenter: LatLng(-25.50014516958931, -54.57859013732984),
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'firebase_notify_app',
              ),
              CircleLayer(
                circles: widget.vm.currentPoints.map((point) {
                  return CircleMarker(
                    key: ValueKey(point.pointId),
                    point: point.coordinates,
                    useRadiusInMeter: true,
                    radius: 2500,
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

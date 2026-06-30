import 'package:firebase_notify_app/config/injection.dart';
import 'package:firebase_notify_app/ui/map/map_viewmodel.dart';
import 'package:firebase_notify_app/ui/map/widgets/pin_pulse_neighborhood_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  final vm = getIt<MapViewmodel>();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    widget.vm.loadWarnings.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text('Mapa de inundações'),
      ),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: ((context, child) {
          if (widget.vm.loadWarnings.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.vm.loadWarnings.hasError) {
            return Center(child: Text('Algo deu errado'));
          }

          if (widget.vm.warnings.isEmpty) {
            return const Center(
              child: Text('Sucesso, mas não há nenhum alerta!'),
            );
          }

          return FlutterMap(
            mapController: MapController(),
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
              MarkerLayer(
                markers: widget.vm.warnings.map((warning) {
                  return Marker(
                    key: ValueKey(warning.id),
                    point: warning.point,
                    width: 20,
                    height: 20,
                    child: PinPulseNeighborhoodMarker(warningEntity: warning),
                  );
                }).toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

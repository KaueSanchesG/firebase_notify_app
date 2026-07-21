import 'package:firebase_notify_app/config/injection.dart';
import 'package:firebase_notify_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        title: Text(
          'OraKlast',
          style: GoogleFonts.inknutAntiqua(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          ListenableBuilder(
            listenable: widget.vm,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: TextButton.icon(
                  onPressed: () => widget.vm.selectDate(context),
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    DateFormat('dd/MM/yyyy').format(widget.vm.selectedDate),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
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
              initialCenter: LatLng(-25.50014516958931, -54.57859013732984),
              initialZoom: 12.0,
              cameraConstraint: CameraConstraint.contain(
                bounds: LatLngBounds(
                  LatLng(-25.73819746091608, -54.8761170313288),
                  LatLng(-25.28229443826649, -54.39352841706497),
                ),
              ),
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
                    color: Colors.black54,
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

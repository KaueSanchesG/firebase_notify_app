import 'package:firebase_notify_app/config/injection.dart';
import 'package:firebase_notify_app/domain/models/point_forecasts_data.dart';
import 'package:firebase_notify_app/ui/home/home_view_model.dart';
import 'package:firebase_notify_app/ui/home/widgets/bottom_panel.dart';
import 'package:firebase_notify_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
                    DateFormatter.format(widget.vm.selectedDate),
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

          final LayerHitNotifier<PointForecastsData> hitNotifier =
              ValueNotifier(null);

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(-25.50014516958931, -54.57859013732984),
                  initialZoom: 12.0,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(
                      const LatLng(-26.09520863582746, -55.05781652233589),
                      const LatLng(-25.26203083440155, -54.18796573265973),
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
                  MouseRegion(
                    hitTestBehavior: HitTestBehavior.deferToChild,
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        final LayerHitResult<PointForecastsData>? hitResult =
                            hitNotifier.value;
                        if (hitResult == null) return;

                        setState(() {
                          widget.vm.clickedPoint = hitResult.hitValues.last;
                        });
                      },
                      child: CircleLayer(
                        circles: widget.vm.currentPoints.map((point) {
                          return CircleMarker(
                            key: ValueKey(point.pointId),
                            point: point.coordinates,
                            useRadiusInMeter: true,
                            radius: 2500,
                            color: widget.vm
                                .getColor(point)
                                .withValues(alpha: 0.5),
                            hitValue: point,
                            borderStrokeWidth:
                                widget.vm.clickedPoint?.pointId == point.pointId
                                ? 3
                                : 0,
                            borderColor:
                                widget.vm.clickedPoint?.pointId == point.pointId
                                ? Colors.red
                                : Colors.transparent,
                          );
                        }).toList(),
                        hitNotifier: hitNotifier,
                      ),
                    ),
                  ),
                ],
              ),

              if (widget.vm.clickedPoint != null) ...[
                widget.vm.getVerticalScale(point: widget.vm.clickedPoint!),
                BottomPanel(
                  point: widget.vm.clickedPoint!,
                  onClose: widget.vm.closeBottomPanel,
                ),
              ] else ...[
                widget.vm.getVerticalScale(),
              ],
            ],
          );
        },
      ),
    );
  }
}

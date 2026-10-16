import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../services/navigation_service.dart';
import '../../services/route_generation_service.dart';
import '../../services/walking_route_service.dart';

/// Embedded Walking Tour Map Screen built with `flutter_map` and OpenStreetMap.
///
/// Features:
/// - OpenStreetMap-compatible tile layer (No embedded Google Maps).
/// - Automatic camera bounds fitting to the tour locations & route with padding.
/// - Custom numbered markers representing the walking order (①, ②, ③...).
/// - Real walking paths fetched from OpenRouteService.
/// - Interactive marker selection with bottom place card overlay.
/// - "Navigate with Maps →" button opening Google Maps externally via `map_launcher`.
class WalkingTourMapScreen extends StatefulWidget {
  final GeneratedWalkingTour tour;
  final WalkingRouteService? routeService;

  const WalkingTourMapScreen({
    super.key,
    required this.tour,
    this.routeService,
  });

  @override
  State<WalkingTourMapScreen> createState() => _WalkingTourMapScreenState();
}

class _WalkingTourMapScreenState extends State<WalkingTourMapScreen> {
  // Ceylon Heritage Design System Colors
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);
  static const Color borderColor = Color(0xFFE5D7C5);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color starGoldColor = Color(0xFF9F5625);

  final MapController _mapController = MapController();
  late final WalkingRouteService _routeService;

  List<LatLng> _routePolylinePoints = [];
  bool _isLoadingRoute = true;
  String? _routeErrorMessage;
  int _selectedStopIndex = 0;

  @override
  void initState() {
    super.initState();
    _routeService = widget.routeService ?? WalkingRouteService();
    _fetchRealWalkingRoute();
  }

  /// Extracts waypoints in exact walking order from the tour stops.
  List<LatLng> _extractWaypoints() {
    return widget.tour.stops
        .map((s) => LatLng(s.place.lat, s.place.lng))
        .toList();
  }

  Future<void> _fetchRealWalkingRoute({bool forceRefresh = false}) async {
    setState(() {
      _isLoadingRoute = true;
      _routeErrorMessage = null;
    });

    final waypoints = _extractWaypoints();

    if (waypoints.length < 2) {
      if (mounted) {
        setState(() {
          _routePolylinePoints = waypoints;
          _isLoadingRoute = false;
        });
      }
      return;
    }

    try {
      final result = await _routeService.getWalkingRoute(waypoints, forceRefresh: forceRefresh);

      if (mounted) {
        setState(() {
          if (result.hasPoints) {
            _routePolylinePoints = result.points;
            _routeErrorMessage = result.errorMessage;
          } else {
            // Fallback: connect waypoints directly if API fails so map remains fully functional
            _routePolylinePoints = waypoints;
            _routeErrorMessage =
                result.errorMessage ?? 'Walking path unavailable.';
          }
          _isLoadingRoute = false;
        });

        // Fit camera to full tour route & markers
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fitCameraToBounds();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _routePolylinePoints = waypoints;
          _routeErrorMessage = 'Network error while fetching route.';
          _isLoadingRoute = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fitCameraToBounds();
        });
      }
    }
  }

  /// Automatically fits the map camera to cover all locations and the complete route with padding.
  void _fitCameraToBounds() {
    final pointsToFit = _routePolylinePoints.isNotEmpty
        ? _routePolylinePoints
        : _extractWaypoints();

    if (pointsToFit.isEmpty) return;

    if (pointsToFit.length == 1) {
      _mapController.move(pointsToFit.first, 15.0);
      return;
    }

    try {
      final bounds = LatLngBounds.fromPoints(pointsToFit);
      // Guard against identical points (0 delta) which causes NaN zoom in flutter_map
      if (bounds.south == bounds.north && bounds.west == bounds.east) {
        _mapController.move(bounds.center, 14.5);
        return;
      }

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.fromLTRB(40, 110, 40, 230),
        ),
      );
    } catch (_) {
      // Safe fallback if fitting bounds encounters unexpected dimension
      if (pointsToFit.isNotEmpty) {
        _mapController.move(pointsToFit.first, 12.0);
      }
    }
  }

  void _onSelectMarker(int index) {
    setState(() => _selectedStopIndex = index);
    final stop = widget.tour.stops[index];
    _mapController.move(
      LatLng(stop.place.lat, stop.place.lng),
      _mapController.camera.zoom < 15.0 ? 15.5 : _mapController.camera.zoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stops = widget.tour.stops;
    final waypoints = _extractWaypoints();
    final initialCenter =
        waypoints.isNotEmpty ? waypoints.first : const LatLng(8.35, 80.39);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // --------------------------------------------------------
            // 1. EMBEDDED MAP (flutter_map with OpenStreetMap)
            // --------------------------------------------------------
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: 14.5,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
                onMapReady: () {
                  _fitCameraToBounds();
                },
              ),
              children: [
                // OpenStreetMap Tile Layer
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.ceylonheritage.app',
                  maxZoom: 19,
                ),

                // Real Walking Path Polyline Layer
                if (_routePolylinePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      // Outer shadow / glow line
                      Polyline(
                        points: _routePolylinePoints,
                        strokeWidth: 6.0,
                        color: accentColor.withValues(alpha: 0.35),
                      ),
                      // Core Walking route line
                      Polyline(
                        points: _routePolylinePoints,
                        strokeWidth: 4.0,
                        color: primaryColor,
                        pattern: const StrokePattern.solid(),
                      ),
                    ],
                  ),

                // Numbered Custom Markers Layer
                MarkerLayer(
                  markers: List.generate(stops.length, (index) {
                    final stop = stops[index];
                    final isSelected = index == _selectedStopIndex;
                    final latLng = LatLng(stop.place.lat, stop.place.lng);

                    return Marker(
                      point: latLng,
                      width: isSelected ? 48 : 40,
                      height: isSelected ? 56 : 46,
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () => _onSelectMarker(index),
                        child: _buildCustomNumberedMarker(
                          stepNumber: stop.stepNumber,
                          isSelected: isSelected,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            // --------------------------------------------------------
            // 2. TOP HEADER BAR: Ceylon Heritage
            // --------------------------------------------------------
            Positioned(
              top: 12,
              left: 14,
              right: 14,
              child: _buildTopHeaderBar(),
            ),

            // --------------------------------------------------------
            // 3. ROUTE STATUS / LOADING BANNER
            // --------------------------------------------------------
            if (_isLoadingRoute || _routeErrorMessage != null)
              Positioned(
                top: 74,
                left: 16,
                right: 16,
                child: _buildRouteStatusBanner(),
              ),

            // --------------------------------------------------------
            // 4. RE-CENTER CAMERA FLOATING BUTTON
            // --------------------------------------------------------
            Positioned(
              right: 16,
              bottom: 210,
              child: FloatingActionButton.small(
                heroTag: 'recenter_map',
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
                elevation: 3,
                shape: const CircleBorder(),
                onPressed: _fitCameraToBounds,
                child: const Icon(Icons.crop_free_rounded, size: 20),
              ),
            ),

            // --------------------------------------------------------
            // 5. PLACE CARD OVERLAY (At bottom of map)
            // --------------------------------------------------------
            if (stops.isNotEmpty && _selectedStopIndex < stops.length)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _buildBottomPlaceCard(stops[_selectedStopIndex]),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOP HEADER BAR
  // ============================================================
  Widget _buildTopHeaderBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: primaryColor,
              size: 22,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ceylon Heritage',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                Text(
                  '${widget.tour.stops.length} Historical Stops · Walking Circuit',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Fit Tour Route',
            icon: const Icon(
              Icons.fit_screen_rounded,
              color: primaryColor,
              size: 20,
            ),
            onPressed: _fitCameraToBounds,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ROUTE STATUS / LOADING BANNER
  // ============================================================
  Widget _buildRouteStatusBanner() {
    if (_isLoadingRoute) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Creating your walking route...',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ],
        ),
      );
    }

    if (_routeErrorMessage != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF4E5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFFCC80)),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                size: 15, color: accentColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _routeErrorMessage!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF663C00),
                ),
              ),
            ),
            const SizedBox(width: 6),
            InkWell(
              onTap: () => _fetchRealWalkingRoute(forceRefresh: true),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh_rounded, size: 14, color: accentColor),
                    const SizedBox(width: 3),
                    Text(
                      'Retry',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // ============================================================
  // CUSTOM NUMBERED MARKER
  // ============================================================
  Widget _buildCustomNumberedMarker({
    required int stepNumber,
    required bool isSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 38 : 32,
          height: isSelected ? 38 : 32,
          decoration: BoxDecoration(
            color: isSelected ? accentColor : primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: isSelected ? 2.5 : 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.35 : 0.20),
                blurRadius: isSelected ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              _formatCircledNumber(stepNumber),
              style: GoogleFonts.inter(
                fontSize: isSelected ? 15 : 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Pin pointer needle
        CustomPaint(
          size: Size(isSelected ? 10 : 8, isSelected ? 6 : 5),
          painter: _TrianglePointerPainter(
            color: isSelected ? accentColor : primaryColor,
          ),
        ),
      ],
    );
  }

  String _formatCircledNumber(int num) {
    const circledNumbers = ['①', '②', '③', '④', '⑤', '⑥', '⑦', '⑧', '⑨', '⑩'];
    if (num >= 1 && num <= circledNumbers.length) {
      return circledNumbers[num - 1];
    }
    return '$num';
  }

  // ============================================================
  // BOTTOM PLACE CARD (Appears over map upon marker selection)
  // ============================================================
  Widget _buildBottomPlaceCard(WalkingRouteStop stop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Stop Number Badge + Name + Stars
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular step tag
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${stop.stepNumber}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.place.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stop.place.placeCategory,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Stars Display
              if (stop.realAverageRating > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final isFilled = (i + 1) <= stop.realAverageRating.round();
                    return Icon(
                      isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 16,
                      color: isFilled ? starGoldColor : Colors.black26,
                    );
                  }),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Short Description
          Text(
            stop.place.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 14),

          // Action Button: [ Navigate with Maps → ]
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                NavigationService.navigateWithMaps(
                  latitude: stop.place.lat,
                  longitude: stop.place.lng,
                  title: stop.place.name,
                  description: stop.place.description,
                );
              },
              icon: const Icon(
                Icons.directions_walk_rounded,
                size: 20,
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Navigate with Maps',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple triangle pointer painter below circular markers
class _TrianglePointerPainter extends CustomPainter {
  final Color color;
  const _TrianglePointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePointerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

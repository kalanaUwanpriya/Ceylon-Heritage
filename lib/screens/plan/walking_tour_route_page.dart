import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/destination.dart';
import '../../services/route_generation_service.dart';
import '../services/services_screen.dart';

/// Screen displaying the Walking Tour Route Details, strictly constructed
/// by filtering places using real ratings from the database review system.
class WalkingTourRoutePage extends StatefulWidget {
  final String tempo;
  final String timeAvailable;
  final String ratingFilter;
  final Destination? destination;

  const WalkingTourRoutePage({
    super.key,
    required this.tempo,
    required this.timeAvailable,
    required this.ratingFilter,
    this.destination,
  });

  @override
  State<WalkingTourRoutePage> createState() => _WalkingTourRoutePageState();
}

class _WalkingTourRoutePageState extends State<WalkingTourRoutePage> {
  // Ceylon Heritage Design System Constants
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);
  static const Color pillBadgeColor = Color(0xFFDCE8E1);
  static const Color borderColor = Color(0xFFE5D7C5);
  static const Color starActiveColor = Color(0xFFE5A93C);
  static const Color starInactiveColor = Color(0xFFD8C7B3);

  final RouteGenerationService _routeService = RouteGenerationService();

  bool _isLoading = true;
  GeneratedWalkingTour? _tour;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadTour();
  }

  Future<void> _loadTour() async {
    setState(() => _isLoading = true);

    try {
      final generated = await _routeService.generateTour(
        tempo: widget.tempo,
        timeAvailable: widget.timeAvailable,
        ratingFilter: widget.ratingFilter,
        destinationName: widget.destination?.name ?? 'Anuradhapura',
      );

      if (mounted) {
        setState(() {
          _tour = generated;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingState()
            : (_tour == null || _tour!.isEmpty)
                ? _buildEmptyState()
                : _buildTourContent(),
      ),
      bottomNavigationBar: _isLoading || _tour == null || _tour!.isEmpty
          ? null
          : _buildBottomActions(),
    );
  }

  // ============================================================
  // LOADING STATE
  // ============================================================
  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildTopBar(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  strokeWidth: 3,
                ),
                const SizedBox(height: 20),
                Text(
                  'Querying Database Reviews...',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Calculating real average star ratings & generating circuit',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMPTY STATE (Filter excluded all places)
  // ============================================================
  Widget _buildEmptyState() {
    return Column(
      children: [
        _buildTopBar(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                  ),
                  child: const Icon(
                    Icons.star_half_rounded,
                    size: 38,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'No Places Meet Minimum Rating',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'None of the historical places currently have a real database average star rating >= ${widget.ratingFilter == '2 Star' ? '2.0' : '1.0'} stars.\n\nYou can view all places without rating restrictions by selecting "Any".',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: secondaryTextColor,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: Text(
                    'Adjust Rating Filter',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TOUR CONTENT
  // ============================================================
  Widget _buildTourContent() {
    final tour = _tour!;

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              _buildTopBar(context),

              // Hero section with sketch background
              _buildHeroSection(tour),

              const SizedBox(height: 16),

              // Total Duration & Distance Stat Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.access_time_rounded,
                        title: 'TOTAL DURATION',
                        value: tour.totalDurationLabel,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.location_on_outlined,
                        title: 'TOTAL DISTANCE',
                        value: tour.totalDistanceLabel,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Stops Timeline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTimeline(tour),
              ),
            ],
          ),
        ),

        // Floating Action Button (Map)
        Positioned(
          right: 20,
          bottom: 16,
          child: _buildFloatingMapButton(),
        ),
      ],
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: primaryColor,
              size: 24,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Text(
            'Heritage Sri Lanka',
            style: GoogleFonts.playfairDisplay(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _isFavorite ? Colors.redAccent : primaryColor,
              size: 24,
            ),
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO SECTION
  // ============================================================
  Widget _buildHeroSection(GeneratedWalkingTour tour) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background sketch illustration fading downwards
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.4, 0.95],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/Abackg.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Pill Badge: CURATED HISTORICAL CIRCUIT
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: pillBadgeColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.18),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tour.circuitTitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Hero Headline
                Text(
                  tour.headline,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  tour.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: secondaryTextColor,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: pillBadgeColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: const Color(0xFF7A7D78),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TIMELINE OF STOPS
  // ============================================================
  Widget _buildTimeline(GeneratedWalkingTour tour) {
    return Column(
      children: List.generate(tour.stops.length, (index) {
        final stop = tour.stops[index];
        final isLast = index == tour.stops.length - 1;

        return Column(
          children: [
            // Stop Row: Left Time/Badge + Right Place Card
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Time & Step Indicator
                SizedBox(
                  width: 72,
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        stop.arrivalTime,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: secondaryTextColor,
                        ),
                      ),
                      if (stop.stepNumber == 1) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'START',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: backgroundColor,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      // Step Number Circle
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${stop.stepNumber}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Right Column: Place Card
                Expanded(
                  child: _buildPlaceCard(stop),
                ),
              ],
            ),

            // Connecting Walk Leg (if not last)
            if (!isLast)
              _buildConnectingWalkLeg(stop),
          ],
        );
      }),
    );
  }

  // ============================================================
  // PLACE CARD (With Real Database Stars)
  // ============================================================
  Widget _buildPlaceCard(WalkingRouteStop stop) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 74,
              height: 74,
              child: Image.asset(
                stop.place.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: cardColor,
                  child: const Icon(
                    Icons.account_balance_rounded,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Star Rating Row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        stop.place.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // REAL DATABASE RATING STARS (Max 3 stars)
                    _buildDatabaseRatingStars(stop.realAverageRating),
                  ],
                ),

                const SizedBox(height: 4),

                // Description
                Text(
                  stop.place.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: secondaryTextColor,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 8),

                // Amenities & Duration Row
                Row(
                  children: [
                    // Audio Guide Icon
                    const Icon(
                      Icons.headphones_outlined,
                      size: 15,
                      color: Color(0xFF8B8F89),
                    ),
                    const SizedBox(width: 6),
                    // Parking Icon
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B8E83),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'P',
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Landmark / Ticket Icon
                    const Icon(
                      Icons.account_balance_outlined,
                      size: 15,
                      color: Color(0xFF8B8F89),
                    ),

                    const Spacer(),

                    // Duration Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: borderColor.withValues(alpha: 0.6),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: secondaryTextColor,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            stop.stayDurationLabel,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATABASE RATING STARS (Clamped strictly to 1..3 stars)
  // ============================================================
  Widget _buildDatabaseRatingStars(double averageRating) {
    // Round rating to the nearest integer for 3-star display
    final rounded = averageRating.clamp(0.0, 3.0).round();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final starNum = index + 1;
        final isFilled = starNum <= rounded;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 16,
            color: isFilled ? starActiveColor : starInactiveColor,
          ),
        );
      }),
    );
  }

  // ============================================================
  // CONNECTING WALK LEG
  // ============================================================
  Widget _buildConnectingWalkLeg(WalkingRouteStop stop) {
    String legText = '${stop.distanceToNextLabel} · ${stop.walkTimeToNextLabel}';
    if (stop.hasBreakAfter && stop.breakMinutesAfter > 0) {
      final breakLabel = stop.breakMinutesAfter >= 60
          ? '${stop.breakMinutesAfter ~/ 60}h break'
          : '${stop.breakMinutesAfter}m break';
      legText = '$legText · $breakLabel';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 36.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Vertical Connecting Line
          Container(
            width: 2,
            height: 48,
            color: primaryColor.withValues(alpha: 0.4),
          ),

          const SizedBox(width: 18),

          // Walk Info Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECE0),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.directions_walk_rounded,
                  size: 14,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: 5),
                Text(
                  legText,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLOATING MAP BUTTON
  // ============================================================
  Widget _buildFloatingMapButton() {
    return Material(
      color: Colors.transparent,
      elevation: 4,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=Anuradhapura+Sacred+City');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.map_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM ACTION BUTTONS: End Tour & Find Services
  // ============================================================
  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: borderColor.withValues(alpha: 0.7),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // End Tour Button (Outlined/White)
          Expanded(
            child: SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.outlined_flag_rounded,
                  size: 18,
                ),
                label: Text(
                  'End Tour',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  side: BorderSide(
                    color: primaryColor.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Find Services Button (Filled Dark Green)
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServicesScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.grid_view_rounded,
                  size: 18,
                ),
                label: Text(
                  'Find Services',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/historical_places_data.dart';
import '../services/visited_history_service.dart';

class VisitedHistoryScreen extends StatefulWidget {
  const VisitedHistoryScreen({super.key});

  @override
  State<VisitedHistoryScreen> createState() => _VisitedHistoryScreenState();
}

class _VisitedHistoryScreenState extends State<VisitedHistoryScreen> {
  final VisitedHistoryService _visitedHistoryService = VisitedHistoryService();

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  bool _isLoading = true;
  String? _errorMessage;

  List<Map<String, dynamic>> _visitedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadVisitedHistory();
  }

  Future<void> _loadVisitedHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final documents = await _visitedHistoryService.getVisitedHistory();

      final List<Map<String, dynamic>> loadedPlaces = [];

      for (final document in documents) {
        final data = document.data();

        final String? placeId = data['placeId'] as String?;
        final String? routeId = data['routeId'] as String?;
        final Timestamp? visitedAt = data['visitedAt'] as Timestamp?;

        if (placeId == null || placeId.isEmpty) {
          continue;
        }

        final historicalPlace = _findHistoricalPlace(placeId);

        if (historicalPlace == null) {
          continue;
        }

        loadedPlaces.add({
          'documentId': document.id,
          'place': historicalPlace,
          'visitedAt': visitedAt,
          'routeId': routeId,
        });
      }

      if (!mounted) return;

      setState(() {
        _visitedPlaces = loadedPlaces;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to load your visited history.';
      });
    }
  }

  dynamic _findHistoricalPlace(String placeId) {
    final allPlaces = [
      ...polonnaruwaPlaces,
      ...jaffnaPlaces,
      ...downSouthPlaces,
    ];

    final normalizedId = placeId.toLowerCase().trim();

    for (final place in allPlaces) {
      final normalizedName = place.name.toLowerCase().trim();

      final generatedId = normalizedName
          .replaceAll(' ', '_')
          .replaceAll('&', 'and')
          .replaceAll('(', '')
          .replaceAll(')', '');

      if (generatedId == normalizedId) {
        return place;
      }

      if (placeId == 'gal_viharaya' && place.name == 'Gal Viharaya') {
        return place;
      }

      if (placeId == 'royal_palace' && place.name == 'Royal Palace') {
        return place;
      }

      if (placeId == 'rankoth_vehera' && place.name == 'Rankoth Vehera') {
        return place;
      }

      if (placeId == 'lankathilaka' &&
          place.name == 'Lankathilaka Image House') {
        return place;
      }

      if (placeId == 'parakrama_samudraya' &&
          place.name == 'Parakrama Samudraya') {
        return place;
      }

      if (placeId == 'nallur_kandaswamy_kovil' &&
          place.name == 'Nallur Kandaswamy Kovil') {
        return place;
      }
    }

    return null;
  }

  String _formatVisitedDate(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'Visited date unavailable';
    }

    final date = timestamp.toDate();

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: cardColor,
              foregroundColor: primaryColor,
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Visited History',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_visitedPlaces.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      color: primaryColor,
      backgroundColor: cardColor,
      onRefresh: _loadVisitedHistory,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: _visitedPlaces.length,
        itemBuilder: (context, index) {
          final item = _visitedPlaces[index];
          final place = item['place'];
          final Timestamp? visitedAt = item['visitedAt'];

          return _buildVisitedCard(place: place, visitedAt: visitedAt);
        },
      ),
    );
  }

  Widget _buildVisitedCard({
    required dynamic place,
    required Timestamp? visitedAt,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            place.image,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 170,
                width: double.infinity,
                color: backgroundColor,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 46,
                    color: primaryColor,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 13, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: accentColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        place.location,
                        style: const TextStyle(
                          color: secondaryTextColor,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Visited: ${_formatVisitedDate(visitedAt)}',
                          style: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      color: primaryColor,
      backgroundColor: cardColor,
      onRefresh: _loadVisitedHistory,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.16),
          Center(
            child: Column(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: const Icon(
                    Icons.history_rounded,
                    size: 43,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'No Visited Places Yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Places you visit will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryTextColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accentColor.withValues(alpha: 0.22)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: accentColor,
              ),
              const SizedBox(height: 13),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _loadVisitedHistory,
                icon: const Icon(Icons.refresh_rounded, size: 19),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

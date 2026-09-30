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
      backgroundColor: const Color(0xFFF7F2EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2EB),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E3A2B)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Visited History',
          style: TextStyle(
            color: Color(0xFF1E3A2B),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF1E3A2B)),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_visitedPlaces.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      color: const Color(0xFF1E3A2B),
      onRefresh: _loadVisitedHistory,
      child: ListView.builder(
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
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              place.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: const Color(0xFFE8E0D5),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Color(0xFF1E3A2B),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    color: Color(0xFF1E3A2B),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Color(0xFFC88E38),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        place.location,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 17,
                      color: Color(0xFF1E3A2B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Visited: ${_formatVisitedDate(visitedAt)}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E0D5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history,
                size: 45,
                color: Color(0xFF1E3A2B),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Visited Places Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E3A2B),
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Places you visit will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 55, color: Color(0xFF1E3A2B)),
            const SizedBox(height: 15),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Color(0xFF1E3A2B)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadVisitedHistory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A2B),
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

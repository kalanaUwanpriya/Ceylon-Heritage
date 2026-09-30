import 'package:flutter/material.dart';

import '../services/notification_preferences_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final NotificationPreferencesService _preferencesService =
      NotificationPreferencesService();

  bool generalUpdates = true;
  bool routeRecommendations = true;
  bool savedPlaces = true;
  bool eventsActivities = true;
  bool offersPromotions = false;
  bool travelTips = true;
  bool securityAlerts = true;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // ============================================================
  // LOAD PREFERENCES FROM FIRESTORE
  // ============================================================

  Future<void> _loadPreferences() async {
    try {
      final preferences = await _preferencesService.getPreferences();

      if (!mounted) return;

      setState(() {
        generalUpdates = preferences['generalUpdates'] as bool? ?? true;

        routeRecommendations =
            preferences['routeRecommendations'] as bool? ?? true;

        savedPlaces = preferences['savedPlaces'] as bool? ?? true;

        eventsActivities = preferences['eventsActivities'] as bool? ?? true;

        offersPromotions = preferences['offersPromotions'] as bool? ?? false;

        travelTips = preferences['travelTips'] as bool? ?? true;

        securityAlerts = preferences['securityAlerts'] as bool? ?? true;

        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to load notification preferences.'),
        ),
      );
    }
  }

  // ============================================================
  // SAVE PREFERENCES TO FIRESTORE
  // ============================================================

  Future<void> _savePreferences() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await _preferencesService.savePreferences(
        generalUpdates: generalUpdates,
        routeRecommendations: routeRecommendations,
        savedPlaces: savedPlaces,
        eventsActivities: eventsActivities,
        offersPromotions: offersPromotions,
        travelTips: travelTips,
        securityAlerts: securityAlerts,
      );

      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification preferences saved successfully.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to save notification preferences.'),
        ),
      );
    }
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

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
          'Notification Settings',
          style: TextStyle(
            color: Color(0xFF1E3A2B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF1E3A2B)),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manage Notifications',
                      style: TextStyle(
                        color: Color(0xFF1E3A2B),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Choose the types of notifications you would like to receive.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildNotificationCard(
                      title: 'General Updates',
                      description:
                          'Receive important updates about the Heritage Walks app.',
                      value: generalUpdates,
                      onChanged: (value) {
                        setState(() {
                          generalUpdates = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Route Recommendations',
                      description:
                          'Get recommendations for walking routes and places.',
                      value: routeRecommendations,
                      onChanged: (value) {
                        setState(() {
                          routeRecommendations = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Saved Places',
                      description:
                          'Receive updates related to your saved places.',
                      value: savedPlaces,
                      onChanged: (value) {
                        setState(() {
                          savedPlaces = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Events & Activities',
                      description:
                          'Stay informed about heritage events and activities.',
                      value: eventsActivities,
                      onChanged: (value) {
                        setState(() {
                          eventsActivities = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Offers & Promotions',
                      description:
                          'Receive special offers and promotional notifications.',
                      value: offersPromotions,
                      onChanged: (value) {
                        setState(() {
                          offersPromotions = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Travel Tips',
                      description:
                          'Get useful travel tips for exploring Sri Lanka.',
                      value: travelTips,
                      onChanged: (value) {
                        setState(() {
                          travelTips = value;
                        });
                      },
                    ),

                    _buildNotificationCard(
                      title: 'Security Alerts',
                      description:
                          'Receive important safety and security notifications.',
                      value: securityAlerts,
                      onChanged: (value) {
                        setState(() {
                          securityAlerts = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _savePreferences,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A2B),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFF9EAAA3),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save Preferences',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ============================================================
  // NOTIFICATION CARD
  // ============================================================

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0EA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF1E3A2B),
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E3A2B),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF1E3A2B),
          ),
        ],
      ),
    );
  }
}

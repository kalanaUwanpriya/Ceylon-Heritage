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
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

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
          'Notification Settings',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manage Notifications',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Choose the types of notifications you would like to receive.',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildNotificationCard(
                      icon: Icons.notifications_none_rounded,
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
                      icon: Icons.route_outlined,
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
                      icon: Icons.favorite_border_rounded,
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
                      icon: Icons.event_outlined,
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
                      icon: Icons.local_offer_outlined,
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
                      icon: Icons.lightbulb_outline_rounded,
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
                      icon: Icons.shield_outlined,
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

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _savePreferences,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: primaryColor.withValues(
                            alpha: 0.45,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 21,
                                height: 21,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.3,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save Preferences',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
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

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: Center(child: Icon(icon, color: primaryColor, size: 23)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Transform.scale(
            scale: 0.88,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: backgroundColor,
              activeTrackColor: primaryColor,
              inactiveThumbColor: secondaryTextColor,
              inactiveTrackColor: backgroundColor,
              trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                (states) => states.contains(WidgetState.selected)
                    ? primaryColor
                    : secondaryTextColor.withValues(alpha: 0.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

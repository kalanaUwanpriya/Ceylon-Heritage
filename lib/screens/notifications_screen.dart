import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/notification_preferences_service.dart';

bool isNotificationEnabled(String category, Map<String, dynamic> preferences) {
  const categories = {
    'generalUpdates': 'generalUpdates',
    'routeRecommendations': 'routeRecommendations',
    'savedPlaces': 'savedPlaces',
    'eventsActivities': 'eventsActivities',
    'offersPromotions': 'offersPromotions',
    'travelTips': 'travelTips',
    'securityAlerts': 'securityAlerts',
  };

  final preferenceKey = categories[category];

  if (preferenceKey == null) {
    return true;
  }

  return preferences[preferenceKey] as bool? ??
      (preferenceKey != 'offersPromotions');
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const Color darkGreen = Color(0xFF1E3A2B);
  static const Color cream = Color(0xFFF9F5EB);

  final NotificationPreferencesService _preferencesService =
      NotificationPreferencesService();

  Map<String, dynamic>? _preferences;
  bool _loadingPreferences = true;
  String? _preferencesError;

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
        _preferences = preferences;
        _loadingPreferences = false;
        _preferencesError = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingPreferences = false;
        _preferencesError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please sign in to view notifications.')),
      );
    }

    final notifications = FirebaseFirestore.instance.collection(
      'notifications',
    );

    final allUsersStream = notifications
        .where('recipientType', isEqualTo: 'all')
        .snapshots();

    final selectedUsersStream = notifications
        .where('recipientType', isEqualTo: 'selected')
        .where('recipientIds', arrayContains: user.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold),
        ),
        backgroundColor: cream,
        foregroundColor: darkGreen,
        elevation: 0,
      ),
      body: _loadingPreferences
          ? const Center(child: CircularProgressIndicator(color: darkGreen))
          : _preferencesError != null
          ? _errorWidget(_preferencesError)
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: allUsersStream,
              builder: (context, allSnapshot) {
                if (allSnapshot.hasError) {
                  return _errorWidget(allSnapshot.error);
                }

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: selectedUsersStream,
                  builder: (context, selectedSnapshot) {
                    if (selectedSnapshot.hasError) {
                      return _errorWidget(selectedSnapshot.error);
                    }

                    if (!allSnapshot.hasData || !selectedSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: darkGreen),
                      );
                    }

                    final notificationMap =
                        <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

                    for (final doc in allSnapshot.data!.docs) {
                      notificationMap[doc.id] = doc;
                    }

                    for (final doc in selectedSnapshot.data!.docs) {
                      notificationMap[doc.id] = doc;
                    }

                    final preferences = _preferences!;

                    final notificationList = notificationMap.values.where((
                      doc,
                    ) {
                      final category =
                          doc.data()['category']?.toString() ??
                          'generalUpdates';

                      return isNotificationEnabled(category, preferences);
                    }).toList();

                    notificationList.sort((a, b) {
                      final aDate = a.data()['createdAt'];
                      final bDate = b.data()['createdAt'];

                      final aTime = aDate is Timestamp
                          ? aDate.millisecondsSinceEpoch
                          : 0;

                      final bTime = bDate is Timestamp
                          ? bDate.millisecondsSinceEpoch
                          : 0;

                      return bTime.compareTo(aTime);
                    });

                    if (notificationList.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 65,
                              color: Color(0xFF9BA99E),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'No notifications yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: darkGreen,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Your updates will appear here.',
                              style: TextStyle(color: Color(0xFF7D897F)),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: notificationList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final data = notificationList[index].data();

                        final title = data['title']?.toString() ?? '';

                        final message = data['message']?.toString() ?? '';

                        final category =
                            data['category']?.toString() ?? 'generalUpdates';

                        final createdAt = data['createdAt'];

                        String dateText = '';

                        if (createdAt is Timestamp) {
                          final date = createdAt.toDate();

                          dateText =
                              '${date.day}/${date.month}/${date.year} '
                              '${date.hour.toString().padLeft(2, '0')}:'
                              '${date.minute.toString().padLeft(2, '0')}';
                        }

                        return Container(
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE8E5DD)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9F0E9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _categoryIcon(category),
                                  color: darkGreen,
                                  size: 23,
                                ),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: darkGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      message,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF58675D),
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      dateText,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF929C93),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  static IconData _categoryIcon(String category) {
    switch (category) {
      case 'generalUpdates':
        return Icons.campaign_outlined;
      case 'routeRecommendations':
        return Icons.route_outlined;
      case 'savedPlaces':
        return Icons.favorite_border_rounded;
      case 'eventsActivities':
        return Icons.event_outlined;
      case 'offersPromotions':
        return Icons.local_offer_outlined;
      case 'travelTips':
        return Icons.lightbulb_outline_rounded;
      case 'securityAlerts':
        return Icons.security_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Widget _errorWidget(Object? error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Unable to load notifications.\n$error',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}

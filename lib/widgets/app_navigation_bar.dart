import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/saved_places_screen.dart';
import '../screens/services/services_screen.dart';

class AppNavigationRoutes {
  static const home = '/home';
  static const services = '/services';
  static const saved = '/saved';
  static const profile = '/profile';
}

/// Shared primary navigation used by the main application screens.
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  static const _green = Color(0xFF1E3A2B);
  static const _navBg = Color(0xFFF1DFC6);
  static const _items = <({IconData icon, String label})>[
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.grid_view_rounded, label: 'Services'),
    (icon: Icons.favorite_border_rounded, label: 'Saved'),
    (icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  /// Centralized navigation logic for the four primary app destinations.
  /// Prevents duplicate page stacking, navigation loops, and preserves state.
  static void handleNavigation(
    BuildContext context,
    int targetIndex, {
    int? currentIndex,
  }) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;
    final isAtRoot = !Navigator.of(context).canPop();

    // Prevent re-navigating to the current tab if already on its primary screen
    if (targetIndex == 0 &&
        (currentRouteName == AppNavigationRoutes.home ||
            (isAtRoot && currentIndex == 0))) {
      return;
    }
    if (targetIndex == 1 && currentRouteName == AppNavigationRoutes.services) {
      return;
    }
    if (targetIndex == 2 && currentRouteName == AppNavigationRoutes.saved) {
      return;
    }
    if (targetIndex == 3 && currentRouteName == AppNavigationRoutes.profile) {
      return;
    }

    switch (targetIndex) {
      case 0:
        // Home: Return directly to the root HomeScreen, popping any pages above it.
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              settings: const RouteSettings(name: AppNavigationRoutes.home),
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        }
        break;

      case 1:
        // Services: Navigate directly to the Services page, maintaining HomeScreen as root.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            settings: const RouteSettings(name: AppNavigationRoutes.services),
            builder: (context) => const ServicesScreen(),
          ),
          (route) => route.isFirst,
        );
        break;

      case 2:
        // Saved: Navigate directly to the Saved page, maintaining HomeScreen as root.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            settings: const RouteSettings(name: AppNavigationRoutes.saved),
            builder: (context) => const SavedPlacesScreen(),
          ),
          (route) => route.isFirst,
        );
        break;

      case 3:
        // Profile: Navigate directly to the Profile page, maintaining HomeScreen as root.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            settings: const RouteSettings(name: AppNavigationRoutes.profile),
            builder: (context) => const ProfileScreen(),
          ),
          (route) => route.isFirst,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _navBg,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final selected = index == selectedIndex;
            return Expanded(
              child: Semantics(
                button: true,
                selected: selected,
                label: item.label,
                child: InkWell(
                  onTap: () {
                    if (onDestinationSelected != null) {
                      onDestinationSelected!(index);
                    } else {
                      handleNavigation(
                        context,
                        index,
                        currentIndex: selectedIndex,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(26),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    height: 76,
                    decoration: BoxDecoration(
                      color: selected ? _green : Colors.transparent,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 28,
                          color: selected ? Colors.white : _green,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: selected ? Colors.white : _green,
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}
}

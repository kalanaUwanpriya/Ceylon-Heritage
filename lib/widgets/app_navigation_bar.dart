import 'package:flutter/material.dart';

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
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _green = Color(0xFF1E3A2B);
  static const _cream = Color(0xFFF4E8D6);
  static const _items = <({IconData icon, String label})>[
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.grid_view_rounded, label: 'Services'),
    (icon: Icons.favorite_border_rounded, label: 'Saved'),
    (icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SafeArea(
        top: false,
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
                  onTap: () => onDestinationSelected(index),
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
                        Icon(item.icon, size: 28,
                            color: selected ? Colors.white : _green),
                        const SizedBox(height: 4),
                        Text(item.label,
                            style: TextStyle(
                              color: selected ? Colors.white : _green,
                              fontSize: 13,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

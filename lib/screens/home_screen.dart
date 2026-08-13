import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceItem {
  final String title;
  final String subtitle;
  final String imagePath;

  const PlaceItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of places according to requested design & ordering (Sigiriya placed after Galle)
  final List<PlaceItem> _places = const [
    PlaceItem(
      title: 'Anuradhapura',
      subtitle: 'Sacred City of Ancient Sri Lanka',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    PlaceItem(
      title: 'Polonnaruwa',
      subtitle: 'Ancient City',
      imagePath: 'assets/images/polonnaruwa.png',
    ),
    PlaceItem(
      title: 'Kandy',
      subtitle: 'Temple of the Tooth',
      imagePath: 'assets/images/kandy.png',
    ),
    PlaceItem(
      title: 'Galle',
      subtitle: 'Dutch Heritage',
      imagePath: 'assets/images/galle.png',
    ),
    PlaceItem(
      title: 'Sigiriya',
      subtitle: 'Rock Fortress',
      imagePath: 'assets/images/sigiriya.png',
    ),
    PlaceItem(
      title: 'Yapahuwa',
      subtitle: 'Hill Fortress',
      imagePath: 'assets/images/yapahuwa.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF7F2EB);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Section & Search Bar (Scrollable content)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner with background line sketch artwork
                    Stack(
                      children: [
                        // Background sketch image with subtle fading gradient bottom overlay
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 180,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.35),
                                  Colors.transparent,
                                ],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: Image.asset(
                              'assets/images/heritage_sketch_bg.jpg',
                              fit: BoxFit.cover,
                              opacity: const AlwaysStoppedAnimation(0.45),
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),

                        // Header Text and Notification Icon
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back!',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E2D27),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Where will you explore today?',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),

                              // Bell Notification Icon Button
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Notifications tapped'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: Color(0xFF1E2D27),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE8DC),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: const Color(0xFFE3D8C8),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF1E2D27),
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search places, routes...',
                            hintStyle: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF8A948C),
                              fontSize: 15,
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 16, right: 12),
                              child: Icon(
                                Icons.search_rounded,
                                color: Color(0xFF5A6E60),
                                size: 22,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Destination Cards List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _places.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final place = _places[index];
                          return _buildPlaceCard(context, place);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Custom Bottom Navigation Bar
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  // Widget to build place card button
  Widget _buildPlaceCard(BuildContext context, PlaceItem place) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Exploring ${place.title}...'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Card Photo Background
                Image.asset(
                  place.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF2C3E35),
                      child: Center(
                        child: Icon(
                          Icons.landscape_rounded,
                          size: 48,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  },
                ),

                // Dark Gradient Overlay for optimal legibility
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                // Content inside card (Title, Subtitle, Arrow Button)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Text Info
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              place.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Circular Action Button (Arrow Right)
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(
                            0xFF1E2D27,
                          ).withValues(alpha: 0.65),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Bottom Navigation Bar matching the exact design
  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2EB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'HOME'),
            _buildNavItem(index: 1, icon: Icons.map_outlined, label: 'MAP'),
            _buildNavItem(
              index: 2,
              icon: Icons.favorite_border_rounded,
              label: 'SAVED',
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.person_outline_rounded,
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFE8DC) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? const Color(0xFF1E2D27)
                  : const Color(0xFF7A867E),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                letterSpacing: 0.5,
                color: isSelected
                    ? const Color(0xFF1E2D27)
                    : const Color(0xFF7A867E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

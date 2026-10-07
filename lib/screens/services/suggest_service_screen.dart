import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_suggestions_screen.dart';

class SuggestServiceScreen extends StatefulWidget {
  const SuggestServiceScreen({super.key});

  @override
  State<SuggestServiceScreen> createState() => _SuggestServiceScreenState();
}

class _SuggestServiceScreenState extends State<SuggestServiceScreen> {
  final Color backgroundColor = const Color(0xFFF6EADA);
  final Color primaryGreen = const Color(0xFF17452F);
  final Color cardColor = const Color(0xFFF0DDC3);
  final Color accentColor = const Color(0xFF9F5625);

  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCity;
  String? selectedCategory;

  final List<String> cities = [
    'Anuradhapura',
    'Polonnaruwa',
    'Kandy',
    'Jaffna',
    'Down South',
    'Dambulla',
  ];

  final List<String> categories = [
    'Accommodation',
    'Food & Restaurants',
    'Parking',
    'Health Services',
  ];

  @override
  void dispose() {
    serviceNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryGreen,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Suggest a Service',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/services/service_suggest.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help other travellers discover useful places.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: primaryGreen.withValues(alpha: 0.75),
                  ),
                ),

                const SizedBox(height: 25),

                _buildLabel('Place Name'),
                _buildTextField(
                  controller: serviceNameController,
                  hint: 'Enter place name',
                  icon: Icons.storefront_outlined,
                ),

                const SizedBox(height: 18),

                _buildLabel('City'),
                _buildDropdown(
                  value: selectedCity,
                  hint: 'Select city',
                  icon: Icons.location_city_outlined,
                  items: cities,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                ),

                const SizedBox(height: 18),

                _buildLabel('Category'),
                _buildDropdown(
                  value: selectedCategory,
                  hint: 'Select category',
                  icon: Icons.category_outlined,
                  items: categories,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),

                const SizedBox(height: 18),

                _buildLabel('Location'),
                _buildTextField(
                  controller: locationController,
                  hint: 'Enter location or address',
                  icon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 18),

                _buildLabel('Description'),
                _buildTextField(
                  controller: descriptionController,
                  hint: 'Tell us about this service...',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (serviceNameController.text.trim().isEmpty ||
                          selectedCity == null ||
                          selectedCategory == null ||
                          locationController.text.trim().isEmpty ||
                          descriptionController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields'),
                          ),
                        );
                        return;
                      }

                      try {
                        final User? user = FirebaseAuth.instance.currentUser;

                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please login first')),
                          );
                          return;
                        }

                        await FirebaseFirestore.instance
                            .collection('service_suggestions')
                            .add({
                              'serviceName': serviceNameController.text.trim(),
                              'city': selectedCity,
                              'category': selectedCategory,
                              'location': locationController.text.trim(),
                              'description': descriptionController.text.trim(),
                              'userId': user.uid,
                              'status': 'pending',
                              'createdAt': FieldValue.serverTimestamp(),
                            });

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Service suggestion submitted successfully!',
                            ),
                          ),
                        );

                        serviceNameController.clear();
                        locationController.clear();
                        descriptionController.clear();

                        setState(() {
                          selectedCity = null;
                          selectedCategory = null;
                        });
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to submit suggestion: $e'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: backgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 20,
                    ),
                    label: Text(
                      'Submit Suggestion',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySuggestionsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'View My Suggestions',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: primaryGreen,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(fontSize: 13, color: primaryGreen),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: primaryGreen.withValues(alpha: 0.45),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? 65 : 0),
          child: Icon(
            icon,
            color: primaryGreen.withValues(alpha: 0.65),
            size: 20,
          ),
        ),
        filled: true,
        fillColor: cardColor.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryGreen.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryGreen, width: 1.3),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: backgroundColor,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryGreen),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: primaryGreen.withValues(alpha: 0.65),
          size: 20,
        ),
        filled: true,
        fillColor: cardColor.withValues(alpha: 0.55),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryGreen.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryGreen, width: 1.3),
        ),
      ),
      hint: Text(
        hint,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: primaryGreen.withValues(alpha: 0.45),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.inter(fontSize: 13, color: primaryGreen),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

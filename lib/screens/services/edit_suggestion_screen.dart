import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSuggestionScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> suggestion;

  const EditSuggestionScreen({
    super.key,
    required this.documentId,
    required this.suggestion,
  });

  @override
  State<EditSuggestionScreen> createState() => _EditSuggestionScreenState();
}

class _EditSuggestionScreenState extends State<EditSuggestionScreen> {
  final Color backgroundColor = const Color(0xFFF6EADA);
  final Color primaryGreen = const Color(0xFF17452F);
  final Color cardColor = const Color(0xFFF0DDC3);

  late TextEditingController serviceNameController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  String? selectedCity;
  String? selectedCategory;
  bool isUpdating = false;

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
  void initState() {
    super.initState();

    serviceNameController = TextEditingController(
      text: widget.suggestion['serviceName'] ?? '',
    );

    locationController = TextEditingController(
      text: widget.suggestion['location'] ?? '',
    );

    descriptionController = TextEditingController(
      text: widget.suggestion['description'] ?? '',
    );

    selectedCity = widget.suggestion['city'];
    selectedCategory = widget.suggestion['category'];
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateSuggestion() async {
    if (serviceNameController.text.trim().isEmpty ||
        selectedCity == null ||
        selectedCategory == null ||
        locationController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      isUpdating = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('service_suggestions')
          .doc(widget.documentId)
          .update({
            'serviceName': serviceNameController.text.trim(),
            'city': selectedCity,
            'category': selectedCategory,
            'location': locationController.text.trim(),
            'description': descriptionController.text.trim(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Suggestion updated successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update suggestion: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isUpdating = false;
        });
      }
    }
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Suggestion',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update your service suggestion.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: primaryGreen.withValues(alpha: 0.75),
                ),
              ),

              const SizedBox(height: 25),

              _buildLabel('Service Name'),
              _buildTextField(
                controller: serviceNameController,
                hint: 'Enter service name',
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
                  onPressed: isUpdating ? null : _updateSuggestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: backgroundColor,
                    disabledBackgroundColor: primaryGreen.withValues(
                      alpha: 0.55,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  icon: isUpdating
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: backgroundColor,
                          ),
                        )
                      : const Icon(Icons.save_outlined, size: 20),
                  label: Text(
                    isUpdating ? 'Updating...' : 'Update Suggestion',
                    style: GoogleFonts.inter(
                      fontSize: 14,
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

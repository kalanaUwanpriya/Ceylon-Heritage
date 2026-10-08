import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/place_lookup.dart';
import '../services/saved_places_service.dart';

class SavePlaceButton extends StatefulWidget {
  final String placeId;
  final String? placeName;
  final String? destinationName;
  final String? location;
  final String? description;
  final String? image;
  final Color darkGreen;

  const SavePlaceButton({
    super.key,
    required this.placeId,
    this.placeName,
    this.destinationName,
    this.location,
    this.description,
    this.image,
    this.darkGreen = const Color(0xFF17452F),
  });

  @override
  State<SavePlaceButton> createState() => _SavePlaceButtonState();
}

class _SavePlaceButtonState extends State<SavePlaceButton> {
  final SavedPlacesService _service = SavedPlacesService();
  bool _isProcessing = false;

  Future<void> _toggleSave(bool isCurrentlySaved) async {
    if (_isProcessing) return;

    final messenger = ScaffoldMessenger.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Please log in to save places.',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: widget.darkGreen,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      if (isCurrentlySaved) {
        await _service.removeSavedPlace(widget.placeId);
        if (!mounted) return;
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              'Place removed from saved places.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: widget.darkGreen,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Resolve place details
        final lookup = PlaceLookup.lookup(widget.placeId);
        final name = widget.placeName ?? lookup.name;
        final location = widget.location ?? lookup.location;
        final description = widget.description ?? lookup.description;
        final image = widget.image ?? lookup.image;

        await _service.savePlace(
          destinationId: widget.placeId,
          destinationName: name,
          destinationImage: image,
          location: location,
          description: description,
        );

        if (!mounted) return;
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              'Place saved successfully.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: widget.darkGreen,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Action failed: $e',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _service.watchIsPlaceSaved(widget.placeId),
      initialData: false,
      builder: (context, snapshot) {
        final isSaved = snapshot.data ?? false;

        if (isSaved) {
          // SAVED STATE: Dark green circular background with white outlined heart inside
          return IconButton(
            tooltip: 'Remove from Saved',
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.darkGreen,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () => _toggleSave(true),
          );
        }

        // UNSAVED STATE: Original outlined heart appearance unchanged
        return IconButton(
          tooltip: 'Save Place',
          icon: Icon(
            Icons.favorite_border_rounded,
            color: widget.darkGreen,
            size: 28,
          ),
          onPressed: () => _toggleSave(false),
        );
      },
    );
  }
}

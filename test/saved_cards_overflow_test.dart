import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ceylon_heritage/screens/saved_places_screen.dart';
import 'package:ceylon_heritage/services/saved_places_service.dart';

void main() {
  testWidgets('Full Saved screen cards test with SizedBox spacing between Expanded across devices & textScalers', (WidgetTester tester) async {
    final testServices = [
      const SavedPlaceModel(
        id: 'serv_1',
        userId: 'user_1',
        destinationId: 'service_hospital_polonnaruwa',
        destinationName: 'District General Hospital Polonnaruwa',
        destinationImage: 'assets/images/services/polonnaruwa/District General Hospital Polonnaruwa.jpg',
        location: 'Polonnaruwa',
        description: 'District General Hospital Polonnaruwa is a healthcare location.',
        type: 'service',
        category: 'Hospitals',
      ),
      const SavedPlaceModel(
        id: 'serv_2',
        userId: 'user_1',
        destinationId: 'service_matara',
        destinationName: 'District General Hospital Matara',
        destinationImage: 'assets/images/services/downsouth/District General Hospital Matara.jpg',
        location: 'Matara',
        description: 'District General Hospital Matara.',
        type: 'service',
        category: 'Hospitals',
      ),
      const SavedPlaceModel(
        id: 'serv_3',
        userId: 'user_1',
        destinationId: 'service_tourist_police',
        destinationName: 'Tourist Police Station',
        destinationImage: '',
        location: 'Colombo',
        description: 'Police service.',
        type: 'service',
        category: 'Emergency',
      ),
      const SavedPlaceModel(
        id: 'serv_4',
        userId: 'user_1',
        destinationId: 'service_atm',
        destinationName: 'Bank of Ceylon ATM',
        destinationImage: '',
        location: 'Kandy',
        description: 'ATM service.',
        type: 'service',
        category: 'Bank',
      ),
    ];

    final testPlaces = [
      const SavedPlaceModel(
        id: 'place_1',
        userId: 'user_1',
        destinationId: 'place_polonnaruwa_vatadage',
        destinationName: 'Polonnaruwa Vatadage',
        destinationImage: 'assets/images/polonnaruwa.jpg',
        location: 'Polonnaruwa, Sri Lanka',
        description: 'Ancient structure.',
        type: 'place',
      ),
      const SavedPlaceModel(
        id: 'place_2',
        userId: 'user_1',
        destinationId: 'place_hospital',
        destinationName: 'District General Hospital Polonnaruwa',
        destinationImage: 'assets/images/services/polonnaruwa/District General Hospital Polonnaruwa.jpg',
        location: 'Polonnaruwa, North Central Province, Sri Lanka',
        description: 'Hospital historical site.',
        type: 'place',
      ),
      const SavedPlaceModel(
        id: 'place_3',
        userId: 'user_1',
        destinationId: 'place_sigiriya',
        destinationName: 'Sigiriya Ancient Fortress',
        destinationImage: 'assets/images/sigiriya.jpg',
        location: 'Matale District, Sri Lanka',
        description: 'Rock fortress.',
        type: 'place',
      ),
    ];

    final screenWidths = [320.0, 340.0, 360.0, 375.0, 390.0, 393.0, 411.0, 414.0, 480.0, 600.0, 800.0];
    final textScalers = [0.85, 1.0, 1.15, 1.3];

    for (final scale in textScalers) {
      for (final w in screenWidths) {
        tester.view.physicalSize = Size(w, 1400);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(useMaterial3: true),
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(w, 1400),
                textScaler: TextScaler.linear(scale),
              ),
              child: Scaffold(
                backgroundColor: const Color(0xFFF6EADA),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          _buildGridWithSizedBoxSpacing(context, testServices, false),
                          const SizedBox(height: 16),
                          _buildGridWithSizedBoxSpacing(context, testPlaces, true),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        final err = tester.takeException();
        expect(err, isNull, reason: 'Failed at width $w with text scale $scale');
      }
    }
  });
}

Widget _buildGridWithSizedBoxSpacing(BuildContext context, List<SavedPlaceModel> items, bool isPlace) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth >= 600 ? 4 : 3;
      final rowCount = (items.length / crossAxisCount).ceil();
      final cardWidth = (constraints.maxWidth - (crossAxisCount - 1) * 10) / crossAxisCount;
      final textScaler = MediaQuery.textScalerOf(context);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(rowCount, (rowIndex) {
          final startIndex = rowIndex * crossAxisCount;
          final endIndex = (startIndex + crossAxisCount).clamp(0, items.length);
          final rowItems = items.sublist(startIndex, endIndex);

          double maxRowHeight = 140.0;
          for (final item in rowItems) {
            final h = SavedPlacesScreen.calculateSavedCardHeight(
              place: item,
              cardWidth: cardWidth,
              textScaler: textScaler,
              isPlace: isPlace,
              context: context,
            );
            if (h > maxRowHeight) maxRowHeight = h;
          }

          final List<Widget> rowChildren = [];
          for (int i = 0; i < crossAxisCount; i++) {
            if (i > 0) {
              rowChildren.add(const SizedBox(width: 10));
            }
            if (i < rowItems.length) {
              rowChildren.add(Expanded(child: _buildCard(rowItems[i], isPlace)));
            } else {
              rowChildren.add(const Expanded(child: SizedBox.shrink()));
            }
          }

          return Padding(
            padding: EdgeInsets.only(bottom: rowIndex == rowCount - 1 ? 0 : 12),
            child: SizedBox(
              height: maxRowHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rowChildren,
              ),
            ),
          );
        }),
      );
    },
  );
}

Widget _buildCard(SavedPlaceModel place, bool isPlace) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF0DDC3),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE1D2BD).withAlpha(120), width: 1),
    ),
    padding: const EdgeInsets.fromLTRB(6, 7, 6, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: AspectRatio(
            aspectRatio: 1.35,
            child: Container(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                place.destinationName,
                softWrap: true,
                maxLines: null,
                style: GoogleFonts.inter(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF17452F),
                  height: 1.25,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 1.0, top: 1.0),
              child: Icon(
                Icons.more_horiz_rounded,
                size: 15,
                color: Color(0xFF5F625D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Spacer(),
        if (isPlace)
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 11,
                color: Color(0xFF5F625D),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  place.location.isNotEmpty ? place.location : 'Sri Lanka',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: const Color(0xFF5F625D),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: Color(0xFF5F625D),
              ),
            ],
          )
        else
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.chevron_right_rounded,
              size: 14,
              color: Color(0xFF5F625D),
            ),
          ),
      ],
    ),
  );
}

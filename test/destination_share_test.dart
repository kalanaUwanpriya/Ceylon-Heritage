import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/data/historical_places_data.dart';
import 'package:ceylon_heritage/destinations/destination_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final destinationsToTest = [
    (anuradhapura, 'https://ceylonheritage.app/destination/anuradhapura'),
    (polonnaruwa, 'https://ceylonheritage.app/destination/polonnaruwa'),
    (jaffna, 'https://ceylonheritage.app/destination/jaffna'),
    (downSouth, 'https://ceylonheritage.app/destination/down-south'),
    (kandy, 'https://ceylonheritage.app/destination/kandy'),
    (dambulla, 'https://ceylonheritage.app/destination/dambulla'),
  ];

  for (final (dest, expectedUrl) in destinationsToTest) {
    testWidgets('DestinationPage (${dest.name}): Share icon shows bottom sheet with only Copy Destination Link option', (tester) async {
      String? copiedString;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (MethodCall methodCall) async {
        if (methodCall.method == 'Clipboard.setData') {
          final Map<dynamic, dynamic>? args = methodCall.arguments as Map<dynamic, dynamic>?;
          copiedString = args?['text'] as String?;
          return null;
        }
        return null;
      });

      await tester.pumpWidget(
        MaterialApp(
          home: DestinationPage(destination: dest),
        ),
      );
      await tester.pump();

      // Top-right share icon exists
      final shareIconFinder = find.byIcon(Icons.share_outlined);
      expect(shareIconFinder, findsOneWidget);

      // Tap the share icon
      await tester.tap(shareIconFinder);
      await tester.pumpAndSettle();

      // Verify bottom sheet appears with ONLY ONE option: "Copy Destination Link"
      expect(find.text('Copy Destination Link'), findsOneWidget);
      expect(find.text('Share Destination'), findsNothing);

      // Tap "Copy Destination Link"
      await tester.tap(find.text('Copy Destination Link'));
      await tester.pumpAndSettle();

      // Verify copied URL is correct
      expect(copiedString, equals(expectedUrl));

      // Verify confirmation SnackBar
      expect(find.text('Destination link copied!'), findsOneWidget);
    });
  }
}

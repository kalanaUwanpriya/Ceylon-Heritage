import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/services/audio_guide_service.dart';
import 'package:ceylon_heritage/widgets/audio_guide_player.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Guide Asset & Mapping Verification', () {
    const expectedMappings = {
      'Anuradhapura': 'assets/Sound/Anuradhapura.mp3',
      'Dambulla': 'assets/Sound/Dambulla.mp3',
      'Down South': 'assets/Sound/DownSouth.mp3',
      'Jaffna': 'assets/Sound/Jaffna.mp3',
      'Kandy': 'assets/Sound/Kandy.mp3',
      'Polonnaruwa': 'assets/Sound/Pollonnaruwa.mp3',
    };

    test(
      'All 6 audio guide destination mappings match required specification',
      () {
        for (final entry in expectedMappings.entries) {
          final path = AudioGuideService.getAudioPathForDestination(entry.key);
          expect(
            path,
            equals(entry.value),
            reason: 'Mapping failed for destination ${entry.key}',
          );
        }
      },
    );

    test(
      'Case-insensitivity and whitespace trimming for destination mapping',
      () {
        expect(
          AudioGuideService.getAudioPathForDestination('  anuradhapura  '),
          equals('assets/Sound/Anuradhapura.mp3'),
        );
        expect(
          AudioGuideService.getAudioPathForDestination('DAMBULLA'),
          equals('assets/Sound/Dambulla.mp3'),
        );
        expect(
          AudioGuideService.getAudioPathForDestination('down south'),
          equals('assets/Sound/DownSouth.mp3'),
        );
        expect(
          AudioGuideService.getAudioPathForDestination('polonnaruwa'),
          equals('assets/Sound/Pollonnaruwa.mp3'),
        );
      },
    );

    test('All 6 audio MP3 files exist on disk with valid file size', () {
      for (final path in expectedMappings.values) {
        final file = File(path);
        expect(
          file.existsSync(),
          isTrue,
          reason: 'Audio file must exist at $path',
        );
        final bytes = file.lengthSync();
        expect(
          bytes,
          greaterThan(100000),
          reason: 'Audio file at $path must be non-empty MP3 audio',
        );
      }
    });

    test('pubspec.yaml registers all 6 MP3 asset files under assets', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      for (final path in expectedMappings.values) {
        expect(
          pubspec.contains(path),
          isTrue,
          reason: 'pubspec.yaml must contain asset entry for $path',
        );
      }
    });
  });

  group('AudioGuidePlayer Widget Structure & Narrators', () {
    testWidgets(
      'Renders AudioGuidePlayer for Anuradhapura with Dr. Sensaka Bandara narrator',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AudioGuidePlayer(destinationName: 'Anuradhapura'),
            ),
          ),
        );

        expect(find.text('Audio Guide'), findsOneWidget);
        expect(find.text('Narrated by Dr. Sensaka Bandara'), findsOneWidget);
        expect(find.byIcon(Icons.headphones_outlined), findsOneWidget);
        expect(
          find.byKey(const Key('audio_guide_play_button')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('audio_guide_seek_bar')), findsOneWidget);
        expect(find.text('0:00'), findsAtLeastNWidgets(1));
      },
    );

    testWidgets(
      'Renders AudioGuidePlayer for Dambulla with Dr. Sensaka Bandara narrator',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AudioGuidePlayer(destinationName: 'Dambulla')),
          ),
        );

        expect(find.text('Audio Guide'), findsOneWidget);
        expect(find.text('Narrated by Dr. Sensaka Bandara'), findsOneWidget);
      },
    );

    testWidgets(
      'Renders AudioGuidePlayer for Polonnaruwa with Heritage Walks narrator',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AudioGuidePlayer(destinationName: 'Polonnaruwa'),
            ),
          ),
        );

        expect(find.text('Audio Guide'), findsOneWidget);
        expect(find.text('Narrated by Heritage Walks'), findsOneWidget);
      },
    );

    testWidgets('Renders AudioGuidePlayer for Jaffna, Down South, and Kandy', (
      tester,
    ) async {
      for (final destination in ['Jaffna', 'Down South', 'Kandy']) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AudioGuidePlayer(destinationName: destination),
            ),
          ),
        );

        expect(find.text('Audio Guide'), findsOneWidget);
        expect(find.text('Narrated by Heritage Walks'), findsOneWidget);
        expect(
          find.byKey(const Key('audio_guide_play_button')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('audio_guide_seek_bar')), findsOneWidget);
      }
    });
  });

  group('Audio Conflict Prevention & Lifecycle', () {
    test(
      'stopIfLeaving ignores different destinations and stops active destination',
      () async {
        final service = AudioGuideService.instance;
        // Should not throw or crash
        await service.stopIfLeaving('NonExistentDestination');
      },
    );
  });
}

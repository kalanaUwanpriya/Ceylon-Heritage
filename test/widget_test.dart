import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/main.dart';
import 'package:ceylon_heritage/screens/splash_screen.dart';

void main() {
  testWidgets('App root launches SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const CeylonHeritageApp());
    expect(find.byType(SplashScreen), findsOneWidget);
    // Advance past splash screen timer to cleanly finish test
    await tester.pump(const Duration(seconds: 4));
  });
}

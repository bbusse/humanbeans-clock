import 'package:humanbeans_clock/LoadingScreen.dart';
import 'package:humanbeans_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows the loading screen until the textures are decoded', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await tester.pumpWidget(const MyApp());

    // The texture images are decoded asynchronously; the first frame is the
    // loading screen and the current time is exposed to screen readers.
    expect(find.byType(LoadingScreen), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'^Current time: ')), findsOneWidget);

    // Tear the clock down so its timers and tickers are disposed before the
    // test ends.
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('schedules the first bird visit for the next day', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await tester.pumpWidget(const MyApp());
    // Let the persisted-time lookup complete.
    await tester.pump();

    final prefs = await SharedPreferences.getInstance();
    final int? birdTimeMillis = prefs.getInt('birdTime');
    expect(birdTimeMillis, isNotNull);

    final birdTime = DateTime.fromMillisecondsSinceEpoch(birdTimeMillis!);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    expect(birdTime.isBefore(tomorrow), isFalse);
    expect(birdTime.isBefore(tomorrow.add(const Duration(days: 1))), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}

import 'package:flutter/material.dart';
import 'package:animated_text_kit/src/typewriter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TypewriterAnimatedTextKit', () {
    testWidgets('requires a list of strings', (WidgetTester tester) async {
      expect(() => TypewriterAnimatedTextKit(), throwsAssertionError);
      expect(
          () => TypewriterAnimatedTextKit(
                text: null,
              ),
          throwsAssertionError);
    });

    testWidgets('animation works', (WidgetTester tester) async {
      await tester.pumpWidget(createMaterialApp(TypewriterAnimatedTextKit(
        text: [
          "Discipline is the best tool",
          "Design first, then code",
        ],
        textStyle: TextStyle(fontSize: 40.0, fontFamily: "Lobster"),
        textAlign: TextAlign.start,
        alignment: AlignmentDirectional.topStart,
        speed: Duration(milliseconds: 200),
        pause: Duration(milliseconds: 1500),
      )));
      expect(find.byType(GestureDetector), findsOneWidget);
      tester.verifyTickersWereDisposed();
    });

    testWidgets('checks pause and speed values', (WidgetTester tester) async {
      TypewriterAnimatedTextKit typewriterAnimatedTextKit =
          TypewriterAnimatedTextKit(
        text: [
          "Discipline is the best tool",
          "Design first, then code",
        ],
        textStyle: TextStyle(fontSize: 40.0, fontFamily: "Lobster"),
        textAlign: TextAlign.start,
        alignment: AlignmentDirectional.topStart,
        speed: Duration(milliseconds: 200),
        pause: Duration(milliseconds: 1500),
      );
      await tester.pumpWidget(createMaterialApp(typewriterAnimatedTextKit));
      expect(typewriterAnimatedTextKit.speed, Duration(milliseconds: 200));
      expect(typewriterAnimatedTextKit.pause, Duration(milliseconds: 1500));
      tester.verifyTickersWereDisposed();
    });

    testWidgets('check Text Widget', (WidgetTester tester) async {
      await tester.pumpWidget(createMaterialApp(TypewriterAnimatedTextKit(
        text: ["Hello", "World"],
        textAlign: TextAlign.center,
      )));
      expect(find.byType(Text), findsOneWidget);
      tester.verifyTickersWereDisposed();
    });

    testWidgets('check AnimatedBuilder Widget', (WidgetTester tester) async {
      await tester.pumpWidget(createMaterialApp(TypewriterAnimatedTextKit(
        text: ["Hello", "World"],
        alignment: Alignment.topLeft,
      )));
      expect(find.byType(Text), findsWidgets);
      tester.verifyTickersWereDisposed();
    });
  });
}

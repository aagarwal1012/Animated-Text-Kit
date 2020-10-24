import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: avoid_relative_lib_imports
import '../example/lib/main.dart';

void main() {
  testWidgets('Animation smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Exercise each Animation...
    for (var label in labels) {
      print('Testing $label');
      expect(find.text(label), findsOneWidget);
      final pumpCount = await tester.pumpAndSettle();
      print(' > $label pumped $pumpCount');

      await tester.tap(find.byIcon(Icons.play_circle_filled));
      await tester.pump();
    }

    tester.verifyTickersWereDisposed();
  });

  testWidgets('Animation tap test', (WidgetTester tester) async {
    const tripleText = [
      'Alpha',
      'Beta',
      'Omega',
    ];
    const textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);

    final tapableWidgets = <Widget>[
      ColorizeAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
        ],
        onTap: () {
          print(' > ColorizeAnimatedTextKit was tapped');
        },
      ),
      FadeAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          print(' > FadeAnimatedTextKit was tapped');
        },
      ),
      RotateAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          print(' > RotateAnimatedTextKit was tapped');
        },
      ),
      ScaleAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          print(' > ScaleAnimatedTextKit was tapped');
        },
      ),
      TyperAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          print(' > TyperAnimatedTextKit was tapped');
        },
      ),
      TypewriterAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          print(' > TypewriterAnimatedTextKit was tapped');
        },
      ),
    ];

    for (var widget in tapableWidgets) {
      print('Testing ${widget.runtimeType}');

      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.tap(find.byWidget(widget));
      await tester.pumpAndSettle();
    }

    tester.verifyTickersWereDisposed();
  });
}

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
    final examples = animatedTextExamples();
    for (var example in examples) {
      print('Testing ${example.label}');
      expect(find.text(example.label), findsOneWidget);
      final pumpCount = await tester.pumpAndSettle();
      print(' > ${example.label} pumped $pumpCount');

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

    var tapped = false;

    final tapableWidgets = <Widget>[
      // ignore: deprecated_member_use_from_same_package
      ColorizeAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
        ],
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      FadeAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      RotateAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      ScaleAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      TyperAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      TypewriterAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      WavyAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
      // ignore: deprecated_member_use_from_same_package
      FlickerAnimatedTextKit(
        text: tripleText,
        textStyle: textStyle,
        displayFullTextOnTap: true,
        onTap: () {
          tapped = true;
        },
      ),
    ];

    for (var widget in tapableWidgets) {
      print('Tap Testing ${widget.runtimeType}');
      tapped = false;
      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.tap(find.byWidget(widget));
      assert(tapped);
    }

    tester.verifyTickersWereDisposed();
  });
}

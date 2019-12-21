import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/lib/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  testWidgets('Check button smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    expect(find.text(labels[0]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();

    expect(find.text(labels[1]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();

    expect(find.text(labels[2]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();

    expect(find.text(labels[3]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();

    expect(find.text(labels[4]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();

    expect(find.text(labels[5]), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_circle_filled));
    await tester.pump();
  });

  group('TypewriterAnimatedTextKit', () {
    test('default value for totalRepeatCount', () {
      TypewriterAnimatedTextKit typewriter = TypewriterAnimatedTextKit(
        onTap: () {
          print("Tap Event");
        },
        text: [
          "Discipline is the best tool",
          "Design first, then code",
          "Do not patch bugs out, rewrite them",
          "Do not test bugs out, design them out",
        ],
        textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
      );

      expect(typewriter.totalRepeatCount, 3);
      expect(typewriter.isRepeatingAnimation, true);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/lib/main.dart';

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
}

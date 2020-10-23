import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/lib/main.dart';

void main() {
  testWidgets('Check button smoke test', (WidgetTester tester) async {
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
}

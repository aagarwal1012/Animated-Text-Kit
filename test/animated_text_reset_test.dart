import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'reset during the inter-animation pause cancels the pending advance',
    (WidgetTester tester) async {
      final controller = AnimatedTextController();
      addTearDown(controller.dispose);
      var nextCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                'synthetic first',
                duration: const Duration(milliseconds: 100),
              ),
              FadeAnimatedText(
                'synthetic second',
                duration: const Duration(milliseconds: 100),
              ),
            ],
            controller: controller,
            pause: const Duration(milliseconds: 1000),
            isRepeatingAnimation: false,
            onNext: (_, __) => nextCalls++,
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));
      expect(controller.state, AnimatedTextState.pausedBetweenAnimations);

      await tester.pump(const Duration(milliseconds: 100));
      controller.reset();
      await tester.pump();
      expect(controller.state, AnimatedTextState.playing);

      await tester.pump(const Duration(milliseconds: 100));
      expect(controller.state, AnimatedTextState.pausedBetweenAnimations);
      expect(nextCalls, 0);

      // The original pause timer would fire here if reset had not cancelled it.
      await tester.pump(const Duration(milliseconds: 800));
      expect(nextCalls, 0);

      await tester.pump(const Duration(milliseconds: 200));
      expect(nextCalls, 1);

      await tester.pumpWidget(const SizedBox.shrink());
      tester.verifyTickersWereDisposed();
    },
  );
}

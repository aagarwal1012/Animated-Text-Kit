import 'package:flutter_test/flutter_test.dart';
import 'package:animated_text_kit/src/animated_text_controller.dart';

void main() {
  late AnimatedTextController controller;

  setUp(() {
    controller = AnimatedTextController();
  });

  tearDown(() {
    controller.dispose();
  });

  test('Initial state should be playing', () {
    expect(controller.state, AnimatedTextState.playing);
  });

  test('Calling pause when playing should set state to userPaused', () {
    controller.pause();
    expect(controller.state, AnimatedTextState.pausedByUser);
  });

  test('Calling play after paused should set state to playing', () {
    controller.pause(); // userPaused
    controller.play();
    expect(controller.state, AnimatedTextState.playing);
  });

  test(
      'Pausing during pausingBetweenAnimations should set state to pausingBetweenAnimationsWithUserPauseRequested',
      () {
    // Directly set state to pausingBetweenAnimations to simulate this scenario.
    controller.state = AnimatedTextState.pausedBetweenAnimations;
    controller.pause();
    expect(controller.state, AnimatedTextState.pausedBetweenAnimationsByUser);
  });

  test(
      'Calling play when in pausingBetweenAnimationsWithUserPauseRequested should revert to pausingBetweenAnimations',
      () {
    controller.state = AnimatedTextState.pausedBetweenAnimationsByUser;
    controller.play();
    expect(controller.state, AnimatedTextState.pausedBetweenAnimations);
  });

  test('Resetting should set state to reset', () {
    controller.reset();
    expect(controller.state, AnimatedTextState.reset);
  });

  test('Changing state directly via setter works', () {
    controller.state = AnimatedTextState.pausedByUser;
    expect(controller.state, AnimatedTextState.pausedByUser);
  });
}

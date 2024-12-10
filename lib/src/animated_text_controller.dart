import 'package:flutter/material.dart';

enum AnimatedTextState {
  playing,
  paused,
  pausingBetweenAnimations,
  stopped,
  reset,
}

//TODO: fix bug where the animation is not paused, when state is pausingBetweenAnimations
class AnimatedTextController {
  final ValueNotifier<AnimatedTextState> stateNotifier =
      ValueNotifier<AnimatedTextState>(AnimatedTextState.stopped);

  AnimatedTextState get state => stateNotifier.value;

  set state(AnimatedTextState state) {
    stateNotifier.value = state;
  }

  void dispose() {
    stateNotifier.dispose();
  }

  void play() {
    stateNotifier.value = AnimatedTextState.playing;
  }

  void pause() {
    stateNotifier.value = AnimatedTextState.paused;
  }

  void reset() {
    stateNotifier.value = AnimatedTextState.reset;
  }
}

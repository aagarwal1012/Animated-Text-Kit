import 'package:flutter/material.dart';

/// The various states that the animated text can be in:
///
/// * [playing]: The animation is currently running.
/// * [userPaused]: The animation is paused due to a user action.
/// * [pausingBetweenAnimations]: The animation has completed one segment and is
///   currently in the built-in pause period before the next segment starts.
/// * [pausingBetweenAnimationsWithUserPauseRequested]: The user requested a pause
///   during the pause between animations, so once this pause period ends,
///   the animation should remain paused.
/// * [stopped]: The animation is stopped and will not progress further.
/// * [reset]: The animation should reset to its initial state.
enum AnimatedTextState {
  playing,
  pausedByUser,
  pausedBetweenAnimations,
  pausedBetweenAnimationsByUser,
  stopped,
  reset,
}

/// A controller for managing the state of an animated text sequence.
///
/// This controller exposes methods to play, pause, and reset the animation.
/// The [AnimatedTextState] enum represents the various states the animation
/// can be in. By calling [play()], [pause()], or [reset()], you can transition
/// between these states and the animated widget will react accordingly.
class AnimatedTextController {
  /// A [ValueNotifier] that holds the current state of the animation.
  /// Listeners can be attached to react when the state changes.
  final ValueNotifier<AnimatedTextState> stateNotifier =
      ValueNotifier<AnimatedTextState>(AnimatedTextState.playing);

  /// Returns the current state of the animation.
  AnimatedTextState get state => stateNotifier.value;

  /// Sets the current state of the animation.
  set state(AnimatedTextState state) {
    stateNotifier.value = state;
  }

  /// Disposes of the [ValueNotifier]. This should be called when the
  /// [AnimatedTextController] is no longer needed.
  void dispose() {
    stateNotifier.dispose();
  }

  /// Transitions the animation into the [playing] state, unless the controller is
  /// currently in the [pausingBetweenAnimationsWithUserPauseRequested] state,
  /// in which case it returns to the [pausingBetweenAnimations] state.
  ///
  /// Call this to resume the animation if it was previously paused.
  void play() {
    if (stateNotifier.value ==
        AnimatedTextState.pausedBetweenAnimationsByUser) {
      stateNotifier.value = AnimatedTextState.pausedBetweenAnimations;
    } else {
      stateNotifier.value = AnimatedTextState.playing;
    }
  }

  /// Pauses the animation. If the animation is currently in the [pausingBetweenAnimations]
  /// state, it moves to [pausingBetweenAnimationsWithUserPauseRequested], indicating
  /// that once the internal pause finishes, the animation should remain paused.
  /// Otherwise, it transitions directly into the [userPaused] state.
  ///
  /// Call this to pause the animation due to user interaction.
  void pause() {
    if (stateNotifier.value == AnimatedTextState.pausedBetweenAnimations) {
      stateNotifier.value = AnimatedTextState.pausedBetweenAnimationsByUser;
    } else {
      stateNotifier.value = AnimatedTextState.pausedByUser;
    }
  }

  /// Resets the animation to its initial state by setting the state to [reset].
  /// This typically means the animated text should return to the start of its
  /// animation in this cycle and be ready to begin again.
  void reset() {
    stateNotifier.value = AnimatedTextState.reset;
  }
}

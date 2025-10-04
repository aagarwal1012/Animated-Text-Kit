import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/src/animated_text_controller.dart';
import 'package:flutter/material.dart';

/// Abstract base class for text animations.
abstract class AnimatedText {
  /// Text for [Text] widget.
  final String text;

  /// [TextAlign] property for [Text] widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// [TextStyle] property for [Text] widget.
  final TextStyle? textStyle;

  /// The Duration for the Animation Controller.
  ///
  /// This will set the total duration for the animated widget.
  /// For example, if you want the text animation to take 3 seconds,
  /// then you have to set [duration] to 3 seconds.
  final Duration duration;

  /// Same as [text] but as [Characters].
  ///
  /// Need to use character length, not String length, to propertly support
  /// Unicode and Emojis.
  final Characters textCharacters;

  AnimatedText({
    required this.text,
    this.textAlign = TextAlign.start,
    this.textStyle,
    required this.duration,
  }) : textCharacters = text.characters;

  /// Return the remaining Duration for the Animation (when applicable).
  Duration? get remaining => null;

  /// Initialize the Animation.
  void initAnimation(AnimationController controller);

  /// Utility method to create a styled [Text] widget using the [textAlign] and
  /// [textStyle], but you can specify the [data].
  Widget textWidget(String data) => Text(
        data,
        textAlign: textAlign,
        style: textStyle,
      );

  /// Widget showing the complete text (when animation is complete or paused).
  /// By default, it shows a Text widget, but this may be overridden.
  Widget completeText(BuildContext context) => textWidget(text);

  /// Widget showing animated text, based on animation value(s).
  Widget animatedBuilder(BuildContext context, Widget? child);
}

/// Base class for Animated Text widgets.
class AnimatedTextKit extends StatefulWidget {
  /// List of [AnimatedText] to display subsequently in the animation.
  final List<AnimatedText> animatedTexts;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 1000 milliseconds.
  final Duration pause;

  /// Should the animation ends up early and display full text if you tap on it?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  /// If on pause, should a tap remove the remaining pause time ?
  ///
  /// By default it is set to false.
  final bool stopPauseOnTap;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback? onTap;

  /// Adds the onFinished [VoidCallback] to the animated widget.
  ///
  /// This method will run only if [isRepeatingAnimation] is set to false.
  final VoidCallback? onFinished;

  /// Adds the onNext callback to the animated widget.
  ///
  /// Will be called right before the next text, after the pause parameter
  final void Function(int, bool)? onNext;

  /// Adds the onNextBeforePause callback to the animated widget.
  ///
  /// Will be called at the end of n-1 animation, before the pause parameter
  final void Function(int, bool)? onNextBeforePause;

  /// Set if the animation should not repeat by changing the value of it to false.
  ///
  /// By default it is set to true.
  final bool isRepeatingAnimation;

  /// Sets if the animation should repeat forever. [isRepeatingAnimation] also
  /// needs to be set to true if you want to repeat forever.
  ///
  /// By default it is set to false, if set to true, [totalRepeatCount] is ignored.
  final bool repeatForever;

  /// Sets the number of times animation should repeat
  ///
  /// By default it is set to 3
  final int totalRepeatCount;

  /// A controller for managing the state of an animated text sequence.
  ///
  /// This controller exposes methods to play, pause, and reset the animation.
  /// The [AnimatedTextState] enum represents the various states the animation
  /// can be in. By calling [play()], [pause()], or [reset()], you can transition
  /// between these states and the animated widget will react accordingly.
  final AnimatedTextController? controller;

  const AnimatedTextKit({
    Key? key,
    required this.animatedTexts,
    this.pause = const Duration(milliseconds: 1000),
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.onFinished,
    this.controller,
    this.isRepeatingAnimation = true,
    this.totalRepeatCount = 3,
    this.repeatForever = false,
  })  : assert(animatedTexts.length > 0),
        assert(!isRepeatingAnimation || totalRepeatCount > 0 || repeatForever),
        assert(null == onFinished || !repeatForever),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  AnimatedTextKitState createState() => AnimatedTextKitState();
}

class AnimatedTextKitState extends State<AnimatedTextKit>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late AnimatedText _currentAnimatedText;

  late AnimatedTextController _animatedTextController;

  int _currentRepeatCount = 0;

  int _index = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animatedTextController = widget.controller ?? AnimatedTextController();
    _animatedTextController.stateNotifier.addListener(_stateChangedCallback);
    _initAnimation();
  }

  void _stateChangedCallback() {
    if (!mounted) return;
    if (_animatedTextController.state == AnimatedTextState.playing &&
        !_controller.isAnimating) {
      _controller.forward();
    } else if (_animatedTextController.state ==
        AnimatedTextState.pausedByUser) {
      _controller.stop();
    } else if (_animatedTextController.state == AnimatedTextState.reset) {
      _controller.reset();
      _animatedTextController.state = AnimatedTextState.playing;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _animatedTextController.stateNotifier.removeListener(_stateChangedCallback);
    // Only dispose the controller if it was created by this widget
    if (widget.controller == null) _animatedTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completeText = _currentAnimatedText.completeText(context);
    return Semantics(
      label: _currentAnimatedText.text,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: _animatedTextController.state ==
                    AnimatedTextState.pausedBetweenAnimations ||
                !_controller.isAnimating
            ? completeText
            : AnimatedBuilder(
                animation: _controller,
                builder: _currentAnimatedText.animatedBuilder,
                child: completeText,
              ),
      ),
    );
  }

  bool get _isLast => _index == widget.animatedTexts.length - 1;

  void _nextAnimation() {
    final isLast = _isLast;

    // Handling onNext callback
    widget.onNext?.call(_index, isLast);

    if (isLast) {
      if (widget.isRepeatingAnimation &&
          (widget.repeatForever ||
              _currentRepeatCount != (widget.totalRepeatCount - 1))) {
        _index = 0;
        if (!widget.repeatForever) {
          _currentRepeatCount++;
        }
      } else {
        widget.onFinished?.call();
        return;
      }
    } else {
      _index++;
    }

    if (mounted) setState(() {});

    _controller.dispose();

    // Re-initialize animation
    _initAnimation();
  }

  void _initAnimation() {
    _currentAnimatedText = widget.animatedTexts[_index];

    _controller = AnimationController(
      duration: _currentAnimatedText.duration,
      vsync: this,
      animationBehavior: AnimationBehavior.preserve);

    _currentAnimatedText.initAnimation(_controller);

    _controller.addStatusListener(_animationEndCallback);

    if (_animatedTextController.state ==
        AnimatedTextState.pausedBetweenAnimationsByUser) {
      // This post frame callback is needed to ensure that the state is set and the widget is built
      // before we pause the animation. otherwise nothing will be shown during the animation cycle
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedTextController.state = AnimatedTextState.pausedByUser;
      });
    }
    _animatedTextController.state = AnimatedTextState.playing;
    _controller.forward();
  }

  void _setPauseBetweenAnimations() {
    final isLast = _isLast;

    _animatedTextController.state = AnimatedTextState.pausedBetweenAnimations;

    if (mounted) setState(() {});

    // Handle onNextBeforePause callback
    widget.onNextBeforePause?.call(_index, isLast);
  }

  void _animationEndCallback(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _setPauseBetweenAnimations();
      assert(null == _timer || !_timer!.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      if (_animatedTextController.state ==
          AnimatedTextState.pausedBetweenAnimations) {
        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        final left =
            (_currentAnimatedText.remaining ?? _currentAnimatedText.duration)
                .inMilliseconds;

        _controller.stop();

        _setPauseBetweenAnimations();

        assert(null == _timer || !_timer!.isActive);
        _timer = Timer(
          Duration(
            milliseconds: max(
              widget.pause.inMilliseconds,
              left,
            ),
          ),
          _nextAnimation,
        );
      }
    }

    widget.onTap?.call();
  }
}

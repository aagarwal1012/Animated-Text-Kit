import 'dart:async';
import 'dart:math';
import 'package:characters/characters.dart';
import 'package:flutter/material.dart';

/// Animation that displays [text] elements, as if they are being typed one
/// character at a time.
///
/// ![typer example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typer.gif)
class TyperAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 1000 milliseconds.
  final Duration pause;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback onTap;

  /// Adds the onFinished [VoidCallback] to the animated widget.
  ///
  /// This method will run only if [isRepeatingAnimation] is set to false.
  final VoidCallback onFinished;

  /// Adds the onNext [VoidCallback] to the animated widget.
  ///
  /// Will be called right before the next text, after the pause parameter
  final void Function(int, bool) onNext;

  /// Adds the onNextBeforePause [VoidCallback] to the animated widget.
  ///
  /// Will be called at the end of n-1 animation, before the pause parameter
  final void Function(int, bool) onNextBeforePause;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [AlignmentDirectional.topStart]
  final AlignmentGeometry alignment;

  /// Adds [TextAlign] property to the text in the widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// Set if the animation should not repeat by changing the value of it to false.
  ///
  /// By default it is set to true.
  final bool isRepeatingAnimation;

  /// Should the animation ends up early and display full text if you tap on it ?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  /// If on pause, should a tap remove the remaining pause time ?
  ///
  /// By default it is set to false.
  final bool stopPauseOnTap;

  const TyperAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.onFinished,
    this.alignment = AlignmentDirectional.topStart,
    this.textAlign = TextAlign.start,
    this.isRepeatingAnimation = true,
    this.speed = const Duration(milliseconds: 40),
    this.pause = const Duration(milliseconds: 1000),
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
  })  : assert(null != text),
        assert(null != alignment),
        assert(null != textAlign),
        assert(null != isRepeatingAnimation),
        assert(null != speed),
        assert(null != pause),
        assert(null != displayFullTextOnTap),
        assert(null != stopPauseOnTap),
        super(key: key);

  @override
  _TyperState createState() => _TyperState();
}

class _TyperState extends State<TyperAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _typingText;

  int _index;

  final _textCharacters = <Characters>[];

  bool _isCurrentlyPausing = false;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _index = -1;

    widget.text.forEach((text) {
      _textCharacters.add(text.characters);
    });

    // Start animation
    _nextAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text[_index];
    return GestureDetector(
      onTap: _onTap,
      child: _isCurrentlyPausing || !_controller.isAnimating
          ? Text(
              text,
              style: widget.textStyle,
              textAlign: widget.textAlign,
            )
          : AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                final textCharacters = _textCharacters[_index];
                final textLen = textCharacters.length;
                final offset =
                    textLen < _typingText.value ? textLen : _typingText.value;

                return Text(
                  textCharacters.take(offset).toString(),
                  style: widget.textStyle,
                  textAlign: widget.textAlign,
                );
              },
            ),
    );
  }

  void _nextAnimation() {
    final isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = false;

    // Handling onNext callback
    if (_index > -1) {
      widget.onNext?.call(_index, isLast);
    }

    if (isLast) {
      if (widget.isRepeatingAnimation) {
        _index = 0;
      } else {
        widget.onFinished?.call();
        return;
      }
    } else {
      _index++;
    }

    if (mounted) setState(() {});

    final textLen = _textCharacters[_index].length;
    _controller = AnimationController(
      duration: widget.speed * textLen,
      vsync: this,
    );

    _typingText = StepTween(begin: 0, end: textLen).animate(_controller)
      ..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _setPause() {
    final isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});

    // Handle onNextBeforePause callback
    widget.onNextBeforePause?.call(_index, isLast);
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      assert(null == _timer || !_timer.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        final left = widget.speed.inMilliseconds *
            (_textCharacters[_index].length - _typingText.value);

        _controller.stop();

        _setPause();

        assert(null == _timer || !_timer.isActive);
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

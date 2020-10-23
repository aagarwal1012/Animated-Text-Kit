import 'dart:async';
import 'dart:math';
import 'package:characters/characters.dart';
import 'package:flutter/material.dart';

class TypewriterAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the delay between the apparition of each characters.
  ///
  /// By default it is set to 30 milliseconds
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

  /// Sets the number of times animation should repeat
  ///
  /// By default it is set to 3
  final int totalRepeatCount;

  /// Sets if the animation should repeat forever. [isRepeatingAnimation] also
  /// needs to be set to true if you want to repeat forever.
  ///
  /// By default it is set to false, if set to true, [totalRepeatCount] is ignored.
  final bool repeatForever;

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

  TypewriterAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.speed = const Duration(milliseconds: 30),
    this.pause = const Duration(milliseconds: 1000),
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.onFinished,
    this.totalRepeatCount = 3,
    this.alignment = AlignmentDirectional.topStart,
    this.textAlign = TextAlign.start,
    this.repeatForever = false,
    this.isRepeatingAnimation = true,
  })  : assert(text != null, 'You must specify the list of text'),
        assert(null != speed),
        assert(null != pause),
        assert(null != displayFullTextOnTap),
        assert(null != stopPauseOnTap),
        assert(null != totalRepeatCount),
        assert(null != alignment),
        assert(null != textAlign),
        assert(null != repeatForever),
        assert(null != isRepeatingAnimation),
        super(key: key);

  @override
  _TypewriterState createState() => _TypewriterState();
}

class _TypewriterState extends State<TypewriterAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<int> _typewriterText;

  int _index;

  final _textCharacters = <Characters>[];

  bool _isCurrentlyPausing = false;

  Timer _timer;

  int _currentRepeatCount;

  @override
  void initState() {
    super.initState();

    _index = -1;

    _currentRepeatCount = 0;

    widget.text.forEach((text) {
      _textCharacters.add(text.characters);
    });

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
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: text),
                  TextSpan(
                    text: '_',
                    style: widget.textStyle.copyWith(color: Colors.transparent),
                  )
                ],
                style: widget.textStyle,
              ),
              textAlign: widget.textAlign,
            )
          : AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                final textCharacters = _textCharacters[_index];
                final textLen = textCharacters.length;
                var visibleString = text;
                var suffixColor = Colors.transparent;
                if (_typewriterText.value == 0) {
                  visibleString = '';
                } else if (_typewriterText.value > textLen) {
                  visibleString = text;
                  suffixColor = (_typewriterText.value - textLen) % 2 == 0
                      ? widget.textStyle.color
                      : Colors.transparent;
                } else {
                  visibleString =
                      textCharacters.take(_typewriterText.value).toString();
                  suffixColor = widget.textStyle.color;
                }

                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: visibleString),
                      TextSpan(
                        text: '_',
                        style: widget.textStyle.copyWith(color: suffixColor),
                      )
                    ],
                    style: widget.textStyle,
                  ),
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

    final textLen = _textCharacters[_index].length;
    _controller = AnimationController(
      duration: widget.speed * textLen,
      vsync: this,
    );

    _typewriterText = StepTween(
      begin: 0,
      end: textLen + 8,
    ).animate(_controller)
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
            (_textCharacters[_index].length - _typewriterText.value);

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

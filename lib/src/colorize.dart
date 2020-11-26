import 'package:flutter/material.dart';
import 'dart:async';

/// Animation that displays [text] elements, shimmering transition between [colors].
///
/// ![colorize example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/colorize.gif)
class ColorizeAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 30 milliseconds.
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

  /// Adds [TextAlign] property to the text in the widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

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
  final double totalRepeatCount;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  final List<Color> colors;

  const ColorizeAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    @required this.colors,
    this.speed = const Duration(milliseconds: 200),
    this.pause = const Duration(milliseconds: 1000),
    this.onTap,
    this.onNext,
    this.onFinished,
    this.textAlign = TextAlign.start,
    this.totalRepeatCount = 3,
    this.repeatForever = false,
    this.isRepeatingAnimation = true,
  })  : assert(null != text),
        assert(null != colors && colors.length > 1),
        assert(null != speed),
        assert(null != pause),
        assert(null != textAlign),
        assert(null != totalRepeatCount),
        assert(null != repeatForever),
        assert(null != isRepeatingAnimation),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  _ColorizeTextState createState() => _ColorizeTextState();
}

class _ColorizeTextState extends State<ColorizeAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Timer _timer;

  Animation<double> _colorShifter, _fadeIn, _fadeOut;

  int _index;

  final _textCharacters = <Characters>[];

  bool _isCurrentlyPausing = false;

  int _currentRepeatCount;

  @override
  void initState() {
    super.initState();

    _index = -1;

    widget.text.forEach((text) {
      _textCharacters.add(text.characters);
    });

    _currentRepeatCount = 0;

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
    return GestureDetector(
      onTap: widget.onTap,
      child: _isCurrentlyPausing || !_controller.isAnimating
          ? Text(
              widget.text[_index],
              style: widget.textStyle,
              textAlign: widget.textAlign,
            )
          : AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                final linearGradient =
                    LinearGradient(colors: widget.colors).createShader(
                  Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0),
                );
                return Opacity(
                  opacity:
                      _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
                  child: Text(
                    widget.text[_index],
                    style: widget.textStyle?.merge(
                      TextStyle(foreground: Paint()..shader = linearGradient),
                    ),
                    textAlign: widget.textAlign,
                  ),
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

    final tuning = (300.0 * widget.colors.length) *
        (widget.textStyle.fontSize / 24.0) *
        0.75 *
        (textLen / 15.0);

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.1, curve: Curves.easeOut),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeIn),
      ),
    );

    _colorShifter =
        Tween<double>(begin: 0.0, end: widget.colors.length * tuning).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    )..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _isCurrentlyPausing = true;
      assert(null == _timer || !_timer.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }
}

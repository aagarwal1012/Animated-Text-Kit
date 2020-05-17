import 'package:flutter/material.dart';
import 'dart:async';

class ColorizeAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 30 milliseconds.
  final Duration speed;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 500 milliseconds.
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
  final Function onNext;

  /// Adds the onNextBeforePause [VoidCallback] to the animated widget.
  ///
  /// Will be called at the end of n-1 animation, before the pause parameter
  final Function onNextBeforePause;

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

  /// Sets the number of times animation should repeat
  ///
  /// By default it is set to 3
  final double totalRepeatCount;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  final List<Color> colors;

  const ColorizeAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      @required this.colors,
      this.speed,
      this.pause,
      this.onTap,
      this.onNext,
      this.onNextBeforePause,
      this.onFinished,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.totalRepeatCount = 3,
      this.isRepeatingAnimation = true})
      : super(key: key);

  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<ColorizeAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation _colorShifter, _fadeIn, _fadeOut;
  double _tuning;

  Duration _speed;
  Duration _pause;

  List<Map> _texts = [];

  int _index;

  bool _isCurrentlyPausing = false;

  int _currentRepeatCount;

  @override
  void initState() {
    super.initState();

    _speed = widget.speed ?? Duration(milliseconds: 200);
    _pause = widget.pause ?? Duration(milliseconds: 1000);

    _index = -1;

    _currentRepeatCount = 0;

    for (int i = 0; i < widget.text.length; i++) {
      try {
        if (!widget.text[i].containsKey('text')) throw new Error();

        _texts.add({
          'text': widget.text[i]['text'],
          'speed': widget.text[i].containsKey('speed')
              ? widget.text[i]['speed']
              : _speed,
          'pause': widget.text[i].containsKey('pause')
              ? widget.text[i]['pause']
              : _pause,
        });
      } catch (e) {
        _texts.add({'text': widget.text[i], 'speed': _speed, 'pause': _pause});
      }
    }

    _nextAnimation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: _isCurrentlyPausing || !_controller.isAnimating
            ? Text(
                _texts[_index]['text'],
                style: widget.textStyle,
                textAlign: widget.textAlign,
              )
            : AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  Shader linearGradient = LinearGradient(colors: widget.colors)
                      .createShader(
                          Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0));
                  return Opacity(
                    opacity: !(_fadeIn.value == 1.0)
                        ? _fadeIn.value
                        : _fadeOut.value,
                    child: Text(
                      _texts[_index]['text'],
                      style: widget.textStyle != null
                          ? widget.textStyle.merge(TextStyle(
                              foreground: Paint()..shader = linearGradient))
                          : widget.textStyle,
                      textAlign: widget.textAlign,
                    ),
                  );
                },
              ));
  }

  void _nextAnimation() {
    bool isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = false;

    // Handling onNext callback
    if (_index > -1) {
      if (widget.onNext != null) widget.onNext(_index, isLast);
    }

    if (isLast) {
      if (widget.isRepeatingAnimation &&
          (_currentRepeatCount != (widget.totalRepeatCount - 1))) {
        _index = 0;
        _currentRepeatCount++;
      } else {
        if (widget.onFinished != null) widget.onFinished();
        return;
      }
    } else {
      _index++;
    }

    if (mounted) setState(() {});

    _controller = new AnimationController(
      duration: _texts[_index]['speed'] * _texts[_index]['text'].length,
      vsync: this,
    );

    _tuning = (300.0 * widget.colors.length) *
        (widget.textStyle.fontSize / 24.0) *
        0.75 *
        (_texts[_index]['text'].length / 15.0);

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.easeOut)));

    _fadeOut = Tween<double>(begin: 1.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.easeIn)));

    _colorShifter =
        Tween<double>(begin: 0.0, end: widget.colors.length * _tuning).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeIn)))
          ..addStatusListener(_animationEndCallback);

    _controller?.forward();
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _isCurrentlyPausing = true;
      Timer(_texts[_index]['pause'], _nextAnimation);
    }
  }
}

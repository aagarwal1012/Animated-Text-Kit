import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class TyperAnimatedTextKit extends StatefulWidget {
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
    this.speed,
    this.pause,
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
  }) : super(key: key);

  @override
  _TyperState createState() => new _TyperState();
}

class _TyperState extends State<TyperAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _typingText;
  List<Widget> textWidgetList = [];

  Duration _speed;
  Duration _pause;

  List<Map> _texts = [];

  int _index;

  bool _isCurrentlyPausing = false;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _speed = widget.speed ?? Duration(milliseconds: 40);
    _pause = widget.pause ?? Duration(milliseconds: 1000);

    _index = -1;

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

    // Start animation
    _nextAnimation();
  }

  @override
  void dispose() {
    if (_controller != null)
      _controller
        ..stop()
        ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: _isCurrentlyPausing || !_controller.isAnimating
            ? Text(
                _texts[_index]['text'],
                style: widget.textStyle,
                textAlign: widget.textAlign,
              )
            : AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  int offset = _texts[_index]['text'].length < _typingText.value
                      ? _texts[_index]['text'].length
                      : _typingText.value;

                  return Text(
                    _texts[_index]['text'].substring(0, offset),
                    style: widget.textStyle,
                    textAlign: widget.textAlign,
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
      if (widget.isRepeatingAnimation) {
        _index = 0;
      } else {
        if (widget.onFinished != null) widget.onFinished();
        return;
      }
    } else {
      _index++;
    }

    if (_controller != null) _controller.dispose();

    setState(() {});

    _controller = new AnimationController(
      duration: _texts[_index]['speed'] * _texts[_index]['text'].length,
      vsync: this,
    );

    _typingText = StepTween(begin: 0, end: _texts[_index]['text'].length)
        .animate(_controller)
          ..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _setPause() {
    bool isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = true;
    setState(() {});

    // Handle onNextBeforePause callback
    if (widget.onNextBeforePause != null)
      widget.onNextBeforePause(_index, isLast);
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      _timer = Timer(_texts[_index]['pause'], _nextAnimation);
    }
  }

  void _onTap() {
    int pause;
    int left;

    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        pause = _texts[_index]['pause'].inMilliseconds;
        left = _texts[_index]['speed'].inMilliseconds *
            (_texts[_index]['text'].length - _typingText.value);

        _controller.stop();

        _setPause();

        _timer =
            Timer(Duration(milliseconds: max(pause, left)), _nextAnimation);
      }
    }

    if (widget.onTap != null) {
      widget.onTap();
    }
  }
}

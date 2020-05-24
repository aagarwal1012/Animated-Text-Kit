import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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
    this.speed,
    this.pause,
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
  }) : super(key: key);

  @override
  _TyperState createState() => _TyperState();
}

class _TyperState extends State<TyperAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _typingText;
  List<Widget> textWidgetList = [];

  Duration _speed;
  Duration _pause;

  List<Map<String, dynamic>> _texts = [];

  int _index;

  bool _isCurrentlyPausing = false;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _speed = widget.speed ?? const Duration(milliseconds: 40);
    _pause = widget.pause ?? const Duration(milliseconds: 1000);

    _index = -1;

    widget.text.forEach((text) {
      _texts.add({'text': text, 'speed': _speed, 'pause': _pause});
    });

    // Start animation
    _nextAnimation();
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
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
                  final int offset =
                      _texts[_index]['text'].length < _typingText.value
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
    final bool isLast = _index == widget.text.length - 1;

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

    _controller = AnimationController(
      duration: _texts[_index]['speed'] * _texts[_index]['text'].length,
      vsync: this,
    );

    _typingText = StepTween(begin: 0, end: _texts[_index]['text'].length)
        .animate(_controller)
          ..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _setPause() {
    final bool isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});

    // Handle onNextBeforePause callback
    widget.onNextBeforePause?.call(_index, isLast);
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      _timer = Timer(_texts[_index]['pause'], _nextAnimation);
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
        final int pause = _texts[_index]['pause'].inMilliseconds;
        final int left = _texts[_index]['speed'].inMilliseconds *
            (_texts[_index]['text'].length - _typingText.value);

        _controller.stop();

        _setPause();

        _timer =
            Timer(Duration(milliseconds: max(pause, left)), _nextAnimation);
      }
    }

    widget.onTap?.call();
  }
}

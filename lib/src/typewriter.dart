import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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

  /// The Writing Speed which which the typewriter writes can be set to follow any curves
  /// Taken from the Flutter [Curves] Class.
  /// By Default it follows a linear speed.
  final Curve curve;
  
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


  TypewriterAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      this.speed,
      this.curve = Curves.linear,
      this.pause,
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
      this.isRepeatingAnimation = true})
      : assert(text != null, 'You must specify the list of text'),
        super(key: key);
      

  @override
  _TypewriterState createState() => _TypewriterState();
}

class _TypewriterState extends State<TypewriterAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation _typewriterText;
  Animation _animator;
  List<Widget> textWidgetList = [];

  Duration _speed;
  Duration _pause;

  List<Map<String, dynamic>> _texts = [];

  int _index;

  bool _isCurrentlyPausing = false;

  Timer _timer;

  int _currentRepeatCount;

  @override
  void initState() {
    super.initState();

    _speed = widget.speed ?? const Duration(milliseconds: 30);
    _pause = widget.pause ?? const Duration(milliseconds: 1000);

    _index = -1;

    _currentRepeatCount = 0;

    widget.text.forEach((text) {
      _texts.add({'text': text, 'speed': _speed, 'pause': _pause});
    });

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
            ? RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: _texts[_index]['text'],
                  ),
                  TextSpan(
                      text: '_',
                      style:
                          widget.textStyle.copyWith(color: Colors.transparent))
                ], style: widget.textStyle),
                textAlign: widget.textAlign,
              )
            : AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  String visibleString = _texts[_index]['text'];
                  Color suffixColor = Colors.transparent;
                  if (_typewriterText.value == 0) {
                    visibleString = "";
                  } else if (_typewriterText.value >
                      _texts[_index]['text'].length) {
                    visibleString = _texts[_index]['text']
                        .substring(0, _texts[_index]['text'].length);
                    if ((_typewriterText.value -
                                _texts[_index]['text'].length) %
                            2 ==
                        0) {
                      suffixColor = widget.textStyle.color;
                    } else {
                      suffixColor = Colors.transparent;
                    }
                  } else {
                    visibleString = _texts[_index]['text']
                        .substring(0, _typewriterText.value.abs());
                    suffixColor = widget.textStyle.color;
                  }

                  return RichText(
                    text: TextSpan(children: [
                      TextSpan(text: visibleString),
                      TextSpan(
                          text: '_',
                          style: widget.textStyle.copyWith(color: suffixColor))
                    ], style: widget.textStyle),
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

    _controller = AnimationController(
      duration: _texts[_index]['speed'] * _texts[_index]['text'].length,
      vsync: this,
    );
    _animator = CurvedAnimation(parent: _controller, curve: widget.curve);
    

    _typewriterText =
        StepTween(begin: 0, end: _texts[_index]['text'].length + 8)
            .animate(_animator)
              ..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _setPause() {
    final bool isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});

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
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        final int pause = _texts[_index]['pause'].inMilliseconds;
        final int left = _texts[_index]['speed'].inMilliseconds *
            (_texts[_index]['text'].length - _typewriterText.value);

        _controller.stop();

        _setPause();

        _timer =
            Timer(Duration(milliseconds: max(pause, left)), _nextAnimation);
      }
    }

    widget.onTap?.call();
  }
}

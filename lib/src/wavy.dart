import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class WavyAnimatedTextKit extends StatefulWidget {
  const WavyAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.onFinished,
    this.isRepeatingAnimation = true,
    this.speed = const Duration(milliseconds: 300),
    this.pause = const Duration(milliseconds: 1000),
  })  : assert(null != text),
        assert(null != isRepeatingAnimation),
        assert(null != speed),
        assert(null != pause),
        super(key: key);

  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the motion of each character
  ///
  /// By default it is set to 300 milliseconds.
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

  /// Set if the animation should not repeat by changing the value of it to false.
  ///
  /// By default it is set to true.
  final bool isRepeatingAnimation;

  @override
  _WavyAnimatedTextKitState createState() => _WavyAnimatedTextKitState();
}

class _WavyAnimatedTextKitState extends State<WavyAnimatedTextKit>
    with TickerProviderStateMixin {
  // List<GlobalKey<_WTextState>> _keys;

  AnimationController _controller;
  Animation<double> _waveAnim;
  Timer _timer;

  int _index = -1;

  @override
  void initState() {
    super.initState();

    _nextAnimation();
  }

  void _statusListener(status) {
    if (status == AnimationStatus.completed) {
      _setPause();
      assert(null == _timer || !_timer.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => RepaintBoundary(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          foregroundPainter: _WTextPainter(
            progress: _waveAnim.value,
            text: widget.text[_index],
            textStyle: widget.textStyle,
          ),
          child: child,
        ),
      ),
      child: Container(
        child: GestureDetector(
          onTap: () => widget.onTap?.call(),
        ),
      ),
    );
  }

  Future<void> _nextAnimation() async {
    final isLast = _index == widget.text.length - 1;

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
      vsync: this,
      duration: widget.speed * widget.text[_index].length,
    )..addStatusListener(_statusListener);

    _waveAnim =
        Tween<double>(begin: 0, end: widget.text[_index].length / 2 + 0.52)
            .animate(_controller);

    _controller.forward();
  }

  void _setPause() {
    final isLast = _index == widget.text.length - 1;

    if (mounted) setState(() {});

    // Handle onNextBeforePause callback
    widget.onNextBeforePause?.call(_index, isLast);
  }
}

class _WTextPainter extends CustomPainter {
  _WTextPainter({
    @required this.progress,
    @required this.text,
    this.textStyle,
  });

  final double progress;
  final String text;
  // Private class to store text information
  final _textLayoutInfo = <_TextLayoutInfo>[];
  final TextStyle textStyle;
  @override
  void paint(Canvas canvas, Size size) {
    if (_textLayoutInfo.isEmpty) {
      // calculate the initial position of each char
      calculateLayoutInfo(text, _textLayoutInfo);
    }
    canvas.save();
    if (_textLayoutInfo != null) {
      for (var textLayout in _textLayoutInfo) {
        // offset required to center the characters
        final centerOffset =
            Offset(size.width / 2, (size.height / 2 - textLayout.height / 2));

        if (textLayout.isMoving) {
          final p = math.min(progress * 2, 1.0);
          // drawing the char if the text is moving
          drawText(
              canvas,
              textLayout.text,
              Offset(
                    textLayout.offsetX,
                    (textLayout.offsetY -
                        (textLayout.offsetY - textLayout.riseHeight) * p),
                  ) +
                  centerOffset,
              textLayout);
        } else {
          // drawing the char if text is not moving
          drawText(
            canvas,
            textLayout.text,
            Offset(textLayout.offsetX, textLayout.offsetY) + centerOffset,
            textLayout,
          );
        }
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_WTextPainter oldDelegate) {
    if (oldDelegate.progress != progress) {
      // calulate layout of text and movement of moving chars
      calculateLayoutInfo(text, _textLayoutInfo);
      calculateMove();
      return true;
    }
    return false;
  }

  void calculateMove() {
    final height = _textLayoutInfo[0].height;
    final txtInMoInd = progress.floor();
    final percent = progress - txtInMoInd;
    final txtInMoOdd = (progress - .5).floor();
    final txtInMoEven = txtInMoInd * 2;

    // Calculating movement of the char at odd place
    if (txtInMoOdd < (text.length - 1) / 2 && !txtInMoOdd.isNegative) {
      _textLayoutInfo[txtInMoOdd + (txtInMoOdd + 1)].isMoving = true;
      // percent < .5 creates an phase difference between odd and even chars
      _textLayoutInfo[txtInMoOdd + (txtInMoOdd + 1)].riseHeight = progress < .5
          ? 0
          : -1.3 * height * math.sin((progress - .5) * math.pi).abs();
    }

    // Calculating movement of the char at even place
    if (txtInMoEven < text.length) {
      _textLayoutInfo[txtInMoEven].isMoving = true;
      _textLayoutInfo[txtInMoEven].riseHeight =
          -1.3 * height * math.sin(percent * math.pi);
    }
  }

  void drawText(Canvas canvas, String text, Offset offset,
      _TextLayoutInfo textLayoutInfo) {
    var textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textLayoutInfo.width / 2,
        offset.dy + (textLayoutInfo.height - textPainter.height) / 2,
      ),
    );
  }

  void calculateLayoutInfo(String text, List<_TextLayoutInfo> list) {
    list.clear();

    // creating a textPainter to get data about location and offset for chars
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    textPainter.layout();
    for (var i = 0; i < text.length; i++) {
      var forCaret = textPainter.getOffsetForCaret(
        TextPosition(offset: i),
        Rect.zero,
      );
      var offsetX = forCaret.dx;
      if (i > 0 && offsetX == 0) {
        break;
      }

      // creating layout for each char
      final textLayoutInfo = _TextLayoutInfo(
        text: text[i],
        offsetX: offsetX,
        offsetY: forCaret.dy,
        width: textPainter.width,
        height: textPainter.height,
        baseline: textPainter
            .computeDistanceToActualBaseline(TextBaseline.ideographic),
      );

      list.add(textLayoutInfo);
    }
  }
}

class _TextLayoutInfo {
  final String text;
  final double offsetX;
  final double offsetY;
  final double width;
  final double height;
  final double baseline;
  double riseHeight;
  bool isMoving = false;

  _TextLayoutInfo({
    @required this.text,
    @required this.offsetX,
    @required this.offsetY,
    @required this.width,
    @required this.height,
    @required this.baseline,
  });
}

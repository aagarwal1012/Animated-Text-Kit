import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element with each character popping
/// like a stadium wave.
///
/// ![Wavy example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/wavy.gif)
class WavyAnimatedText extends AnimatedText {
  /// The [Duration] of the motion of each character
  ///
  /// By default it is set to 300 milliseconds.
  final Duration speed;

  WavyAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 300),
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _waveAnim;

  @override
  void initAnimation(AnimationController controller) {
    _waveAnim = Tween<double>(begin: 0, end: textCharacters.length / 2 + 0.52)
        .animate(controller);
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _WTextPainter(
          progress: _waveAnim.value,
          text: text,
          textStyle: defaultTextStyle.merge(textStyle),
          scaleFactor: scaleFactor,
        ),
        child: Text(
          text,
          style: defaultTextStyle
              .merge(textStyle)
              .merge(TextStyle(color: Colors.transparent)),
          textScaleFactor: scaleFactor,
        ),
      ),
    );
  }
}

/// Animation that displays [text] elements, with each text animated with its
/// characters popping like a stadium wave.
///
/// ![Wavy example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/wavy.gif)
@Deprecated('Use AnimatedTextKit with WavyAnimatedText instead.')
class WavyAnimatedTextKit extends AnimatedTextKit {
  WavyAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration speed = const Duration(milliseconds: 300),
    Duration pause = const Duration(milliseconds: 1000),
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    int totalRepeatCount = 3,
    bool repeatForever = true,
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
  }) : super(
          key: key,
          animatedTexts: _animatedTexts(text, textAlign, textStyle, speed),
          pause: pause,
          displayFullTextOnTap: displayFullTextOnTap,
          stopPauseOnTap: stopPauseOnTap,
          onTap: onTap,
          onNext: onNext,
          onNextBeforePause: onNextBeforePause,
          onFinished: onFinished,
          isRepeatingAnimation: isRepeatingAnimation,
          totalRepeatCount: totalRepeatCount,
          repeatForever: repeatForever,
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle? textStyle,
    Duration speed,
  ) =>
      text
          .map((_) => WavyAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
              ))
          .toList();
}

class _WTextPainter extends CustomPainter {
  _WTextPainter({
    required this.progress,
    required this.text,
    required this.textStyle,
    required this.scaleFactor,
  });

  final double progress, scaleFactor;
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
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
      textScaleFactor: scaleFactor,
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
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      textScaleFactor: scaleFactor,
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
  late double riseHeight;
  bool isMoving = false;

  _TextLayoutInfo({
    required this.text,
    required this.offsetX,
    required this.offsetY,
    required this.width,
    required this.height,
    required this.baseline,
  });
}

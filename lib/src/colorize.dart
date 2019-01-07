import 'package:animated_text_kit/src/generic_animated_text_kit.dart';
import 'package:flutter/material.dart';

class ColorizeAnimatedTextKit extends GenericAnimatedTextKit {
  final List<Color> colors;

  const ColorizeAnimatedTextKit(
      {Key key,
      @required List<String> text,
      @required this.colors,
      TextStyle textStyle,
      Duration duration,
      VoidCallback onTap,
      AlignmentGeometry alignment = AlignmentDirectional.topStart,
      TextAlign textAlign = TextAlign.start,
      bool isRepeatingAnimation = true})
      : assert(colors != null),
        super(
            key: key,
            text: text,
            textStyle: textStyle,
            duration: duration,
            onTap: onTap,
            alignment: alignment,
            textAlign: textAlign,
            isRepeatingAnimation: isRepeatingAnimation);

  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState
    extends GenericAnimatedTextKitState<ColorizeAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  List<Animation<double>> _colorShifter = [];

  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  List<double> _tuning = [];

  @override
  void setup() {
    int lengthList = widget.text.length;

    int totalCharacters = 0;

    for (int i = 0; i < lengthList; i++) {
      totalCharacters += widget.text[i].length;
    }

    if (widget.duration == null) {
      duration = Duration(milliseconds: 1500 * totalCharacters ~/ 3);
    } else {
      duration = widget.duration;
    }

    controller = new AnimationController(
      duration: duration,
      vsync: this,
    );

    if (widget.isRepeatingAnimation) {
      controller..repeat();
    } else {
      controller.forward();
    }

    double percentTimeCount = 0.0;

    for (int i = 0; i < lengthList; i++) {
      double percentTime = widget.text[i].length / totalCharacters;

      _tuning.add((300.0 * widget.colors.length) *
          (widget.textStyle.fontSize / 24.0) *
          0.75 *
          (widget.text[i].length / 15.0));

      _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            percentTimeCount,
            percentTimeCount + (percentTime / 10),
            curve: Curves.easeOut,
          ))));

      _fadeOut.add(Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
          parent: controller,
          curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
              (percentTimeCount + percentTime),
              curve: Curves.easeIn))));

      _colorShifter.add(
          Tween(begin: 0.0, end: widget.colors.length * _tuning[i]).animate(
              CurvedAnimation(
                  parent: controller,
                  curve: Interval(
                      percentTimeCount, percentTimeCount + percentTime,
                      curve: Curves.easeIn))));

      percentTimeCount += percentTime;
    }
  }

  @override
  Widget buildLayout(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
      if (i != widget.text.length - 1) {
        textWidgetList.add(AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            Shader linearGradient = LinearGradient(colors: widget.colors)
                .createShader(
                    Rect.fromLTWH(0.0, 0.0, _colorShifter[i].value, 0.0));
            return Opacity(
              opacity: !(_fadeIn[i].value == 1.0)
                  ? _fadeIn[i].value
                  : _fadeOut[i].value,
              child: Text(
                widget.text[i],
                style: widget.textStyle != null
                    ? widget.textStyle.merge(
                        TextStyle(foreground: Paint()..shader = linearGradient))
                    : widget.textStyle,
                textAlign: widget.textAlign,
              ),
            );
          },
        ));
      } else {
        if (widget.isRepeatingAnimation) {
          textWidgetList.add(AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              Shader linearGradient = LinearGradient(colors: widget.colors)
                  .createShader(
                      Rect.fromLTWH(0.0, 0.0, _colorShifter[i].value, 0.0));
              return Opacity(
                opacity: !(_fadeIn[i].value == 1.0)
                    ? _fadeIn[i].value
                    : _fadeOut[i].value,
                child: Text(
                  widget.text[i],
                  style: widget.textStyle != null
                      ? widget.textStyle.merge(TextStyle(
                          foreground: Paint()..shader = linearGradient))
                      : widget.textStyle,
                  textAlign: widget.textAlign,
                ),
              );
            },
          ));
        } else {
          textWidgetList.add(AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              Shader linearGradient = LinearGradient(colors: widget.colors)
                  .createShader(
                      Rect.fromLTWH(0.0, 0.0, _colorShifter[i].value, 0.0));
              return Opacity(
                opacity: _fadeIn[i].value,
                child: Text(
                  widget.text[i],
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
      }
    }

    return SizedBox(
      height: 80.0,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: widget.alignment,
          children: textWidgetList,
        ),
      ),
    );
  }
}

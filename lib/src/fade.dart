import 'package:animated_text_kit/src/generic_animated_text_kit.dart';
import 'package:flutter/material.dart';

class FadeAnimatedTextKit extends GenericAnimatedTextKit {
  const FadeAnimatedTextKit(
      {Key key,
      @required List<String> text,
      TextStyle textStyle,
      Duration duration,
      VoidCallback onTap,
      AlignmentGeometry alignment = AlignmentDirectional.topStart,
      TextAlign textAlign = TextAlign.start,
      bool isRepeatingAnimation = true})
      : super(
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
    extends GenericAnimatedTextKitState<FadeAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  @override
  void setup() {
    if (widget.duration == null) {
      duration = Duration(milliseconds: 2000 * widget.text.length);
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

    int lengthList = widget.text.length;

    double percentTime = 1.0 / lengthList;
    double fadeTime = 1.0 / (lengthList * 4);

    for (int i = 0; i < widget.text.length; i++) {
      _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval((i * percentTime), (i * percentTime) + fadeTime,
              curve: Curves.linear))));
      _fadeOut.add(Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
              ((i + 1) * percentTime) - fadeTime, ((i + 1) * percentTime),
              curve: Curves.linear))));
    }
  }

  @override
  Widget buildLayout(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
      if (i != widget.text.length - 1) {
        textWidgetList.add(AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: !(_fadeIn[i].value == 1.0)
                  ? _fadeIn[i].value
                  : _fadeOut[i].value,
              child: Text(
                widget.text[i],
                style: widget.textStyle,
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
              return Opacity(
                opacity: !(_fadeIn[i].value == 1.0)
                    ? _fadeIn[i].value
                    : _fadeOut[i].value,
                child: Text(
                  widget.text[i],
                  style: widget.textStyle,
                  textAlign: widget.textAlign,
                ),
              );
            },
          ));
        } else {
          textWidgetList.add(AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: _fadeIn[i].value,
                child: Text(
                  widget.text[i],
                  style: widget.textStyle,
                  textAlign: widget.textAlign,
                ),
              );
            },
          ));
        }
      }
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: widget.alignment,
        children: textWidgetList,
      ),
    );
  }
}

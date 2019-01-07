import 'package:animated_text_kit/src/generic_animated_text_kit.dart';
import 'package:flutter/material.dart';

class TyperAnimatedTextKit extends GenericAnimatedTextKit {
  const TyperAnimatedTextKit(
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
  _TyperState createState() => new _TyperState();
}

class _TyperState extends GenericAnimatedTextKitState<TyperAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  List<Animation<int>> _typingText = [];
  List<Animation<double>> _fadeOut = [];

  @override
  void setup() {
    int totalCharacters = 0;

    for (int i = 0; i < widget.text.length; i++) {
      totalCharacters += widget.text[i].length;
    }

    if (widget.duration == null) {
      duration = Duration(milliseconds: totalCharacters * 5000 ~/ 15);
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
    for (int i = 0; i < widget.text.length; i++) {
      double percentTime = widget.text[i].length / totalCharacters;

      _typingText.add(StepTween(begin: 0, end: widget.text[i].length).animate(
          new CurvedAnimation(
              parent: controller,
              curve: Interval(
                  percentTimeCount, (percentTimeCount + (percentTime * 8 / 10)),
                  curve: Curves.linear))));

      _fadeOut.add(Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
          parent: controller,
          curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
              (percentTimeCount + percentTime),
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
            return Opacity(
              opacity: _fadeOut[i].value,
              child: Text(
                widget.text[i].substring(0, _typingText[i].value),
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
                opacity: _fadeOut[i].value,
                child: Text(
                  widget.text[i].substring(0, _typingText[i].value),
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
                opacity: 1,
                child: Text(
                  widget.text[i].substring(0, _typingText[i].value),
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

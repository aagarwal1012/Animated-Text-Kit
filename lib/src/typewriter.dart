import 'package:animated_text_kit/src/generic_animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypewriterAnimatedTextKit extends GenericAnimatedTextKit {
  const TypewriterAnimatedTextKit(
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
  _TypewriterState createState() => new _TypewriterState();
}

class _TypewriterState
    extends GenericAnimatedTextKitState<TypewriterAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  List<Animation<int>> _typewriterText = [];
  List<Animation<double>> _fadeOut = [];

  @override
  void setup() {
    if (widget.duration == null) {
      int totalCharacters = 0;

      for (int i = 0; i < widget.text.length; i++) {
        totalCharacters += (widget.text[i].length + 8);
      }

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

    int totalCharacters = 0;

    for (int i = 0; i < widget.text.length; i++) {
      totalCharacters += (widget.text[i].length + 8);
    }

    double percentTimeCount = 0.0;
    for (int i = 0; i < widget.text.length; i++) {
      double percentTime = (widget.text[i].length + 8) / totalCharacters;

      _typewriterText.add(StepTween(begin: 0, end: widget.text[i].length + 8)
          .animate(new CurvedAnimation(
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
              child: Builder(
                builder: (BuildContext context) {
                  String visibleString = widget.text[i];
                  if (_typewriterText[i].value == 0) {
                    visibleString = "";
                  } else if (_typewriterText[i].value > widget.text[i].length) {
                    if ((_typewriterText[i].value - widget.text[i].length) %
                            2 ==
                        0) {
                      visibleString =
                          widget.text[i].substring(0, widget.text[i].length) +
                              "_";
                    } else {
                      visibleString =
                          widget.text[i].substring(0, widget.text[i].length);
                    }
                  } else {
                    visibleString =
                        widget.text[i].substring(0, _typewriterText[i].value) +
                            "_";
                  }
                  return Text(
                    visibleString,
                    style: widget.textStyle,
                    textAlign: widget.textAlign,
                  );
                },
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
                child: Builder(
                  builder: (BuildContext context) {
                    String visibleString = widget.text[i];
                    if (_typewriterText[i].value == 0) {
                      visibleString = "";
                    } else if (_typewriterText[i].value >
                        widget.text[i].length) {
                      if ((_typewriterText[i].value - widget.text[i].length) %
                              2 ==
                          0) {
                        visibleString =
                            widget.text[i].substring(0, widget.text[i].length) +
                                "_";
                      } else {
                        visibleString =
                            widget.text[i].substring(0, widget.text[i].length);
                      }
                    } else {
                      visibleString = widget.text[i]
                              .substring(0, _typewriterText[i].value) +
                          "_";
                    }
                    return Text(
                      visibleString,
                      style: widget.textStyle,
                      textAlign: widget.textAlign,
                    );
                  },
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
                child: Builder(
                  builder: (BuildContext context) {
                    String visibleString = widget.text[i];
                    if (_typewriterText[i].value == 0) {
                      visibleString = "";
                    } else if (_typewriterText[i].value >
                        widget.text[i].length) {
                      if ((_typewriterText[i].value - widget.text[i].length) %
                              2 ==
                          0) {
                        visibleString =
                            widget.text[i].substring(0, widget.text[i].length) +
                                "_";
                      } else {
                        visibleString =
                            widget.text[i].substring(0, widget.text[i].length);
                      }
                    } else {
                      visibleString = widget.text[i]
                              .substring(0, _typewriterText[i].value) +
                          "_";
                    }
                    return Text(
                      visibleString,
                      style: widget.textStyle,
                      textAlign: widget.textAlign,
                    );
                  },
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

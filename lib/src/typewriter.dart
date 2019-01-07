import 'package:flutter/material.dart';

class TypewriterAnimatedTextKit extends StatefulWidget {
  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback onTap;
  final AlignmentGeometry alignment;
  final TextAlign textAlign;
  final bool isRepeatingAnimation;

  TypewriterAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      this.duration,
      this.onTap,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.isRepeatingAnimation = true})
      : super(key: key);

  @override
  _TypewriterState createState() => new _TypewriterState();
}

class _TypewriterState extends State<TypewriterAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  Duration _duration;

  AnimationController _controller;

  List<Animation<int>> _typewriterText = [];
  List<Animation<double>> _fadeOut = [];

  List<Widget> textWidgetList = [];

  @override
  void initState() {
    super.initState();

    if (widget.duration == null) {
      int totalCharacters = 0;

      for (int i = 0; i < widget.text.length; i++) {
        totalCharacters += (widget.text[i].length + 8);
      }

      _duration = Duration(milliseconds: totalCharacters * 5000 ~/ 15);
    } else {
      _duration = widget.duration;
    }

    _controller = new AnimationController(
      duration: _duration,
      vsync: this,
    );

    if (widget.isRepeatingAnimation) {
      _controller..repeat();
    } else {
      _controller.forward();
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
              parent: _controller,
              curve: Interval(
                  percentTimeCount, (percentTimeCount + (percentTime * 8 / 10)),
                  curve: Curves.linear))));

      _fadeOut.add(Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
          parent: _controller,
          curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
              (percentTimeCount + percentTime),
              curve: Curves.easeIn))));

      percentTimeCount += percentTime;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
      if (i != widget.text.length - 1) {
        textWidgetList.add(AnimatedBuilder(
          animation: _controller,
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
            animation: _controller,
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
            animation: _controller,
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

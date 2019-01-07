import 'package:animated_text_kit/src/generic_animated_text_kit.dart';
import 'package:flutter/material.dart';

class RotateAnimatedTextKit extends GenericAnimatedTextKit {
  final double transitionHeight;

  const RotateAnimatedTextKit(
      {Key key,
      @required List<String> text,
      this.transitionHeight,
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
    extends GenericAnimatedTextKitState<RotateAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  double _transitionHeight;

  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];
  List<Animation<Alignment>> _slideIn = [];
  List<Animation<Alignment>> _slideOut = [];

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

    if (widget.transitionHeight == null) {
      _transitionHeight = widget.textStyle.fontSize * 10 / 3;
    } else {
      _transitionHeight = widget.transitionHeight;
    }

    double percentTime = 1.0 / lengthList;
    double fadeTime = 1.0 / (lengthList * 7);
    double slideTime = 1.0 / (lengthList * 3);

    for (int i = 0; i < widget.text.length; i++) {
      if (i == 0) {
        _slideIn.add(AlignmentTween(
          begin: Alignment(-1.0, -1.0),
          end: new Alignment(-1.0, 0.0),
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, slideTime, curve: Curves.linear))));
        _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, fadeTime, curve: Curves.easeOut))));
      } else {
        _slideIn.add(AlignmentTween(
          begin: Alignment(-1.0, -1.0),
          end: new Alignment(-1.0, 0.0),
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval((i * percentTime) - slideTime, (i) * percentTime,
                curve: Curves.linear))));
        _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval((i * percentTime) - slideTime,
                (i * percentTime) - slideTime + fadeTime,
                curve: Curves.easeOut))));
      }

      _slideOut.add(AlignmentTween(
        begin: Alignment(-1.0, 0.0),
        end: new Alignment(-1.0, 1.0),
      ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
              ((i + 1) * percentTime) - slideTime, (i + 1) * percentTime,
              curve: Curves.linear))));
      _fadeOut.add(Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(((i + 1) * percentTime) - slideTime,
              ((i + 1) * percentTime) - slideTime + fadeTime,
              curve: Curves.easeIn))));
    }
  }

  @override
  Widget buildLayout(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
      if (i != widget.text.length - 1) {
        textWidgetList.add(AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return AlignTransition(
              alignment:
                  !(_slideIn[i].value.y == 0.0) ? _slideIn[i] : _slideOut[i],
              child: Opacity(
                opacity: !(_fadeIn[i].value == 1.0)
                    ? _fadeIn[i].value
                    : _fadeOut[i].value,
                child: Text(
                  widget.text[i],
                  style: widget.textStyle,
                  textAlign: widget.textAlign,
                ),
              ),
            );
          },
        ));
      } else {
        if (widget.isRepeatingAnimation) {
          textWidgetList.add(AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return AlignTransition(
                alignment:
                    !(_slideIn[i].value.y == 0.0) ? _slideIn[i] : _slideOut[i],
                child: Opacity(
                  opacity: !(_fadeIn[i].value == 1.0)
                      ? _fadeIn[i].value
                      : _fadeOut[i].value,
                  child: Text(
                    widget.text[i],
                    style: widget.textStyle,
                    textAlign: widget.textAlign,
                  ),
                ),
              );
            },
          ));
        } else {
          textWidgetList.add(AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return AlignTransition(
                alignment: _slideIn[i],
                child: Opacity(
                  opacity: _fadeIn[i].value,
                  child: Text(
                    widget.text[i],
                    style: widget.textStyle,
                    textAlign: widget.textAlign,
                  ),
                ),
              );
            },
          ));
        }
      }
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: _transitionHeight,
        child: Stack(
          alignment: widget.alignment,
          children: textWidgetList,
        ),
      ),
    );
  }
}

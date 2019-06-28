import 'package:flutter_web/material.dart';

class ScaleAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// Override the [Duration] of the animation by setting the duration parameter.
  ///
  /// This will set the total duration for the animated widget.
  /// For example, if text = ["a", "b", "c"] and if you want that each animation
  /// should take 3 seconds then you have to set [duration] to 9 seconds.
  final Duration duration;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback onTap;

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

  /// Set the scaling factor of the text for the animation.
  ///
  /// By default it is set to [double] value 0.5
  final double scalingFactor;

  const ScaleAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      this.scalingFactor = 0.5,
      this.duration,
      this.onTap,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.isRepeatingAnimation = true})
      : super(key: key);

  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<ScaleAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  Duration _duration;

  AnimationController _controller;

  List<Animation<double>> _scaleIn = [];
  List<Animation<double>> _scaleOut = [];
  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  List<Widget> textWidgetList = [];

  @override
  void initState() {
    super.initState();

    if (widget.duration == null) {
      _duration = Duration(milliseconds: 2000 * widget.text.length);
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

    int lengthList = widget.text.length;

    double percentTime = 1.0 / lengthList;
    double fadeTime = 1.0 / (lengthList * 7);
    double scaleTime = 1.0 / (lengthList * 3);

    for (int i = 0; i < widget.text.length; i++) {
      _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval((i * percentTime), (i * percentTime) + fadeTime,
              curve: Curves.easeOut))));
      _fadeOut.add(Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
              ((i + 1) * percentTime) - fadeTime, ((i + 1) * percentTime),
              curve: Curves.easeIn))));
      _scaleIn.add(Tween<double>(begin: widget.scalingFactor, end: 1.0)
          .animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (i * percentTime),
                (i * percentTime) + scaleTime,
                curve: Curves.easeOut,
              ))));
      _scaleOut.add(Tween<double>(begin: 1.0, end: widget.scalingFactor)
          .animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(
                ((i + 1) * percentTime) - scaleTime,
                ((i + 1) * percentTime),
                curve: Curves.easeIn,
              ))));
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
            return ScaleTransition(
              scale: !(_scaleIn[i].value == 1.0) ? _scaleIn[i] : _scaleOut[i],
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
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return ScaleTransition(
                scale: !(_scaleIn[i].value == 1.0) ? _scaleIn[i] : _scaleOut[i],
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
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return ScaleTransition(
                scale: _scaleIn[i],
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
      child: Stack(
        alignment: widget.alignment,
        children: textWidgetList,
      ),
    );
  }
}

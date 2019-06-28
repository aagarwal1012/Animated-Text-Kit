import 'package:flutter_web/material.dart';

class ColorizeAnimatedTextKit extends StatefulWidget {
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

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  final List<Color> colors;

  const ColorizeAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      @required this.colors,
      this.duration,
      this.onTap,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.isRepeatingAnimation = true})
      : super(key: key);

  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<ColorizeAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  Duration _duration;

  AnimationController _controller;

  List<Widget> _textWidgetList = [];

  List<Animation<double>> _colorShifter = [];

  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  List<double> _tuning = [];

  @override
  void initState() {
    super.initState();

    int lengthList = widget.text.length;

    int totalCharacters = 0;

    for (int i = 0; i < lengthList; i++) {
      totalCharacters += widget.text[i].length;
    }

    if (widget.duration == null) {
      _duration = Duration(milliseconds: 1500 * totalCharacters ~/ 3);
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

    double percentTimeCount = 0.0;

    for (int i = 0; i < lengthList; i++) {
      double percentTime = widget.text[i].length / totalCharacters;

      _tuning.add((300.0 * widget.colors.length) *
          (widget.textStyle.fontSize / 24.0) *
          0.75 *
          (widget.text[i].length / 15.0));

      _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
            percentTimeCount,
            percentTimeCount + (percentTime / 10),
            curve: Curves.easeOut,
          ))));

      _fadeOut.add(Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
          parent: _controller,
          curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
              (percentTimeCount + percentTime),
              curve: Curves.easeIn))));

      _colorShifter.add(
          Tween(begin: 0.0, end: widget.colors.length * _tuning[i]).animate(
              CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                      percentTimeCount, percentTimeCount + percentTime,
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
        _textWidgetList.add(AnimatedBuilder(
          animation: _controller,
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
          _textWidgetList.add(AnimatedBuilder(
            animation: _controller,
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
          _textWidgetList.add(AnimatedBuilder(
            animation: _controller,
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
          children: _textWidgetList,
        ),
      ),
    );
  }
}

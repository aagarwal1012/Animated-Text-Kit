import 'package:flutter/material.dart';

class ColorizeAnimatedTextKit extends StatefulWidget {
  final List<String> text;
  final List<Color> colors;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback onTap;

  const ColorizeAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      @required this.colors,
      this.duration,
      this.onTap = null})
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
    )..repeat();

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
            ),
          );
        },
      ));
    }

    return SizedBox(
      height: 80.0,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: _textWidgetList,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FadeAnimatedTextKit extends StatefulWidget {
  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback onTap;

  const FadeAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      this.duration,
      this.onTap})
      : super(key: key);

  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<FadeAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  Duration _duration;

  AnimationController _controller;

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
    )..repeat();

    int lengthList = widget.text.length;

    double percentTime = 1.0 / lengthList;
    double fadeTime = 1.0 / (lengthList * 4);

    for (int i = 0; i < widget.text.length; i++) {
      _fadeIn.add(Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval((i * percentTime), (i * percentTime) + fadeTime,
              curve: Curves.linear))));
      _fadeOut.add(Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
              ((i + 1) * percentTime) - fadeTime, ((i + 1) * percentTime),
              curve: Curves.linear))));
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
      textWidgetList.add(AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: !(_fadeIn[i].value == 1.0)
                ? _fadeIn[i].value
                : _fadeOut[i].value,
            child: Text(
              widget.text[i],
              style: widget.textStyle,
            ),
          );
        },
      ));
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: textWidgetList,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FadeAnimatedTextKit extends StatefulWidget {

  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;

  const FadeAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.duration}) : super(key: key);


  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<FadeAnimatedTextKit>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;

  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  List<Widget> textWidgetList = [];

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..repeat();

    int lengthList = widget.text.length;

    double percentTime = 1.0 / lengthList;
    double fadeTime = 1.0 / (lengthList * 3);

    for (int i = 0; i < widget.text.length; i++) {
        _fadeIn.add(
            Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                CurvedAnimation(parent: _controller,
                    curve: Interval(
                        (i * percentTime),
                        (i * percentTime)+ fadeTime,
                        curve: Curves.easeOut
                    )
                )
            )
        );
      _fadeOut.add(
          Tween<double>(begin: 1.0, end: 0.0)
              .animate(
              CurvedAnimation(parent: _controller,
                  curve: Interval(
                      ((i + 1) * percentTime) - fadeTime,
                      ((i + 1) * percentTime),
                      curve: Curves.easeIn
                  )
              )
          )
      );
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
      textWidgetList.add(
          AnimatedBuilder(
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
          )
      );
    }

    return Stack(
      children: textWidgetList,
    );
  }
}

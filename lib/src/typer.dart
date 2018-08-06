import 'package:flutter/material.dart';

class Typer extends StatefulWidget {

  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;

  const Typer({
    Key key,
    @required this.text,
    this.textStyle,
    this.duration}) : super(key: key);


  @override
  _TyperState createState() => new _TyperState();
}

class _TyperState extends State<Typer> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  List<Animation<int>> _typingText = [];
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

    int totalCharacters = 0;

    for (int i = 0; i < widget.text.length; i++) {
      totalCharacters += widget.text[i].length;
    }

    double percentTimeCount = 0.0;
    for (int i = 0; i < widget.text.length; i++) {
      double percentTime = widget.text[i].length / totalCharacters;

      _typingText.add(
          StepTween(
              begin: 0, end: widget.text[i].length).animate(
              new CurvedAnimation(
                  parent: _controller,
                  curve: Interval(percentTimeCount,
                      (percentTimeCount + (percentTime * 8 / 10)),
                      curve: Curves.linear)
              )
          )
      );

      _fadeOut.add(
          Tween(
              begin: 1.0, end: 0.0).animate(
              new CurvedAnimation(
                  parent: _controller,
                  curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
                      (percentTimeCount + percentTime), curve: Curves.easeIn)
              )
          )
      );

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
      textWidgetList.add(
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: _fadeOut[i].value,
                child: Text(
                  widget.text[i].substring(0, _typingText[i].value),
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

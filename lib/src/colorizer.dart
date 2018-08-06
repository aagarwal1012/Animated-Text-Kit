import 'package:flutter/material.dart';

class ColorizerAnimatedTextKit extends StatefulWidget {

  final String text;
  final List<Color> colors;
  final TextStyle textStyle;
  final Duration duration;

  const ColorizerAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.colors,
    this.duration}) : super(key: key);


  @override
  _RotatingTextState createState() => new _RotatingTextState();
}

class _RotatingTextState extends State<ColorizerAnimatedTextKit>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;

  Animation<double> _colorShifter;

  List<Color> colorsTemp;

  @override
  void initState() {
    super.initState();

    colorsTemp = widget.colors;

    _controller = new AnimationController(
      duration: widget.duration,
      vsync: this,
    )
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        colorsTemp = colorsTemp.reversed.toList();
      }
    });
      _controller..repeat();

    _colorShifter = Tween(begin: 0.0, end: widget.colors.length * 200.0)
        .animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn)

    );

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
    }

    return SizedBox(
      height: 80.0,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          Shader linearGradient = LinearGradient(
              colors: colorsTemp
          ).createShader(Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0));
          //TODO : synchronize colors
          return Text(
            widget.text,
                style: widget.textStyle != null ?
                widget.textStyle.merge(TextStyle(foreground: Paint()..shader = linearGradient)) :
                widget.textStyle,
          );
        },
      ),
    );
  }
}

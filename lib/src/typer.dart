import 'package:flutter/material.dart';

class Typer extends StatefulWidget {

  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;

  const Typer({
    Key key,
    this.text,
    this.textStyle,
    this.duration}) : super(key: key);


  @override
  _TyperState createState() => new _TyperState();
}

class _TyperState extends State<Typer> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<int> _animation;

  int _stringIndexNumber = 0;

  String get _currentString => widget.text[_stringIndexNumber];

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..repeat();
//    _controller
//    ..addStatusListener((status) {
//      if(status == AnimationStatus.completed){
//        setState(() {
//          _stringIndexNumber = (_stringIndexNumber + 1) % widget.text.length;
//          _animation = StepTween(
//              begin: 0, end: _currentString.length).animate(
//              new CurvedAnimation(
//                  parent: _controller,
//                  curve: Interval(0.0, 0.9, curve: Curves.linear)
//              )
//          );
//        });
////      _controller.forward();
//      }
//    });

//      ..addListener(() {
//        if (_controller.status == AnimationStatus.completed) {
//          setState(() {
//            _stringIndexNumber = (_stringIndexNumber + 1) % widget.text.length;
//            _animation = StepTween(
//                begin: 0, end: _currentString.length).animate(
//                new CurvedAnimation(
//                    parent: _controller,
//                    curve: Interval(0.0, 1.0, curve: Curves.linear)
//                )
//            )
//              ..addListener(() => setState(() => {}));
//          });
//          _controller.forward();
//        }
//        if (_controller.status == AnimationStatus.dismissed) {
//          setState(() {
//            _animation = StepTween(
//                begin: 0, end: _currentString.length).animate(
//                new CurvedAnimation(
//                    parent: _controller,
//                    curve: Interval(0.0, 0.9, curve: Curves.linear)
//                )
//            )
//              ..addListener(() => setState(() => {}));
//          });
//          _controller.forward();
//        }
//      });

    _animation = StepTween(
        begin: 0, end: _currentString.length).animate(
        new CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.9, curve: Curves.linear)
        )
    )
      ..addListener(() => setState(() => {}));

//    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    String showText = _currentString.substring(
//        0, _animation.value);
//    return AnimatedBuilder(
//      animation: _controller,
//      builder: (BuildContext context, Widget child) {
////          return Text(
////            _currentString.substring(0, _animation.value),
////            style: widget.textStyle,
////          );
//      return child;
//      },
//      child: Text(
//        _currentString.substring(0, _animation.value),
//        style: widget.textStyle,
//      ),
//  );

    return Text(
      _currentString.substring(0, _animation.value),
      style: widget.textStyle,
    );
  }
}

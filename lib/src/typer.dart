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
//  Animation<int> _animation;

  List<Animation<int>> _typingText = [];
//  List<Animation<double>> _fadeIn = [];
  List<Animation<double>> _fadeOut = [];

  List<Widget> textWidgetList = [];

//  int _stringIndexNumber = 0;

//  String get _currentString => widget.text[_stringIndexNumber];

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

//    _animation = StepTween(
//        begin: 0, end: _currentString.length).animate(
//        new CurvedAnimation(
//            parent: _controller,
//            curve: Interval(0.0, 0.9, curve: Curves.linear)
//        )
//    )
//      ..addListener(() => setState(() => {}));

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
            ..addListener(() => setState(() => {}))
      );
//
//      _fadeIn.add(
//          Tween(
//              begin: 0.0, end: 1.0).animate(
//              new CurvedAnimation(
//                  parent: _controller,
//                  curve: Interval(
//                      percentTimeCount, (percentTimeCount + (percentTime / 10)),
//                      curve: Curves.easeOut)
//              )
//          )
//            ..addListener(() => setState(() => {}))
//      );

      _fadeOut.add(
          Tween(
              begin: 1.0, end: 0.0).animate(
              new CurvedAnimation(
                  parent: _controller,
                  curve: Interval((percentTimeCount + (percentTime * 9 / 10)),
                      (percentTimeCount + percentTime), curve: Curves.easeIn)
              )
          )
            ..addListener(() => setState(() => {}))
      );

      percentTimeCount += percentTime;
    }



//    _controller.forward();
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
              builder: (BuildContext context, Widget child){
                return Opacity(
//                  opacity: (_typingText[i].value == widget.text.length) ? _fadeOut[i].value : _fadeIn[i].value,
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
//
//    return Text(
//      _currentString.substring(0, _animation.value),
//      style: widget.textStyle,
//    );

    return Stack(
      children: textWidgetList,
    );

  }
}

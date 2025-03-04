import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ScrambleAnimatedText extends AnimatedText {
  // duration of single character
  final Duration speed;

  ScrambleAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 500),
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _scrambleText;

  @override
  void initAnimation(AnimationController controller) {
    _scrambleText = CurveTween(
      curve: Curves.linear,
    ).animate(controller);
  }

  @override
  Widget animatedBuilder(context, child) {
    // get the count / text text length base from the animation value
    final count = (_scrambleText.value * textCharacters.length).round();

    return RichText(
      text: TextSpan(
        children: List.generate(
          count,
          (index) {
            return WidgetSpan(
              child: ScrambledChar(
                char: textCharacters.elementAt(index),
                scrambleDuration: speed,
                style: textStyle,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScrambledChar extends StatefulWidget {
  final String char;
  final Duration scrambleDuration;
  final TextStyle? style;

  const ScrambledChar({
    required this.char,
    this.style,
    required this.scrambleDuration,
  }) : assert(char.length == 1, "Char need to only 1 character");

  @override
  State<ScrambledChar> createState() => _ScrambledCharState();
}

class _ScrambledCharState extends State<ScrambledChar> {
  final Random _random = Random();
  static const String _allChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      'abcdefghijklmnopqrstuvwxyz'
      '0123456789'
      '!@#\$%^&*()_+-=[]{}|;:\'",.<>?/`~';

  late String _displayChar;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _displayChar = _generateScrambledChar(widget.char);
    _startScrambling();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _generateScrambledChar(String text) {
    return _allChar[_random.nextInt(_allChar.length)];
  }

  void _startScrambling() {
    int elapsed = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (elapsed >= widget.scrambleDuration.inMilliseconds) {
        setState(() => _displayChar = widget.char);
        timer.cancel();
      } else {
        setState(() => _displayChar = _generateScrambledChar(widget.char));
        elapsed += 50;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayChar,
      style: widget.style,
    );
  }
}

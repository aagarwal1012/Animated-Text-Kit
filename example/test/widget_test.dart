import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {

  test('default value for totalRepeatCount', () {
    TypewriterAnimatedTextKit typewriter = TypewriterAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: [
        "Discipline is the best tool",
        "Design first, then code",
        "Do not patch bugs out, rewrite them",
        "Do not test bugs out, design them out",
      ],
      textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
    );

    expect(typewriter.totalRepeatCount, 3);
    expect(typewriter.isRepeatingAnimation, true);
  });

}

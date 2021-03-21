import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element as if it is being typed one
/// character at a time. Similar to [TyperAnimatedText], but shows a cursor.
///
/// ![Typewriter example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typewriter.gif)
class TypewriterAnimatedText extends AnimatedText {
  // The text length is padded to cause extra cursor blinking after typing.
  static const extraLengthForBlinks = 8;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 30 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  TypewriterAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    this.speed = const Duration(milliseconds: 30),
    this.curve = Curves.linear,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * (text.characters.length + extraLengthForBlinks),
        );

  late Animation<double> _typewriterText;

  @override
  Duration get remaining =>
      speed *
      (textCharacters.length + extraLengthForBlinks - _typewriterText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typewriterText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  @override
  Widget completeText() => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: text),
            TextSpan(
              text: '_',
              style: textStyle.copyWith(color: Colors.transparent),
            )
          ],
          style: textStyle,
        ),
        textAlign: textAlign,
      );

  /// Widget showing partial text
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length + extraLengthForBlinks].
    final textLen = textCharacters.length;
    final typewriterValue = (_typewriterText.value.clamp(0, 1) *
            (textCharacters.length + extraLengthForBlinks))
        .round();

    var visibleString = text;
    Color? suffixColor = Colors.transparent;
    if (typewriterValue == 0) {
      visibleString = '';
    } else if (typewriterValue > textLen) {
      suffixColor = (typewriterValue - textLen) % 2 == 0
          ? textStyle.color
          : Colors.transparent;
    } else {
      visibleString = textCharacters.take(typewriterValue).toString();
      suffixColor = textStyle.color;
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: visibleString),
          TextSpan(
            text: '_',
            style: textStyle.copyWith(color: suffixColor),
          )
        ],
        style: textStyle,
      ),
      textAlign: textAlign,
    );
  }
}

/// Animation that displays [text] elements, as if they are being typed one
/// character at a time. Similar to [TyperAnimatedTextKit], but shows a cursor.
///
/// ![Typewriter example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typewriter.gif)
@Deprecated('Use AnimatedTextKit with TypewriterAnimatedText instead.')
class TypewriterAnimatedTextKit extends AnimatedTextKit {
  TypewriterAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    Duration speed = const Duration(milliseconds: 30),
    Duration pause = const Duration(milliseconds: 1000),
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    bool repeatForever = true,
    int totalRepeatCount = 3,
    Curve curve = Curves.linear,
  }) : super(
          key: key,
          animatedTexts:
              _animatedTexts(text, textAlign, textStyle, speed, curve),
          pause: pause,
          displayFullTextOnTap: displayFullTextOnTap,
          stopPauseOnTap: stopPauseOnTap,
          onTap: onTap,
          onNext: onNext,
          onNextBeforePause: onNextBeforePause,
          onFinished: onFinished,
          isRepeatingAnimation: isRepeatingAnimation,
          repeatForever: repeatForever,
          totalRepeatCount: totalRepeatCount,
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle textStyle,
    Duration speed,
    Curve curve,
  ) =>
      text
          .map((_) => TypewriterAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
                curve: curve,
              ))
          .toList();
}

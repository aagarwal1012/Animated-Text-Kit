import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element, as a flickering glow text.
///
/// ![Flicker example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/flicker.gif)
class FlickerAnimatedText extends AnimatedText {
  /// Marks ending of flickering entry interval of text
  final double entryEnd;
  final Duration speed;

  FlickerAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    super.textStyle,
    this.speed = const Duration(milliseconds: 1600),
    this.entryEnd = 0.5,
  }) : super(
          text: text,
          duration: speed,
        );

  late Animation<double> _entry;

  @override
  void initAnimation(AnimationController controller) {
    _entry = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, entryEnd, curve: Curves.bounceIn),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _entry.value != 1.0 ? _entry.value : _entry.value,
      child: textWidget(text),
    );
  }
}

@Deprecated('Use AnimatedTextKit with FlickerAnimatedText instead.')
class FlickerAnimatedTextKit extends AnimatedTextKit {
  FlickerAnimatedTextKit({
    super.key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    TextDirection textDirection = TextDirection.ltr,
    Duration speed = const Duration(milliseconds: 1600),
    double entryEnd = 0.5,
    super.onTap,
    super.onNext,
    super.onNextBeforePause,
    super.onFinished,
    super.isRepeatingAnimation,
    super.totalRepeatCount,
    super.repeatForever,
    super.displayFullTextOnTap,
    super.stopPauseOnTap,
  }) : super(
          animatedTexts:
              _animatedTexts(text, textAlign, textStyle, speed, entryEnd),
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle? textStyle,
    Duration speed,
    double entryEnd,
  ) =>
      text
          .map((text) => FlickerAnimatedText(
                text,
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
                entryEnd: entryEnd,
              ))
          .toList();
}

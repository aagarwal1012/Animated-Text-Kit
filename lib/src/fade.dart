import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element, fading it in and then out.
///
/// ![Fade example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/fade.gif)
class FadeAnimatedText extends AnimatedText {
  double fadeInEnd, fadeOutStart;

  FadeAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.fadeInEnd = 0.5,
    this.fadeOutStart = 0.8
    }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn, _fadeOut;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, fadeInEnd, curve: Curves.linear),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(fadeOutStart, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  Widget completeText() => SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
      child: textWidget(text),
    );
  }
}

/// Animation that displays [text] elements, fading them in and then out.
///
/// ![Fade example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/fade.gif)
class FadeAnimatedTextKit extends AnimatedTextKit {
  FadeAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    Duration pause = const Duration(milliseconds: 500),
    double fadeInEnd = 0.5,
    double fadeOutStart = 0.8,
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    int totalRepeatCount = 3,
    bool repeatForever = false,
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
  }) : assert(fadeInEnd < fadeOutStart, 'The "fadeInEnd" argument has to be lesser than "fadeOutStart"'), 
      super(
        key: key,
        animatedTexts: _animatedTexts(text, textAlign, textStyle, duration, fadeInEnd, fadeOutStart),
        pause: pause,
        displayFullTextOnTap: displayFullTextOnTap,
        stopPauseOnTap: stopPauseOnTap,
        onTap: onTap,
        onNext: onNext,
        onNextBeforePause: onNextBeforePause,
        onFinished: onFinished,
        isRepeatingAnimation: isRepeatingAnimation,
        totalRepeatCount: totalRepeatCount,
        repeatForever: repeatForever,
      );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle textStyle,
    Duration duration,
    double fadeInEnd,
    double fadeOutStart
  ) =>
      text
          .map((_) => FadeAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                duration: duration,
                fadeInEnd: fadeInEnd,
                fadeOutStart: fadeOutStart
              ))
          .toList();
}

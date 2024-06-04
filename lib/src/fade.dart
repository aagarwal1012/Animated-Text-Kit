import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element, fading it in and then out.
///
/// ![Fade example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/fade.gif)
class FadeAnimatedText extends AnimatedText {
  /// The Duration of fade-in animation, default value = const Duration(milliseconds: 1000)
  /// Total duration = fadeInDuration + holdDuration + fadeOutDuration
  final Duration fadeInDuration;

  /// The Duration of text hold between fadein and fadeout, default value = const Duration(milliseconds: 2000)
  /// Total duration = fadeInDuration + holdDuration + fadeOutDuration
  final Duration holdDuration;

  /// The Duration of fade-out animation, default value = const Duration(milliseconds: 1000)
  /// Total duration = fadeInDuration + holdDuration + fadeOutDuration
  final Duration fadeOutDuration;

  // /// Marks the beginning of fade-out interval, default value = 0.8
  // final Duration fadeOutBegin;
  FadeAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.holdDuration = const Duration(milliseconds: 2000),
    this.fadeInDuration = const Duration(milliseconds: 1000),
    this.fadeOutDuration = const Duration(milliseconds: 1000),
  }) :
        // assert(fadeInEnd < fadeOutBegin,
        //           'The "fadeInEnd" argument must be less than "fadeOutBegin"'),
        super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: fadeInDuration + holdDuration + fadeOutDuration,
        );

  late Animation<double> _fadeIn, _fadeOut;

  @override
  void initAnimation(AnimationController controller) {
    final _fadeOutStartTime =
        (fadeInDuration.inMilliseconds + holdDuration.inMilliseconds);
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
            0.0, fadeInDuration.inMilliseconds / duration.inMilliseconds,
            curve: Curves.linear),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
            _fadeOutStartTime / duration.inMilliseconds,
            (_fadeOutStartTime + fadeOutDuration.inMilliseconds) /
                duration.inMilliseconds.toDouble(),
            curve: Curves.linear),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => SizedBox.shrink();

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
@Deprecated('Use AnimatedTextKit with FadeAnimatedText instead.')
class FadeAnimatedTextKit extends AnimatedTextKit {
  FadeAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    Duration pause = const Duration(milliseconds: 500),
    double fadeInEnd = 0.5,
    double fadeOutBegin = 0.8,
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    int totalRepeatCount = 3,
    bool repeatForever = false,
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
  }) : super(
          key: key,
          animatedTexts: _animatedTexts(
              text, textAlign, textStyle, duration, fadeInEnd, fadeOutBegin),
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
    TextStyle? textStyle,
    Duration duration,
    double fadeInEnd,
    double fadeOutBegin,
  ) =>
      text
          .map((_) => FadeAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                holdDuration: duration,
                // fadeInEnd: fadeInEnd,
                // fadeOutBegin: fadeOutBegin,
              ))
          .toList();
}

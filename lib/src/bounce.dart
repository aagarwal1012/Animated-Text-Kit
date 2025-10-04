import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element with a bouncing effect.
///
/// The text bounces in from below with an elastic curve, creating a playful
/// and dynamic entrance animation.
class BounceAnimatedText extends AnimatedText {
  /// The height from which the text bounces in.
  ///
  /// By default it is set to 50.0.
  final double bounceHeight;

  /// The [Curve] of the bounce animation.
  ///
  /// By default it is set to Curves.elasticOut for a natural bounce effect.
  final Curve curve;

  BounceAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 1500),
    this.bounceHeight = 50.0,
    this.curve = Curves.elasticOut,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _bounce;
  late Animation<double> _fade;

  @override
  void initAnimation(AnimationController controller) {
    _bounce = Tween<double>(begin: bounceHeight, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Transform.translate(
      offset: Offset(0, _bounce.value),
      child: Opacity(
        opacity: _fade.value,
        child: textWidget(text),
      ),
    );
  }
}

/// Animation that displays [text] elements with a bouncing effect, one at a time.
@Deprecated('Use AnimatedTextKit with BounceAnimatedText instead.')
class BounceAnimatedTextKit extends AnimatedTextKit {
  BounceAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    double bounceHeight = 50.0,
    Duration duration = const Duration(milliseconds: 1500),
    Duration pause = const Duration(milliseconds: 1000),
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    int totalRepeatCount = 3,
    bool repeatForever = false,
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
    Curve curve = Curves.elasticOut,
  }) : super(
          key: key,
          animatedTexts: _animatedTexts(
            text,
            textAlign,
            textStyle,
            duration,
            bounceHeight,
            curve,
          ),
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
    double bounceHeight,
    Curve curve,
  ) =>
      text
          .map((text) => BounceAnimatedText(
                text,
                textAlign: textAlign,
                textStyle: textStyle,
                duration: duration,
                bounceHeight: bounceHeight,
                curve: curve,
              ))
          .toList();
}

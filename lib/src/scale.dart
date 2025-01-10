import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element, scaling them up and then out.
///
/// ![Scale example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/scale.gif)
class ScaleAnimatedText extends AnimatedText {
  /// Set the scaling factor of the text for the animation.
  ///
  /// By default it is set to [double] value 0.5
  final double scalingFactor;

  ScaleAnimatedText(
    String text, {
    super.textAlign,
    super.textStyle,
    super.duration = const Duration(milliseconds: 2000),
    this.scalingFactor = 0.5,
  }) : super(
          text: text,
        );

  late Animation<double> _fadeIn, _fadeOut, _scaleIn, _scaleOut;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _scaleIn = Tween<double>(begin: scalingFactor, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _scaleOut = Tween<double>(begin: 1.0, end: scalingFactor).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return ScaleTransition(
      scale: _scaleIn.value != 1.0 ? _scaleIn : _scaleOut,
      child: Opacity(
        opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
        child: textWidget(text),
      ),
    );
  }
}

/// Animation that displays [text] elements, scaling them up and then out, one at a time.
///
/// ![Scale example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/scale.gif)
@Deprecated('Use AnimatedTextKit with ScaleAnimatedText instead.')
class ScaleAnimatedTextKit extends AnimatedTextKit {
  ScaleAnimatedTextKit({
    super.key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    double scalingFactor = 0.5,
    Duration duration = const Duration(milliseconds: 2000),
    super.pause = const Duration(milliseconds: 500),
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
          animatedTexts: _animatedTexts(
            text,
            textAlign,
            textStyle,
            duration,
            scalingFactor,
          ),
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle? textStyle,
    Duration duration,
    double scalingFactor,
  ) =>
      text
          .map((text) => ScaleAnimatedText(
                text,
                textAlign: textAlign,
                textStyle: textStyle,
                duration: duration,
                scalingFactor: scalingFactor,
              ))
          .toList();
}

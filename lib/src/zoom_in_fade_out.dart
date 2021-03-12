import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
/// Animated Text that displays a [Text] element, zooming them in and the text stays after that.
/// Shpuld be used with only one text at a time
/// ![Scale example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/zoomInFadeOut.gif)

class ZoomInFadeOutAnimatedText extends AnimatedText {
  final double scalingFactor;
  ZoomInFadeOutAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    Duration duration = const Duration(milliseconds: 1500),
    this.scalingFactor = 14.0,
  }) : super(
            text: text,
            textAlign: textAlign,
            textStyle: textStyle,
            duration: duration);

  late Animation<double> _fadeIn, _scaleIn;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _scaleIn = Tween<double>(begin: scalingFactor, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget completeText() => textWidget(text);

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return ScaleTransition(
      scale: _scaleIn,
      child: Opacity(opacity: _fadeIn.value,child: textWidget(text)),
    );
  }
}

class ZoomInFadeOutAnimatedTextKit extends AnimatedTextKit{
  ZoomInFadeOutAnimatedTextKit({
     Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.center,
    required TextStyle textStyle,
    double scalingFactor = 14.0,
    Duration duration = const Duration(milliseconds: 1500),
    Duration pause = const Duration(milliseconds: 1500),
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    int totalRepeatCount = 10,
    bool repeatForever = false,
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
  }) : super(
     key: key,
          animatedTexts: _animatedTexts(
            text,
            textAlign,
            textStyle,
            duration,
            scalingFactor,
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
    TextStyle textStyle,
    Duration duration,
    double scalingFactor,
  ) =>
      text
          .map((_) => ZoomInFadeOutAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                duration: duration,
                scalingFactor: scalingFactor,
              ))
          .toList();
  
}
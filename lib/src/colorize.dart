import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that shows text shimmering between [colors].
///
/// ![Colorize example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/colorize.gif)
class ColorizeAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 200 milliseconds.
  final Duration speed;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  final List<Color> colors;

  /// Specifies the [TextDirection] for animation direction.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  ColorizeAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    this.speed = const Duration(milliseconds: 200),
    required this.colors,
    this.textDirection = TextDirection.ltr,
  })  : assert(null != textStyle.fontSize),
        assert(colors.length > 1),
        super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _colorShifter, _fadeIn, _fadeOut;
  // Copy of colors that may be reversed when RTL.
  late List<Color> _colors;

  @override
  void initAnimation(AnimationController controller) {
    // Note: This calculation is the only reason why [textStyle] is required
    final tuning = (300.0 * colors.length) *
        (textStyle!.fontSize! / 24.0) *
        0.75 *
        (textCharacters.length / 15.0);

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.1, curve: Curves.easeOut),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeIn),
      ),
    );

    final colorShift = colors.length * tuning;
    final colorTween = textDirection == TextDirection.ltr
        ? Tween<double>(
            begin: 0.0,
            end: colorShift,
          )
        : Tween<double>(
            begin: colorShift,
            end: 0.0,
          );
    _colorShifter = colorTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    // With RTL, colors need to be reversed to compensate for colorTween
    // counting down instead of up.
    _colors = textDirection == TextDirection.ltr
        ? colors
        : colors.reversed.toList(growable: false);
  }

  @override
  Widget completeText(BuildContext context) {
    final linearGradient = LinearGradient(colors: _colors).createShader(
      Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0),
    );

    return DefaultTextStyle.merge(
      style: textStyle,
      child: Text(
        text,
        style: TextStyle(foreground: Paint()..shader = linearGradient),
        textAlign: textAlign,
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
      child: completeText(context),
    );
  }
}

/// Animation that displays [text] elements, shimmering transition between [colors].
///
/// ![Colorize example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/colorize.gif)
@Deprecated('Use AnimatedTextKit with ColorizeAnimatedText instead.')
class ColorizeAnimatedTextKit extends AnimatedTextKit {
  ColorizeAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
    required TextStyle textStyle,
    required List<Color> colors,
    Duration speed = const Duration(milliseconds: 200),
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
  }) : super(
          key: key,
          animatedTexts: _animatedTexts(
            text,
            textAlign,
            textStyle,
            speed,
            colors,
            textDirection,
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
    Duration speed,
    List<Color> colors,
    TextDirection textDirection,
  ) =>
      text
          .map((_) => ColorizeAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
                colors: colors,
                textDirection: textDirection,
              ))
          .toList();
}

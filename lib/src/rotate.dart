import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that rotates a [Text] in and then out.
///
/// ![Rotate example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/rotate.gif)
class RotateAnimatedText extends AnimatedText {
  /// Transition height.
  ///
  /// By default it is set to [TextStyle.fontSize] * 10 / 3.
  final double transitionHeight;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [Alignment.center]
  final AlignmentGeometry alignment;

  /// Specifies the [TextDirection] for resolving alignment.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  /// Effective Transition Height
  final double _transitionHeight;

  RotateAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    @required TextStyle textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.transitionHeight,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
  })  : assert(null != alignment),
        assert(null != textDirection),
        _transitionHeight = transitionHeight ?? (textStyle.fontSize * 10 / 3),
        super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  Animation<double> _fadeIn, _fadeOut;
  Animation<Alignment> _slideIn, _slideOut;

  @override
  void initAnimation(AnimationController controller) {
    final direction = textDirection;

    _slideIn = AlignmentTween(
      begin: Alignment.topLeft.add(alignment).resolve(direction),
      end: Alignment.centerLeft.add(alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.4, curve: Curves.linear),
      ),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _slideOut = AlignmentTween(
      begin: Alignment.centerLeft.add(alignment).resolve(direction),
      end: Alignment.bottomLeft.add(alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1.0, curve: Curves.linear),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget completeText() => SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget child) {
    return SizedBox(
      height: _transitionHeight,
      child: AlignTransition(
        alignment: _slideIn.value.y != 0.0 ? _slideIn : _slideOut,
        child: Opacity(
          opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
          child: textWidget(text),
        ),
      ),
    );
  }
}

/// Animation that displays [text] elements, rotating them in one at a time.
///
/// ![Rotate example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/rotate.gif)
class RotateAnimatedTextKit extends AnimatedTextKit {
  RotateAnimatedTextKit({
    Key key,
    @required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle textStyle,
    double transitionHeight,
    AlignmentGeometry alignment = Alignment.center,
    TextDirection textDirection = TextDirection.ltr,
    Duration duration = const Duration(milliseconds: 2000),
    Duration pause = const Duration(milliseconds: 500),
    VoidCallback onTap,
    void Function(int, bool) onNext,
    void Function(int, bool) onNextBeforePause,
    VoidCallback onFinished,
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
            duration,
            transitionHeight,
            alignment,
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
    Duration duration,
    double transitionHeight,
    AlignmentGeometry alignment,
    TextDirection textDirection,
  ) =>
      text
          .map((_) => RotateAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                duration: duration,
                transitionHeight: transitionHeight,
                alignment: alignment,
                textDirection: textDirection,
              ))
          .toList();
}

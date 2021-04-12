import 'package:flutter/material.dart';
import 'animated_text.dart';

/// Animated Text that displays a [Text] element, as a flickering glow text.
///
/// ![Flicker example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/flicker.gif)
class FlickerAnimatedText extends AnimatedText {
  /// Marks ending of flickering entry interval of text
  final double entryEnd;

  FlickerAnimatedText(
    String text, {
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 1600),
    this.entryEnd = 0.5,
  }) : super(
          text: text,
          textStyle: textStyle,
          duration: duration,
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

class FlickerAnimatedTextKit extends AnimatedTextKit {
  FlickerAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextStyle? textStyle,
    VoidCallback? onTap,
  }) : super(
          key: key,
          animatedTexts: _animatedTexts(text, textStyle),
          onTap: onTap,
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextStyle? textStyle,
  ) =>
      text
          .map((_) => FlickerAnimatedText(
                _,
                textStyle: textStyle,
              ))
          .toList();
}

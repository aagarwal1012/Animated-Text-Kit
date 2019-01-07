import 'package:flutter/material.dart';

abstract class GenericAnimatedTextKit extends StatefulWidget {
  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback onTap;
  final AlignmentGeometry alignment;
  final TextAlign textAlign;
  final bool isRepeatingAnimation;

  const GenericAnimatedTextKit(
      {Key key,
      @required this.text,
      this.textStyle,
      this.duration,
      this.onTap,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.isRepeatingAnimation})
      : assert(text != null),
        assert(alignment != null),
        assert(textAlign != null),
        assert(isRepeatingAnimation != null),
        super(key: key);

  @override
  GenericAnimatedTextKitState createState();
}

abstract class GenericAnimatedTextKitState<T extends GenericAnimatedTextKit>
    extends State<T> {
  Duration duration;
  AnimationController controller;

  List<Widget> textWidgetList = [];

  void setup();

  Widget buildLayout(BuildContext context);

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildLayout(context);
  }
}

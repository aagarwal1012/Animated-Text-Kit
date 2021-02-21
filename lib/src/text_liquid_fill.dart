import 'dart:math';
import 'package:flutter/material.dart';

/// Animation that displays a [text] element, coloring it to look like sloshing
/// water is filling it up.
///
/// ![TextLiquidFill example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/text_liquid_fill.gif)
class TextLiquidFill extends StatefulWidget {
  /// Gives [TextStyle] to the text string.
  ///
  /// By default it is `TextStyle(fontSize: 140, fontWeight: FontWeight.bold)`
  final TextStyle textStyle;

  /// Gives [TextAlign] to the text string.
  ///
  /// By default it is [TextAlign.left].
  final TextAlign textAlign;

  /// Specifies the duration the text should fill with liquid.
  ///
  /// By default it is set to 6 seconds.
  final Duration loadDuration;

  /// Specifies the duration that one wave takes to pass the screen.
  ///
  /// By default it is set to 2 seconds.
  final Duration waveDuration;

  /// Specifies the height of the box around text
  ///
  /// By default it is set to 250
  final double boxHeight;

  /// Specifies the width of the box around text
  ///
  /// By default it is set to 400
  final double boxWidth;

  /// String which would be filled by liquid animation
  final String text;

  /// Specifies the backgroundColor of the box
  ///
  /// By default it is set to black color
  final Color boxBackgroundColor;

  /// Specifies the color of the wave
  ///
  /// By default it is set to blueAccent color
  final Color waveColor;

  /// Specifies the load limit: (0, 1.0].  This may be used to limit the liquid
  /// fill effect to less than 100%.
  ///
  /// By default, the animation will load to 1.0 (100%).
  final double loadUntil;

  TextLiquidFill({
    Key? key,
    required this.text,
    this.textStyle =
        const TextStyle(fontSize: 140, fontWeight: FontWeight.bold),
    this.textAlign = TextAlign.left,
    this.loadDuration = const Duration(seconds: 6),
    this.waveDuration = const Duration(seconds: 2),
    this.boxHeight = 250,
    this.boxWidth = 400,
    this.boxBackgroundColor = Colors.black,
    this.waveColor = Colors.blueAccent,
    this.loadUntil = 1.0,
  })  : assert(loadUntil > 0 && loadUntil <= 1.0),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  _TextLiquidFillState createState() => _TextLiquidFillState();
}

class _TextLiquidFillState extends State<TextLiquidFill>
    with TickerProviderStateMixin {
  final _textKey = GlobalKey();

  late AnimationController _waveController, _loadController;

  late Animation<double> _loadValue;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: widget.waveDuration,
    );

    _loadController = AnimationController(
      vsync: this,
      duration: widget.loadDuration,
    );
    _loadValue = Tween<double>(
      begin: 0.0,
      end: widget.loadUntil,
    ).animate(_loadController);
    if (1.0 == widget.loadUntil) {
      _loadValue.addStatusListener((status) {
        if (AnimationStatus.completed == status) {
          // Stop the repeating wave when the load has completed to 100%
          _waveController.stop();
        }
      });
    }

    _waveController.repeat();
    _loadController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _loadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: widget.boxHeight,
          width: widget.boxWidth,
          child: AnimatedBuilder(
            animation: _waveController,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                painter: _WavePainter(
                  textKey: _textKey,
                  waveValue: _waveController.value,
                  loadValue: _loadValue.value,
                  boxHeight: widget.boxHeight,
                  waveColor: widget.waveColor,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: widget.boxHeight,
          width: widget.boxWidth,
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) => LinearGradient(
              colors: [widget.boxBackgroundColor],
              stops: [0.0],
            ).createShader(bounds),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  widget.text,
                  key: _textKey,
                  style: widget.textStyle,
                  textAlign: widget.textAlign,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  static const _pi2 = 2 * pi;
  final GlobalKey textKey;
  final double waveValue;
  final double loadValue;
  final double boxHeight;
  final Color waveColor;

  _WavePainter({
    required this.textKey,
    required this.waveValue,
    required this.loadValue,
    required this.boxHeight,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox? textBox =
        textKey.currentContext!.findRenderObject() as RenderBox;
    if (textBox == null) return;
    final textHeight = textBox.size.height;
    final baseHeight =
        (boxHeight / 2) + (textHeight / 2) - (loadValue * textHeight);

    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(0.0, baseHeight);
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, baseHeight + sin(_pi2 * (i / width + waveValue)) * 8);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    final wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

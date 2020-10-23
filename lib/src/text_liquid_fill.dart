import 'package:flutter/material.dart';
import 'dart:math';

class TextLiquidFill extends StatefulWidget {
  /// Gives [TextStyle] to the text string.
  final TextStyle textStyle;

  /// Gives [TextAlign] to the text string.
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

  TextLiquidFill(
      {Key key,
      @required this.text,
      this.textStyle,
      this.textAlign,
      this.loadDuration,
      this.waveDuration,
      this.boxHeight,
      this.boxWidth,
      this.boxBackgroundColor,
      this.waveColor})
      : super(key: key);

  @override
  _TextLiquidFillState createState() => _TextLiquidFillState();
}

class _TextLiquidFillState extends State<TextLiquidFill>
    with TickerProviderStateMixin {
  final _textKey = GlobalKey();

  AnimationController _waveController, _loadController;
  Duration _waveDuration, _loadDuration;

  Animation _loadValue;

  double _boxHeight, _boxWidth;

  Color _boxBackgroundColor, _waveColor;

  TextStyle _textStyle;

  TextAlign _textAlign;

  @override
  void initState() {
    super.initState();

    _boxHeight = widget.boxHeight ?? 250;

    _boxWidth = widget.boxWidth ?? 400;

    _waveDuration = widget.waveDuration ?? const Duration(milliseconds: 2000);

    _loadDuration = widget.loadDuration ?? const Duration(milliseconds: 6000);

    _waveController = AnimationController(vsync: this, duration: _waveDuration);

    _loadController = AnimationController(vsync: this, duration: _loadDuration);

    _loadValue = Tween<double>(begin: 0.0, end: 100.0).animate(_loadController);

    _boxBackgroundColor = widget.boxBackgroundColor ?? Colors.black;
    _waveColor = widget.waveColor ?? Colors.blueAccent;

    _textStyle = widget.textStyle ??
        const TextStyle(fontSize: 140, fontWeight: FontWeight.bold);

    _textAlign = widget.textAlign ?? TextAlign.left;

    _waveController.repeat();
    _loadController.forward();
  }

  @override
  void dispose() {
    _waveController?.stop();
    _waveController?.dispose();
    _loadController?.stop();
    _loadController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: _boxHeight,
          width: _boxWidth ?? MediaQuery.of(context).size.width,
          child: AnimatedBuilder(
            animation: _waveController,
            builder: (BuildContext context, Widget child) {
              return CustomPaint(
                painter: WavePainter(
                    textKey: _textKey,
                    waveAnimation: _waveController,
                    percentValue: _loadValue.value,
                    boxHeight: _boxHeight,
                    waveColor: _waveColor),
              );
            },
          ),
        ),
        SizedBox(
          height: _boxHeight,
          width: _boxWidth ?? MediaQuery.of(context).size.width,
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) =>
                LinearGradient(colors: [_boxBackgroundColor], stops: [0.0])
                    .createShader(bounds),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  widget.text,
                  key: _textKey,
                  style: _textStyle,
                  textAlign: _textAlign,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  final _pi2 = 2 * pi;
  final GlobalKey textKey;
  final Animation<double> waveAnimation;
  final double percentValue;
  final double boxHeight;
  final Color waveColor;

  WavePainter({
    @required this.textKey,
    this.waveAnimation,
    this.percentValue,
    this.boxHeight,
    this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox textBox = textKey.currentContext.findRenderObject();
    final textHeight = textBox.size.height;
    final percent = percentValue / 100.0;
    final baseHeight =
        (boxHeight / 2) + (textHeight / 2) - (percent * textHeight);

    final width = size.width ?? 200;
    final height = size.height ?? 200;
    final path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < width; i++) {
      path.lineTo(
        i,
        baseHeight + sin((i / width * _pi2) + (waveAnimation.value * _pi2)) * 8,
      );
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

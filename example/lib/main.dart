import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      print('Tap Event');
      setState(() {
        _tapCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          animatedTextExample.label,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(color: animatedTextExample.color),
            height: 300.0,
            width: 300.0,
            child: Center(
              key: ValueKey(animatedTextExample.label),
              child: animatedTextExample.child,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text('Taps: $_tapCount'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _index = ++_index % _examples.length;
            _tapCount = 0;
          });
        },
        tooltip: 'Next',
        child: const Icon(
          Icons.play_circle_filled,
          size: 50.0,
        ),
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;
  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

// Rotate Text Style
const _textStyleHorizon40 = TextStyle(
  fontSize: 40.0,
  fontFamily: 'Horizon',
);

// Fade Text Style
const _textStyleBold32 = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

// Typer Text Style
const _textStyleBobbers30 = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Bobbers',
);

// Typewriter Text Style
const _textStyleAgne30 = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Agne',
);

// Scale Text Style
const _textStyleCanterbury70 = TextStyle(
  fontSize: 70.0,
  fontFamily: 'Canterbury',
);

// Colorize Text Style
const _textStyleHorizon50 = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

// Colorize Colors
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

// Wavy Text Style
const _textStyleDefault20 = TextStyle(fontSize: 20);

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) =>
    <AnimatedTextExample>[
      AnimatedTextExample(
        label: 'Rotate',
        color: Colors.orange[800],
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                const Text(
                  'Be',
                  style: TextStyle(fontSize: 43.0),
                ),
                const SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'AWESOME',
                      textStyle: _textStyleHorizon40,
                    ),
                    RotateAnimatedText(
                      'OPTIMISTIC',
                      textStyle: _textStyleHorizon40,
                    ),
                    RotateAnimatedText(
                      'DIFFERENT',
                      textStyle: _textStyleHorizon40,
                    ),
                  ],
                  onTap: onTap,
                  isRepeatingAnimation: true,
                  totalRepeatCount: 10,
                ),
              ],
            ),
          ],
        ),
      ),
      AnimatedTextExample(
        label: 'Fade',
        color: Colors.brown[600],
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText(
              'do IT!',
              textStyle: _textStyleBold32,
            ),
            FadeAnimatedText(
              'do it RIGHT!!',
              textStyle: _textStyleBold32,
            ),
            FadeAnimatedText(
              'do it RIGHT NOW!!!',
              textStyle: _textStyleBold32,
            ),
          ],
          onTap: onTap,
        ),
      ),
      AnimatedTextExample(
        label: 'Typer',
        color: Colors.lightGreen[800],
        child: SizedBox(
          width: 250.0,
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'It is not enough to do your best,',
                textStyle: _textStyleBobbers30,
              ),
              TyperAnimatedText(
                'you must know what to do,',
                textStyle: _textStyleBobbers30,
              ),
              TyperAnimatedText(
                'and then do your best',
                textStyle: _textStyleBobbers30,
              ),
              TyperAnimatedText(
                '- W.Edwards Deming',
                textStyle: _textStyleBobbers30,
              ),
            ],
            onTap: onTap,
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Typewriter',
        color: Colors.teal[700],
        child: SizedBox(
          width: 250.0,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Discipline is the best tool',
                textStyle: _textStyleAgne30,
              ),
              TypewriterAnimatedText(
                'Design first, then code',
                textStyle: _textStyleAgne30,
              ),
              TypewriterAnimatedText(
                'Do not patch bugs out, rewrite them',
                textStyle: _textStyleAgne30,
              ),
              TypewriterAnimatedText(
                'Do not test bugs out, design them out',
                textStyle: _textStyleAgne30,
              ),
            ],
            onTap: onTap,
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Scale',
        color: Colors.blue[700],
        child: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText(
              'Think',
              textStyle: _textStyleCanterbury70,
            ),
            ScaleAnimatedText(
              'Build',
              textStyle: _textStyleCanterbury70,
            ),
            ScaleAnimatedText(
              'Ship',
              textStyle: _textStyleCanterbury70,
            ),
          ],
          onTap: onTap,
        ),
      ),
      AnimatedTextExample(
        label: 'Colorize',
        color: Colors.blueGrey[50],
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Larry Page',
              textStyle: _textStyleHorizon50,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Bill Gates',
              textStyle: _textStyleHorizon50,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Steve Jobs',
              textStyle: _textStyleHorizon50,
              colors: _colorizeColors,
            ),
          ],
          onTap: onTap,
        ),
      ),
      AnimatedTextExample(
        label: 'TextLiquidFill',
        color: Colors.white,
        child: TextLiquidFill(
          text: 'LIQUIDY',
          waveColor: Colors.blueAccent,
          boxBackgroundColor: Colors.redAccent,
          textStyle: const TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
          boxHeight: 300,
        ),
      ),
      AnimatedTextExample(
        label: 'Wavy Text',
        color: Colors.black87,
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'Hello World',
              textStyle: _textStyleDefault20,
            ),
            WavyAnimatedText(
              'Look at the waves',
              textStyle: _textStyleDefault20,
            ),
            WavyAnimatedText(
              'They look so Amazing',
              textStyle: _textStyleDefault20,
            ),
          ],
          onTap: onTap,
        ),
      ),
      AnimatedTextExample(
        label: 'Combination',
        color: Colors.pink,
        child: AnimatedTextKit(
          onTap: onTap,
          animatedTexts: [
            WavyAnimatedText(
              'On Your Marks',
              textStyle: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            FadeAnimatedText(
              'Get Set',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ScaleAnimatedText(
              'Ready',
              textStyle: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            RotateAnimatedText(
              'Go!',
              textStyle: const TextStyle(
                fontSize: 64.0,
              ),
              rotateOut: false,
              duration: const Duration(milliseconds: 400),
            )
          ],
        ),
      ),
    ];

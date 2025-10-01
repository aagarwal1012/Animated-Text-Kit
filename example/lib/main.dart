import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;
  int _tapCount = 0;

  bool _isAnimationPaused = false;

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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              animatedTextExample.controller.reset();
              setState(() {
                _isAnimationPaused = false;
                _tapCount = 0;
              });
            },
            tooltip: 'Reset current animation',
            child: const Icon(
              Icons.replay_sharp,
              size: 50.0,
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
              onPressed: () {
                if (_isAnimationPaused) {
                  animatedTextExample.controller.play();
                  setState(() {
                    _isAnimationPaused = false;
                  });
                } else {
                  animatedTextExample.controller.pause();
                  setState(() {
                    _isAnimationPaused = true;
                  });
                }
              },
              tooltip: _isAnimationPaused ? 'Play' : 'Pause',
              child: Icon(
                _isAnimationPaused ? Icons.play_circle : Icons.pause_circle,
                size: 50,
              )),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _index = ++_index % _examples.length;
                _tapCount = 0;
              });
            },
            tooltip: 'Next',
            child: const Icon(
              Icons.arrow_right,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;
  final AnimatedTextController controller;

  const AnimatedTextExample(
      {required this.label,
      required this.color,
      required this.child,
      required this.controller});
}

// Colorize Text Style
const _colorizeTextStyle = TextStyle(
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

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) {
  final rotateController = AnimatedTextController();
  final fadeController = AnimatedTextController();
  final typerController = AnimatedTextController();
  final typewriterController = AnimatedTextController();
  final scaleController = AnimatedTextController();
  final bounceController = AnimatedTextController();
  final colorizeController = AnimatedTextController();
  final textLiquidFillController = AnimatedTextController();
  final wavyTextController = AnimatedTextController();
  final flickerController = AnimatedTextController();
  final combinationController = AnimatedTextController();

  return <AnimatedTextExample>[
    AnimatedTextExample(
      label: 'Rotate',
      color: Colors.orange[800],
      controller: rotateController,
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
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('AWESOME'),
                    RotateAnimatedText('OPTIMISTIC'),
                    RotateAnimatedText(
                      'DIFFERENT',
                      textStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                  controller: rotateController,
                  onTap: onTap,
                  isRepeatingAnimation: true,
                  totalRepeatCount: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    AnimatedTextExample(
      label: 'Fade',
      color: Colors.brown[600],
      controller: fadeController,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText('do IT!'),
            FadeAnimatedText('do it RIGHT!!'),
            FadeAnimatedText('do it RIGHT NOW!!!'),
          ],
          controller: fadeController,
          onTap: onTap,
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Typer',
      color: Colors.lightGreen[800],
      controller: typerController,
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Bobbers',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('It is not enough to do your best,'),
              TyperAnimatedText('you must know what to do,'),
              TyperAnimatedText('and then do your best'),
              TyperAnimatedText('- W.Edwards Deming'),
            ],
            controller: typerController,
            onTap: onTap,
          ),
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Typewriter',
      color: Colors.teal[700],
      controller: typewriterController,
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Agne',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Discipline is the best tool'),
              TypewriterAnimatedText('Design first, then code', cursor: '|'),
              TypewriterAnimatedText('Do not patch bugs out, rewrite them',
                  cursor: '<|>'),
              TypewriterAnimatedText('Do not test bugs out, design them out',
                  cursor: '💡'),
            ],
            controller: typewriterController,
            onTap: onTap,
          ),
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Scale',
      color: Colors.blue[700],
      controller: scaleController,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 70.0,
          fontFamily: 'Canterbury',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText('Think'),
            ScaleAnimatedText('Build'),
            ScaleAnimatedText('Ship'),
          ],
          controller: scaleController,
          onTap: onTap,
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Bounce',
      color: Colors.amber[700],
      controller: bounceController,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 60.0,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            BounceAnimatedText('Bounce!'),
            BounceAnimatedText('Spring!'),
            BounceAnimatedText('Jump!'),
          ],
          controller: bounceController,
          onTap: onTap,
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Colorize',
      color: Colors.blueGrey[50],
      controller: colorizeController,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'Larry Page',
            textStyle: _colorizeTextStyle,
            colors: _colorizeColors,
          ),
          ColorizeAnimatedText(
            'Bill Gates',
            textStyle: _colorizeTextStyle,
            colors: _colorizeColors,
          ),
          ColorizeAnimatedText(
            'Steve Jobs',
            textStyle: _colorizeTextStyle,
            colors: _colorizeColors,
          ),
        ],
        controller: colorizeController,
        onTap: onTap,
      ),
    ),
    AnimatedTextExample(
      label: 'TextLiquidFill',
      color: Colors.white,
      controller: textLiquidFillController,
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
      color: Colors.purple,
      controller: wavyTextController,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'Hello World',
              textStyle: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            WavyAnimatedText('Look at the waves'),
            WavyAnimatedText('They look so Amazing'),
          ],
          controller: wavyTextController,
          onTap: onTap,
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Flicker',
      color: Colors.pink[300],
      controller: flickerController,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 35,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: Colors.white,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('Flicker Frenzy'),
            FlickerAnimatedText('Night Vibes On'),
            FlickerAnimatedText("C'est La Vie !"),
          ],
          onTap: onTap,
          controller: flickerController,
        ),
      ),
    ),
    AnimatedTextExample(
      label: 'Combination',
      color: Colors.pink,
      controller: combinationController,
      child: AnimatedTextKit(
        onTap: onTap,
        controller: combinationController,
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
}

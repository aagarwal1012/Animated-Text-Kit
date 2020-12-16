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
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AnimatedTextExample> _examples;
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
            child: Center(child: animatedTextExample.child),
            height: 300.0,
            width: 300.0,
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
  final Color color;
  final Widget child;
  const AnimatedTextExample({
    @required this.label,
    @required this.color,
    @required this.child,
  });
}

List<AnimatedTextExample> animatedTextExamples({VoidCallback onTap}) =>
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
                RotateAnimatedTextKit(
                  onTap: onTap,
                  isRepeatingAnimation: true,
                  totalRepeatCount: 10,
                  text: ['AWESOME', 'OPTIMISTIC', 'DIFFERENT'],
                  textStyle: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Horizon',
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
        child: FadeAnimatedTextKit(
          onTap: onTap,
          text: ['do IT!', 'do it RIGHT!!', 'do it RIGHT NOW!!!'],
          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
      ),
      AnimatedTextExample(
        label: 'Typer',
        color: Colors.lightGreen[800],
        child: SizedBox(
          width: 250.0,
          child: TyperAnimatedTextKit(
            onTap: onTap,
            text: [
              'It is not enough to do your best,',
              'you must know what to do,',
              'and then do your best',
              '- W.Edwards Deming',
            ],
            textStyle: const TextStyle(
              fontSize: 30.0,
              fontFamily: 'Bobbers',
            ),
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Typewriter',
        color: Colors.teal[700],
        child: SizedBox(
          width: 250.0,
          child: TypewriterAnimatedTextKit(
            onTap: onTap,
            text: [
              'Discipline is the best tool',
              'Design first, then code',
              'Do not patch bugs out, rewrite them',
              'Do not test bugs out, design them out',
            ],
            textStyle: const TextStyle(
              fontSize: 30.0,
              fontFamily: 'Agne',
            ),
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Scale',
        color: Colors.blue[700],
        child: ScaleAnimatedTextKit(
          onTap: onTap,
          text: ['Think', 'Build', 'Ship'],
          textStyle: const TextStyle(
            fontSize: 70.0,
            fontFamily: 'Canterbury',
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Colorize',
        color: Colors.blueGrey[50],
        child: ColorizeAnimatedTextKit(
          onTap: onTap,
          text: [
            'Larry Page',
            'Bill Gates',
            'Steve Jobs',
          ],
          textStyle: const TextStyle(
            fontSize: 50.0,
            fontFamily: 'Horizon',
          ),
          colors: [
            Colors.purple,
            Colors.blue,
            Colors.yellow,
            Colors.red,
          ],
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
        child: WavyAnimatedTextKit(
          onTap: onTap,
          textStyle: const TextStyle(fontSize: 20),
          text: [
            'Hello World',
            'Look at the waves',
            'They look so Amazing',
          ],
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

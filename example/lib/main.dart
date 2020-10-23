import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

const List<String> labels = [
  'Rotate',
  'Fade',
  'Typer',
  'Typewriter',
  'Scale',
  'Colorize',
  'TextLiquidFill',
  'Wavy Text'
];

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Animated Text Kit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textAnimationKit = <Widget>[
    ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 20.0,
              height: 100.0,
            ),
            Text(
              'Be',
              style: TextStyle(fontSize: 43.0),
            ),
            SizedBox(
              width: 20.0,
              height: 100.0,
            ),
            RotateAnimatedTextKit(
              onTap: () {
                print('Tap Event');
              },
              isRepeatingAnimation: true,
              totalRepeatCount: 10,
              text: ['AWESOME', 'OPTIMISTIC', 'DIFFERENT'],
              // alignment: Alignment(1.0, 0.5),
              textStyle: TextStyle(fontSize: 40.0, fontFamily: 'Horizon'),
            ),
          ],
        ),
      ],
    ),
    FadeAnimatedTextKit(
      onTap: () {
        print('Tap Event');
      },
      text: ['do IT!', 'do it RIGHT!!', 'do it RIGHT NOW!!!'],
      textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      width: 250.0,
      child: TyperAnimatedTextKit(
        onTap: () {
          print('Tap Event');
        },
        text: [
          'It is not enough to do your best,',
          'you must know what to do,',
          'and then do your best',
          '- W.Edwards Deming',
        ],
        textStyle: TextStyle(fontSize: 30.0, fontFamily: 'Bobbers'),
      ),
    ),
    SizedBox(
      width: 250.0,
      child: TypewriterAnimatedTextKit(
        onTap: () {
          print('Tap Event');
        },
        text: [
          'Discipline is the best tool',
          'Design first, then code',
          'Do not patch bugs out, rewrite them',
          'Do not test bugs out, design them out',
        ],
        textStyle: TextStyle(fontSize: 30.0, fontFamily: 'Agne'),
      ),
    ),
    ScaleAnimatedTextKit(
      onTap: () {
        print('Tap Event');
      },
      text: ['Think', 'Build', 'Ship'],
      textStyle: TextStyle(fontSize: 70.0, fontFamily: 'Canterbury'),
    ),

    /// colors.length >= 2
    ColorizeAnimatedTextKit(
      onTap: () {
        print('Tap Event');
      },
      text: [
        'Larry Page',
        'Bill Gates',
        'Steve Jobs',
      ],
      textStyle: TextStyle(fontSize: 50.0, fontFamily: 'Horizon'),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
    ),

    Center(
      child: TextLiquidFill(
        text: 'LIQUIDY',
        waveColor: Colors.blueAccent,
        boxBackgroundColor: Colors.redAccent,
        textStyle: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        boxHeight: 300,
      ),
    ),

    WavyAnimatedTextKit(
      textStyle: TextStyle(fontSize: 20),
      text: [
        'Hello World',
        'Look at the waves',
        'They look so Amazing',
      ],
    ),
  ];

  final _colors = <Color>[
    Colors.orange[800],
    Colors.brown[600],
    Colors.lightGreen[800],
    Colors.teal[700],
    Colors.blue[700],
    Colors.blueGrey[50],
    Colors.white,
    Colors.black87,
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            width: double.maxFinite,
          ),
          Text(
            labels[_index],
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(color: _colors[_index]),
            child: Center(child: _textAnimationKit[_index]),
            height: 300.0,
            width: 300.0,
          ),
          Expanded(
            child: Container(),
          ),
          InkWell(
            child: Icon(
              Icons.play_circle_filled,
              size: 70.0,
            ),
            onTap: () {
              setState(() {
                _index = ++_index % _textAnimationKit.length;
              });
            },
          ),
          SizedBox(
            height: 20.0,
            width: double.maxFinite,
          ),
        ],
      ),
    );
  }
}

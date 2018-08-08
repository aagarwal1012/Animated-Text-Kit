import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: new MyHomePage(title: 'Animated Text Kit'),
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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _textAnimationKit = [
    RotateAnimatedTextKit(
      text: ["Dart", "Flutter", "What can you do with them ?"],
      textStyle: TextStyle(fontSize: 30.0),
    ),
    FadeAnimatedTextKit(
      text: ["Dart", "Flutter", "What can you do with them ?"],
      textStyle: TextStyle(fontSize: 30.0),
    ),
    TyperAnimatedTextKit(
      text: [
        "It is not enough to do your best",
        " you must know what to do",
        "and then do your best",
        "- W.Edwards Deming",
      ],
      textStyle: TextStyle(fontSize: 30.0),
    ),
    TypewriterAnimatedTextKit(
      text: ["Dart", "Flutter", "What can you do with them ?"],
      textStyle: TextStyle(fontSize: 30.0),
    ),
    ScaleAnimatedTextKit(
      text: ["Dart", "Flutter", "What can you do with them ?"],
      textStyle: TextStyle(fontSize: 30.0),
    ),
    /// colors.length >= 2
    ColorizeAnimatedTextKit(
      text: ["Dart", "Flutter", "What can you do with them ?"],
      textStyle: TextStyle(
          fontSize: 30.0),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
    ),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[

          Positioned.fill(
            child: Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.orange[900]),
                child: Center(child: _textAnimationKit[_index]),
                height: 300.0,
                width: 300.0,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
                icon: Container(
                  child: Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 70.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _index = (_index + 1) % _textAnimationKit.length;
                  });
                }
            ),
          ),

        ],
      ),
    );
  }
}

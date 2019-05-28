# Usage

You can override the `duration` of each animation by setting its duration in each AnimatedTextKit class, also you can set if the animation should not repeat by changing the value of `isRepeatingAnimation` to false. For example:
```dart
FadeAnimatedTextKit(
  duration: Duration(milliseconds: 5000),
  isRepeatingAnimation: false,
  text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
  textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
);
```

## Rotate

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/rotate.gif?raw=true" align = "right" height = "300px">

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    SizedBox(width: 20.0, height: 100.0),
    Text(
      "Be",
      style: TextStyle(fontSize: 43.0),
    ),
    SizedBox(width: 20.0, height: 100.0),
    RotateAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
      textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
      textAlign: TextAlign.start,
      alignment: AlignmentDirectional.topStart // or Alignment.topLeft
    ),
  ],
);
```
**Note:** You can override transition height by setting the value of parameter `transitionHeight` for RotateAnimatedTextKit class.

## Fade

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/fade.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: FadeAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "do IT!",
      "do it RIGHT!!",
      "do it RIGHT NOW!!!"
    ],
    textStyle: TextStyle(
        fontSize: 32.0, 
        fontWeight: FontWeight.bold
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
```

## Typer

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typer.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: TyperAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "It is not enough to do your best,",
      "you must know what to do,",
      "and then do your best",
      "- W.Edwards Deming",
    ],
    textStyle: TextStyle(
        fontSize: 30.0,
        fontFamily: "Bobbers"
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
```
## Typewriter

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typewriter.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: TypewriterAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "Discipline is the best tool",
      "Design first, then code",
      "Do not patch bugs out, rewrite them",
      "Do not test bugs out, design them out",
    ],
    textStyle: TextStyle(
        fontSize: 30.0,
        fontFamily: "Agne"
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
```

## Scale

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/scale.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: ScaleAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "Think",
      "Build",
      "Ship"
      ],
    textStyle: TextStyle(
        fontSize: 70.0,
        fontFamily: "Canterbury"
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
```

## Colorize

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/colorize.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: ColorizeAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "Larry Page",
      "Bill Gates",
      "Steve Jobs",
    ],
    textStyle: TextStyle(
        fontSize: 50.0, 
        fontFamily: "Horizon"
    ),
    colors: [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ],
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
```
**Note:** `colors` list should contains at least two values. 
<div align="center"><img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/cover.gif?raw=true"/></div>

# Animated Text Kit
[![platform](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.io)
[![Build Status](https://travis-ci.com/aagarwal1012/Animated-Text-Kit.svg?token=pXLTRcXnVLpccbxqiWBi&branch=master)](https://travis-ci.com/aagarwal1012/Animated-Text-Kit)
[![pub package](https://img.shields.io/pub/v/animated_text_kit.svg)](https://pub.dartlang.org/packages/animated_text_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-orange.svg)](https://opensource.org/licenses/MIT)

Animation Text Kit is a `flutter` package which contains a collection of cool and beautiful text animations for your flutter apps by using some customized animations.

# Installing

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_text_kit: ^1.0.2
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```css
$ pub get
```

with `Flutter`:

```css
$ flutter packages get
```

### 3. Import it

Now in your `Dart` code, you can use: 

```dart
import 'package:animated_text_kit/animated_text_kit.dart';
```


# Usage

You can override the `duration` of each animation by setting duration in each AnimatedTextKit class. For example:
```dart
FadeAnimatedTextKit(
  duration: Duration(milliseconds: 5000),
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
    SizedBox(
      width: 20.0,
      height: 100.0,
    ),
    Text(
      "Be",
      style: TextStyle(fontSize: 43.0),
    ),
    SizedBox(
      width: 20.0,
      height: 100.0,
    ),
    RotateAnimatedTextKit(
      text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
      textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
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
    text: [
      "do IT!",
      "do it RIGHT!!",
      "do it RIGHT NOW!!!"
    ],
    textStyle: TextStyle(
        fontSize: 32.0, 
        fontWeight: FontWeight.bold
    ),
  ),
);
```

## Typer

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typer.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: TyperAnimatedTextKit(
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
  ),
);
```
## Typewriter

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typewriter.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: TypewriterAnimatedTextKit(
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
  ),
);
```

## Scale

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/scale.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: ScaleAnimatedTextKit(
    text: [
      "Think",
      "Build",
      "Ship"
      ],
    textStyle: TextStyle(
        fontSize: 70.0,
        fontFamily: "Canterbury"
    ),
  ),
);
```

## Colorize

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/colorize.gif?raw=true" align = "right" height = "300px">

```dart
SizedBox(
  width: 250.0,
  child: ColorizeAnimatedTextKit(
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
  ),
);
```
**Note:** `colors` list should contains atleast two values, also `ColorizeAnimationTextKit` can be used for flutter `>=0.5.7` which is available in `dev` channel. 

# Bugs or Requests



# License
AnimatedTextKit is licensed under `MIT license`. View [license](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/LICENSE).

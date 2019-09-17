<div align="center"><img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/cover.gif?raw=true"/></div>

# <div align="center">Animated Text Kit</div>
<div align="center">A flutter package which contains a collection of some cool and awesome text animations.</div><br>

<div align="center">
	<a href="https://flutter.io">
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"
      alt="Platform" />
  </a>
  	<a href="https://pub.dartlang.org/packages/animated_text_kit">
    <img src="https://img.shields.io/pub/v/animated_text_kit.svg"
      alt="Pub Package" />
  </a>
  	<a href="https://travis-ci.com/aagarwal1012/Animated-Text-Kit">
    <img src="https://travis-ci.com/aagarwal1012/Animated-Text-Kit.svg?token=pXLTRcXnVLpccbxqiWBi&branch=master"
      alt="Build Status" />
  </a>
  <a href="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit">
    <img src="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit/branch/master/graph/badge.svg"
      alt="Codecov Coverage" />
  </a>
  	<a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-red.svg"
      alt="License: MIT" />
  </a>
  	<a href="https://www.paypal.me/aagarwal1012">
    <img src="https://img.shields.io/badge/Donate-PayPal-green.svg"
      alt="Donate" />
  </a>
</div><br>

# Table of contents

  * [Installing](#installing)
  * [Usage](#usage)
    * [Rotate](#rotate)
  	* [Fade](#fade)
  	* [Typer](#typer)
  	* [Typewriter](#typewriter)
  	* [Scale](#scale)
  	* [Colorize](#colorize)
  * [Bugs or Requests](#bugs-or-requests)
  * [Donate](#donate)
  * [Contributors](#contributors)
  * [License](#license)

# Installing

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_text_kit: ^1.3.1
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

# Bugs or Requests

If you encounter any problems feel free to open an [issue](https://github.com/aagarwal1012/Animated-Text-Kit/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/aagarwal1012/Animated-Text-Kit/issues/new?template=feature_request.md) on GitHub and I'll look into it. Pull request are also welcome. 

See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).

# Donate
> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> - [PayPal](https://www.paypal.me/aagarwal1012/)

# Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="http://salih.dev"><img src="https://avatars2.githubusercontent.com/u/24432752?v=4" width="100px;" alt="Muhammed Salih Guler"/><br /><sub><b>Muhammed Salih Guler</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Asalihgueler" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome! See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).

# License
Animated-Text-Kit is licensed under `MIT license`. View [license](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/LICENSE).

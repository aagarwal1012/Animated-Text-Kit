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
   * [TextLiquidFill](#textliquidfill)
 * [Bugs or Requests](#bugs-or-requests)  
 * [Donate](#donate)  
 * [Contributors](#contributors)  
 * [License](#license)  


# Installing

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_text_kit: ^2.1.0
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

  You can override the `duration` of animation of single text by setting its duration in each AnimatedTextKit class, also you can set the time of the pause between texts by setting the `pause` parameter and with this when `isRepeatingAnimation` is set to true, you can set number of times the animation should repeat with `totalRepeatCount` (or repeat forever with `repeatForever`). The `speed` parameter is also included for some classes which sets the delay between the apparition of each characters. Also, the `displayFullTextOnTap` and `stopPauseOnTap` parameters have been included for some classes.
```dart
TypewriterAnimatedTextKit(
  speed: Duration(milliseconds: 2000),
  totalRepeatCount: 4,
  repeatForever: true, //this will ignore [totalRepeatCount]
  pause: Duration(milliseconds:  1000),
  text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
  textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
  pause: Duration(milliseconds: 1000),
  displayFullTextOnTap: true,
  stopPauseOnTap: true
);
```

Also, different callbacks are added to each AnimatedTextKit class along with the onTap callback:

 - onNext(int index, bool isLast) - This callback will be called before the next text animation, after the previous one's pause.
 - onNextBeforePause(int index, bool isLast) - This callback will be called before the next text animation, before the previous one's pause.
 - onFinished - This callback is called at the end, if the parameter isRepeatingAnimation is set to false.

  

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
      textAlign: TextAlign.start
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

## TextLiquidFill  

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/text_liquid_fill.gif?raw=true" align = "right" height = "300px">  

```dart  
SizedBox(
  width: 250.0,
  child: TextLiquidFill(
        text: 'LIQUIDY',
        waveColor: Colors.blueAccent,
        boxBackgroundColor: Colors.redAccent,
        textStyle: TextStyle(
          fontSize: 80.0,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: 300.0,
  ),
);
```
To get more information about how the animated text made from scratch by @HemilPanchiwala, visit the Medium [blog](https://link.medium.com/AfxVRdkWJ2).  

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
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://salih.dev"><img src="https://avatars2.githubusercontent.com/u/24432752?v=4" width="100px;" alt=""/><br /><sub><b>Muhammed Salih Guler</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Asalihgueler" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/anderscheow"><img src="https://avatars0.githubusercontent.com/u/11788504?v=4" width="100px;" alt=""/><br /><sub><b>Anders Cheow</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aanderscheow" title="Bug reports">🐛</a> <a href="#ideas-anderscheow" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="http://rashiwal.me/"><img src="https://avatars2.githubusercontent.com/u/31043830?v=4" width="100px;" alt=""/><br /><sub><b>Rohit Ashiwal</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Ar1walz" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/AdamSGit"><img src="https://avatars3.githubusercontent.com/u/6126439?v=4" width="100px;" alt=""/><br /><sub><b>AdamSGit</b></sub></a><br /><a href="#ideas-AdamSGit" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-AdamSGit" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/hemilpanchiwala"><img src="https://avatars0.githubusercontent.com/u/42446679?v=4" width="100px;" alt=""/><br /><sub><b>Hemil Panchiwala</b></sub></a><br /><a href="#maintenance-hemilpanchiwala" title="Maintenance">🚧</a> <a href="#ideas-hemilpanchiwala" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=hemilpanchiwala" title="Documentation">📖</a> <a href="#example-hemilpanchiwala" title="Examples">💡</a></td>
    <td align="center"><a href="http://yiminghan.com"><img src="https://avatars1.githubusercontent.com/u/10720534?v=4" width="100px;" alt=""/><br /><sub><b>YiMing Han</b></sub></a><br /><a href="#ideas-yiminghan" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/AadumKhor"><img src="https://avatars2.githubusercontent.com/u/37381075?v=4" width="100px;" alt=""/><br /><sub><b>Aayush Malhotra</b></sub></a><br /><a href="#maintenance-AadumKhor" title="Maintenance">🚧</a> <a href="#ideas-AadumKhor" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3AAadumKhor" title="Bug reports">🐛</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://anthonywhitford.com/"><img src="https://avatars2.githubusercontent.com/u/123887?v=4" width="100px;" alt=""/><br /><sub><b>Anthony Whitford</b></sub></a><br /><a href="#ideas-awhitford" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-awhitford" title="Maintenance">🚧</a></td>
    <td align="center"><a href="http://zzaning.com"><img src="https://avatars3.githubusercontent.com/u/12035097?v=4" width="100px;" alt=""/><br /><sub><b>Jordy Wong</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aaliyoge" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->  

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome! See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).  

# License  
Animated-Text-Kit is licensed under `MIT license`. View [license](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/LICENSE).

<div align="center"><img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/cover.gif?raw=true"/></div>

# <div align="center">Animated Text Kit</div>

<div align="center">A flutter package which contains a collection of some cool and awesome text animations.</div><br>  
<div align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/animated_text_kit">
    <img src="https://img.shields.io/pub/v/animated_text_kit.svg"
      alt="Pub Package" />
  </a>
  <a href="https://github.com/aagarwal1012/Animated-Text-Kit/actions?query=workflow%3ACI">
    <img src="https://img.shields.io/github/workflow/status/aagarwal1012/Animated-Text-Kit/CI?logo=github"
      alt="Build Status" />
  </a>
  <a href="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit">
    <img src="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit/branch/master/graph/badge.svg"
      alt="Codecov Coverage" />
  </a>
  <a href="https://www.codefactor.io/repository/github/aagarwal1012/animated-text-kit">
    <img src="https://www.codefactor.io/repository/github/aagarwal1012/animated-text-kit/badge"
      alt="CodeFactor" />
  </a>
  <br>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/aagarwal1012/animated-text-kit?color=red"
      alt="License: MIT" />
  </a>
  <a href="https://github.com/Solido/awesome-flutter#animation">
    <img src="https://img.shields.io/badge/Awesome-Flutter-FC60A8?logo=awesome-lists"
      alt="Awesome Flutter" />
  </a>
  <a href="https://www.paypal.me/aagarwal1012">
    <img src="https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal"
      alt="Donate" />
  </a>
</div><br>

# Table of contents

- [Installing](#installing)
- [Usage](#usage)
  - [New with Version 3](#new-with-version-3)
- [Animations](#animations)
  - [Rotate](#rotate)
  - [Fade](#fade)
  - [Typer](#typer)
  - [Typewriter](#typewriter)
  - [Scale](#scale)
  - [Colorize](#colorize)
  - [TextLiquidFill](#textliquidfill)
  - [Wavy](#wavy)
  - [Create your own Animations](#create-your-own-animations)
- [Bugs or Requests](#bugs-or-requests)
- [Donate](#donate)
- [Contributors](#contributors)

# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_text_kit: ^3.0.1
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```
$ pub get
```

with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:animated_text_kit/animated_text_kit.dart';
```

# Usage

`AnimatedTextKit` classes are _Stateful Widgets_ that produce text animations.
Include them in your `build` method like:

```dart
TypewriterAnimatedTextKit(
  speed: Duration(milliseconds: 2000),
  totalRepeatCount: 4,
  text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
  textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
  pause: Duration(milliseconds: 1000),
  displayFullTextOnTap: true,
  stopPauseOnTap: true,
);
```

They have many configurable properties, including:

- `pause` – the time of the pause between animation texts
- `displayFullTextOnTap` – tapping the animation will rush it to completion
- `isRepeatingAnimation` – controls whether the animation repeats
- `repeatForever` – controls whether the animation repeats forever
- `totalRepeatCount` – number of times the animation should repeat (when `repeatForever` is `false`)

There are also custom callbacks:

- `onTap` – This is called when a user taps the animated text
- `onNext(int index, bool isLast)` – This is called before the next text animation, after the previous one's pause
- `onNextBeforePause(int index, bool isLast)` – This is called before the next text animation, before the previous one's pause
- `onFinished` - This is called at the end, when the parameter `isRepeatingAnimation` is set to `false`

## New with Version 3

Version 3 refactored the code so that common animation controls were moved to
`AnimatedTextKit` and all animations, except for `TextLiquidFill`, extend from
`AnimatedText`. This saved hundreds of lines of duplicate code, increased
consistency across animations, and makes it easier to create new animations.

It also makes the animations more flexible because multiple animations may now
be easily combined. For example:

```dart
    AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          'Fade First',
          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        ScaleAnimatedText(
          'Then Scale',
          textStyle: TextStyle(fontSize: 70.0, fontFamily: 'Canterbury'),
        ),
      ],
    ),
```

Using `FadeAnimatedTextKit` is equivalent to using `AnimatedTextKit` with
`FadeAnimatedText`. An advantage of `AnimatedTextKit` is that the `animatedTexts`
may be any subclass of `AnimatedText`, while using `FadeAnimatedTextKit`
essentially restricts you to using just `FadeAnimatedText`.

# Animations

Many animations are provided, but you can also [create your own animations](#create-your-own-animations).

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

## Wavy

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/wavy.gif?raw=true" align = "right" height = "300px">

```dart
WavyAnimatedTextKit(
  textStyle: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold
    ),
  text: [
    "Hello World",
    "Look at the waves",
  ],
  isRepeatingAnimation: true,
),
```

## Create your own Animations

You can easily create your own animations by creating new classes that extend
`AnimatedText`, just like most animations in this package. You will need to
implement:

- Class _constructor_ – Initializes animation parameters.
- `initAnimation` – Initializes `Animation` instances and binds them to the given `AnimationController`.
- `animatedBuilder` – Builder method to return a `Widget` based on `Animation` values.
- `completeText` – Returns the `Widget` to display once the animation is complete. (The default implementation returns a styled `Text` widget.)

Then use `AnimatedTextKit` to display the custom animated text class like:

```dart
    AnimatedTextKit(
      animatedTexts: [
        CustomAnimatedText(
          'Insert Text Here',
          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
```

# Bugs or Requests

If you encounter any problems feel free to open an [issue](https://github.com/aagarwal1012/Animated-Text-Kit/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/aagarwal1012/Animated-Text-Kit/issues/new?template=feature_request.md) on GitHub and I'll look into it. Pull request are also welcome.

See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).

# Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://salih.dev"><img src="https://avatars2.githubusercontent.com/u/24432752?v=4" width="100px;" alt=""/><br /><sub><b>Muhammed Salih Guler</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Asalihgueler" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/anderscheow"><img src="https://avatars0.githubusercontent.com/u/11788504?v=4" width="100px;" alt=""/><br /><sub><b>Anders Cheow</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aanderscheow" title="Bug reports">🐛</a> <a href="#ideas-anderscheow" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://rashiwal.me/"><img src="https://avatars2.githubusercontent.com/u/31043830?v=4" width="100px;" alt=""/><br /><sub><b>Rohit Ashiwal</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Ar1walz" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/AdamSGit"><img src="https://avatars3.githubusercontent.com/u/6126439?v=4" width="100px;" alt=""/><br /><sub><b>AdamSGit</b></sub></a><br /><a href="#ideas-AdamSGit" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-AdamSGit" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/hemilpanchiwala"><img src="https://avatars0.githubusercontent.com/u/42446679?v=4" width="100px;" alt=""/><br /><sub><b>Hemil Panchiwala</b></sub></a><br /><a href="#maintenance-hemilpanchiwala" title="Maintenance">🚧</a> <a href="#ideas-hemilpanchiwala" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=hemilpanchiwala" title="Documentation">📖</a> <a href="#example-hemilpanchiwala" title="Examples">💡</a></td>
    <td align="center"><a href="https://yiminghan.com/"><img src="https://avatars1.githubusercontent.com/u/10720534?v=4" width="100px;" alt=""/><br /><sub><b>YiMing Han</b></sub></a><br /><a href="#ideas-yiminghan" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/AadumKhor"><img src="https://avatars2.githubusercontent.com/u/37381075?v=4" width="100px;" alt=""/><br /><sub><b>Aayush Malhotra</b></sub></a><br /><a href="#maintenance-AadumKhor" title="Maintenance">🚧</a> <a href="#ideas-AadumKhor" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3AAadumKhor" title="Bug reports">🐛</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://anthonywhitford.com/"><img src="https://avatars2.githubusercontent.com/u/123887?v=4" width="100px;" alt=""/><br /><sub><b>Anthony Whitford</b></sub></a><br /><a href="#ideas-awhitford" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-awhitford" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://zzaning.com"><img src="https://avatars3.githubusercontent.com/u/12035097?v=4" width="100px;" alt=""/><br /><sub><b>Jordy Wong</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aaliyoge" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/SirusCodes"><img src="https://avatars0.githubusercontent.com/u/50910066?v=4" width="100px;" alt=""/><br /><sub><b>Darshan Rander</b></sub></a><br /><a href="#ideas-SirusCodes" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=SirusCodes" title="Code">💻</a> <a href="#design-SirusCodes" title="Design">🎨</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=SirusCodes" title="Documentation">📖</a></td>
    <td align="center"><a href="https://jemmytech.com"><img src="https://avatars3.githubusercontent.com/u/17760450?v=4" width="100px;" alt=""/><br /><sub><b>Nsiah Akuoko Jeremiah</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=nakjemmy" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/aniketambore"><img src="https://avatars2.githubusercontent.com/u/52826253?v=4" width="100px;" alt=""/><br /><sub><b>Aniket Ambore</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=aniketambore" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind are welcome! See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).

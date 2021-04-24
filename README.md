<p align="center"><img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/cover.gif?raw=true"/></p>

<h1 align="center">Animated Text Kit</h1>

<p align="center">A flutter package which contains a collection of some cool and awesome text animations. Recommended package for text animations in Codemagic's Ebook, <a href="https://blog.codemagic.io/flutter-libraries-ebook-by-codemagic/ebook-flutter-libraries-we-love-by-codemagic.pdf">"Flutter libraries we love"</a>. Try out our <a href="https://animated-text-kit.web.app/">live example app</a>.</p><br>

<p align="center">
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
  <a href="https://pub.green/packages/animated_text_kit#channel-stable">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=stable&style=flat"
      alt="Latest compatibility result for Stable channel" />
  </a>
  <a href="https://pub.green/packages/animated_text_kit#channel-beta">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=beta&style=flat"
      alt="Latest compatibility result for Beta channel" />
  </a>
  <a href="https://pub.green/packages/animated_text_kit#channel-dev">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=dev&style=flat"
      alt="Latest compatibility result for Dev channel" />
  </a>
  <br>
  <a href="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit">
    <img src="https://codecov.io/gh/aagarwal1012/Animated-Text-Kit/branch/master/graph/badge.svg"
      alt="Codecov Coverage" />
  </a>
  <a href="https://www.codefactor.io/repository/github/aagarwal1012/animated-text-kit">
    <img src="https://www.codefactor.io/repository/github/aagarwal1012/animated-text-kit/badge"
      alt="CodeFactor" />
  </a>
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
</p><br>

<a href="https://flutter.dev/docs/development/packages-and-plugins/favorites">
  <img height="150" align="right" src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/flutter-favorite-badge.png?raw=true">
</a>

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
  - [Flicker](#flicker)
  - [Create your own Animations](#create-your-own-animations)
- [Bugs or Requests](#bugs-or-requests)
- [Donate](#donate)
- [Contributors](#contributors)

# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_text_kit: ^4.2.1
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

`AnimatedTextKit` is a _Stateful Widget_ that produces text animations.
Include it in your `build` method like:

```dart
AnimatedTextKit(
  animatedTexts: [
    TypewriterAnimatedText(
      'Hello world!',
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      speed: const Duration(milliseconds: 2000),
    ),
  ],
  
  totalRepeatCount: 4,
  pause: const Duration(milliseconds: 1000),
  displayFullTextOnTap: true,
  stopPauseOnTap: true,
)
```

It has many configurable properties, including:

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

Using the legacy `FadeAnimatedTextKit` is equivalent to using `AnimatedTextKit` with `FadeAnimatedText`.
An advantage of `AnimatedTextKit` is that the `animatedTexts` may be any subclass of `AnimatedText`, while using `FadeAnimatedTextKit` essentially restricts you to using just `FadeAnimatedText`.

### Legacy AnimatedTextKit classes

Have you noticed that animation classes come in pairs?
For example, there is `FadeAnimatedText` and `FadeAnimatedTextKit`.
The significant refactoring with Version 3 split the original `FadeAnimatedTextKit` into `FadeAnimatedText` and a re-usable `AnimatedTextKit`, then `FadeAnimatedTextKit` was adjusted for backwards compatibility.

When introducing a new `AnimationText` subclass, you may wonder if you also need to also introduce an additional `Kit` class. The answer is **NO**. :tada:

Going forward, we are championing the adoption of the Version 3 approach, and have deprecated the legacy `Kit` classes.
This will make creating new animations easier.
We know it makes some legacy code more verbose, but the flexibility and simplicity is a conscious trade-off.

# Animations

Many animations are provided, but you can also [create your own animations](#create-your-own-animations).

## Rotate

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/rotate.gif?raw=true" align = "right" height = "300px">

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    const SizedBox(width: 20.0, height: 100.0),
    const Text(
      'Be',
      style: TextStyle(fontSize: 43.0),
    ),
    const SizedBox(width: 20.0, height: 100.0),
    DefaultTextStyle(
      style: const TextStyle(
        fontSize: 40.0,
        fontFamily: 'Horizon',
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText('AWESOME'),
          RotateAnimatedText('OPTIMISTIC'),
          RotateAnimatedText('DIFFERENT'),
        ]
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  ],
);
```

**Note:** You can override transition height by setting the value of parameter `transitionHeight` for RotateAnimatedTextKit class.

## Fade

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/fade.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
  width: 250.0,
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
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
```

## Typer

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typer.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
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
      ]
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
```

## Typewriter

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/typewriter.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
  width: 250.0,
  child: DefaultTextStyle(
    style: const TextStyle(
      fontSize: 30.0,
      fontFamily: 'Agne',
    ),
    child: AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText('Discipline is the best tool'),
        TypewriterAnimatedText('Design first, then code'),
        TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
        TypewriterAnimatedText('Do not test bugs out, design them out'),
      ],
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
```

## Scale

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/scale.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
  width: 250.0,
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
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
```

## Colorize

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/colorize.gif?raw=true" align = "right" height = "300px">

```dart
const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

return SizedBox(
  width: 250.0,
  child: AnimatedTextKit(
    animatedTexts: [
      ColorizeAnimatedText(
        'Larry Page',
        textStyle: colorizeTextStyle,
        colors: colorizeColors,
      ),
      ColorizeAnimatedText(
        'Bill Gates',
        textStyle: colorizeTextStyle,
        colors: colorizeColors,
      ),
      ColorizeAnimatedText(
        'Steve Jobs',
        textStyle: colorizeTextStyle,
        colors: colorizeColors,
      ),
    ],
    isRepeatingAnimation: true,
    onTap: () {
      print("Tap Event");
    },
  ),
);
```

**Note:** `colors` list should contains at least two values.

## TextLiquidFill

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/text_liquid_fill.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
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
return DefaultTextStyle(
  style: const TextStyle(
    fontSize: 20.0,
  ),
  child: AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText('Hello World'),
      WavyAnimatedText('Look at the waves'),
    ],
    isRepeatingAnimation: true,
    onTap: () {
      print("Tap Event");
    },
  ),
);
```

## Flicker

<img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/flicker.gif?raw=true" align = "right" height = "300px">

```dart
return SizedBox(
  width: 250.0,
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
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
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
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
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
    <td align="center"><a href="https://salih.dev"><img src="https://avatars2.githubusercontent.com/u/24432752?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Muhammed Salih Guler</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Asalihgueler" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/anderscheow"><img src="https://avatars0.githubusercontent.com/u/11788504?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Anders Cheow</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aanderscheow" title="Bug reports">🐛</a> <a href="#ideas-anderscheow" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://rashiwal.me/"><img src="https://avatars2.githubusercontent.com/u/31043830?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rohit Ashiwal</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Ar1walz" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/AdamSGit"><img src="https://avatars3.githubusercontent.com/u/6126439?v=4?s=100" width="100px;" alt=""/><br /><sub><b>AdamSGit</b></sub></a><br /><a href="#ideas-AdamSGit" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-AdamSGit" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/hemilpanchiwala"><img src="https://avatars0.githubusercontent.com/u/42446679?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hemil Panchiwala</b></sub></a><br /><a href="#maintenance-hemilpanchiwala" title="Maintenance">🚧</a> <a href="#ideas-hemilpanchiwala" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=hemilpanchiwala" title="Documentation">📖</a> <a href="#example-hemilpanchiwala" title="Examples">💡</a></td>
    <td align="center"><a href="https://yiminghan.com"><img src="https://avatars1.githubusercontent.com/u/10720534?v=4?s=100" width="100px;" alt=""/><br /><sub><b>YiMing Han</b></sub></a><br /><a href="#ideas-yiminghan" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/AadumKhor"><img src="https://avatars2.githubusercontent.com/u/37381075?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Aayush Malhotra</b></sub></a><br /><a href="#maintenance-AadumKhor" title="Maintenance">🚧</a> <a href="#ideas-AadumKhor" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3AAadumKhor" title="Bug reports">🐛</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://anthonywhitford.com/"><img src="https://avatars2.githubusercontent.com/u/123887?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Anthony Whitford</b></sub></a><br /><a href="#ideas-awhitford" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-awhitford" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://zzaning.com"><img src="https://avatars3.githubusercontent.com/u/12035097?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jordy Wong</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/issues?q=author%3Aaliyoge" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/SirusCodes"><img src="https://avatars0.githubusercontent.com/u/50910066?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Darshan Rander</b></sub></a><br /><a href="#ideas-SirusCodes" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=SirusCodes" title="Code">💻</a> <a href="#design-SirusCodes" title="Design">🎨</a></td>
    <td align="center"><a href="https://jemmytech.com"><img src="https://avatars3.githubusercontent.com/u/17760450?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Nsiah Akuoko Jeremiah</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=nakjemmy" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/aniketambore"><img src="https://avatars2.githubusercontent.com/u/52826253?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Aniket Ambore</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=aniketambore" title="Documentation">📖</a></td>
    <td align="center"><a href="https://medium.com/@abhayvashokan"><img src="https://avatars1.githubusercontent.com/u/35297280?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Abhay V Ashokan</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=AbhayVAshokan" title="Code">💻</a></td>
    <td align="center"><a href="https://linktr.ee/ritvij14"><img src="https://avatars.githubusercontent.com/u/51456744?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Ritvij Kumar Sharma</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=ritvij14" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/Koniiro"><img src="https://avatars.githubusercontent.com/u/81352867?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Koniiro</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=Koniiro" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/CoderInTheWoods"><img src="https://avatars.githubusercontent.com/u/25412142?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kalgi Sheth</b></sub></a><br /><a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=CoderInTheWoods" title="Code">💻</a> <a href="#example-CoderInTheWoods" title="Examples">💡</a> <a href="https://github.com/aagarwal1012/Animated-Text-Kit/commits?author=CoderInTheWoods" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind are welcome! See [Contributing.md](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CONTRIBUTING.md).

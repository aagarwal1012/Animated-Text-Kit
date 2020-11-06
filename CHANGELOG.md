## 2.5.4

- Added missing dart documentation to the public classes and methods.

## 2.5.3

- Updated the `README` to revert links to be `pub.dev` friendly.

## 2.5.2

**Issue Fixed**

- Bug fix for `ScaleAnimatedTextKit` to check `mounted` before `setState` to avoid potential conflict with `dispose`. Resolves [#105](https://github.com/aagarwal1012/Animated-Text-Kit/issues/105) -- PR [#143](https://github.com/aagarwal1012/Animated-Text-Kit/pull/143)

## 2.5.1

**Bug Fixes and Enhancements**

- Minor bug fix to `RotateAnimatedTextKit` to properly handle `alignment` property, and introduced `textDirection` property [#138](https://github.com/aagarwal1012/Animated-Text-Kit/pull/138)
- Increased test coverage [#128](https://github.com/aagarwal1012/Animated-Text-Kit/issues/128)

## 2.5.0

**Bug Fixes and Enhancements**

- Increase test coverage [#137](https://github.com/aagarwal1012/Animated-Text-Kit/pull/137) and [#135](https://github.com/aagarwal1012/Animated-Text-Kit/pull/135).
- Removed redundant `_texts` variables [#133](https://github.com/aagarwal1012/Animated-Text-Kit/pull/133).
- Added pedantic lint rules. [#132](https://github.com/aagarwal1012/Animated-Text-Kit/pull/132).
- Refactored code to move default logic from the State class to the StatefulWidget [#131](https://github.com/aagarwal1012/Animated-Text-Kit/pull/131).
- Revised `_textKey` to not be a global variable. Resolves [#129](https://github.com/aagarwal1012/Animated-Text-Kit/issues/129) issue -- PR [#130](https://github.com/aagarwal1012/Animated-Text-Kit/pull/130).
- Other basic improvements [#136](https://github.com/aagarwal1012/Animated-Text-Kit/pull/136) and [#134](https://github.com/aagarwal1012/Animated-Text-Kit/pull/134).

## 2.4.1

**Issue Fixed**

- Issue [#125](https://github.com/aagarwal1012/Animated-Text-Kit/issues/125)

## 2.4.0

**Issues Fixed**

- Issue [#124](https://github.com/aagarwal1012/Animated-Text-Kit/pull/124)

- Issue [#123](https://github.com/aagarwal1012/Animated-Text-Kit/pull/123)

- Issue [#122](https://github.com/aagarwal1012/Animated-Text-Kit/pull/122)

- Issue [#121](https://github.com/aagarwal1012/Animated-Text-Kit/pull/121)

## 2.3.0

**New Animated Text**

- Wavy Text by [@SirusCodes](https://github.com/SirusCodes).

**Issues Fixed**

- Issue [#112](https://github.com/aagarwal1012/Animated-Text-Kit/pull/112)

- Issue [#107](https://github.com/aagarwal1012/Animated-Text-Kit/pull/107)

## 2.2.0

**Issues Fixed**

- Issue [#51](https://github.com/aagarwal1012/Animated-Text-Kit/issues/51)

**Code Review** [#81](https://github.com/aagarwal1012/Animated-Text-Kit/pull/81)

- Removed obsolete `new` keywords.
- Added types to collection and function variables.
- Added `final` and `const` keywords.
- Replaced `null` guards with concise `?.` and `??` operators.
- Added missing null check on `dispose` for `FadeAnimatedTextKit`.
- In `fade.dart`, renamed the `_RotatingTextState` class to `_FadeTextState` to be consistent with the overall pattern and avoid confusion with `_RotatingTextState` in `rotate.dart`.

**Warning**:

- Removed `onNextBeforePause` from `ColorizeAnimatedTextKit` because it was not referenced.

## 2.1.0

**Issues Fixed**

- Issue [#58](https://github.com/aagarwal1012/Animated-Text-Kit/issues/58)

- Issue [#44](https://github.com/aagarwal1012/Animated-Text-Kit/issues/44)

**Feature Enhancement**

- Add `repeatForever` option.

  ```dart
  repeatForever: true, //this will ignore [totalRepeatCount]
  ```

## 2.0.1

- Minor updates.

## 2.0.0

- **TextLiquidFill animated text added to the package🎉🎉**

- **Breaking Changes**:
  Different arguments are included in the classes and `duration` has been broken into `speed` and `pause` in some classes as per their needs.

  - `duration` - Change the duration from the animation time of the complete list to single element animation time.
  - `speed` - Time between the display of characters.
  - `pause` - Delay between the animation of texts.
  - `totalRepeatCount` - Sets the number of times animation should repeat
  - `displayFullTextOnTap` - If true, tapping the screen will stop current animated text, and display it fully.
  - `stopPauseOnTap` - If true, tapping during a pause will stop it and start the next text animation.

- **Better control over Animated Texts:**  
  Callbacks added:
  - `onNext(int index, bool isLast)` - This callback will be called before the next text animation, after the previous ones pause.
  - `onNextBeforePause(int index, bool isLast)` - This callback will be called before the next text animation, before the previous one's pause.
  - `onFinished` - This callback is called at the end when the parameter `isRepeatingAnimation` is set to false.

## 1.3.1

- Updated example app readme.
- Added documentation for the various parameters of all the animated widgets.

## 1.3.0

**Feature Enhancement**

- Added attribute to align text.
- Updated Readme.

## 1.2.0

**Feature Enhancement**

- Added attribute to check whether the animation should repeat or not.
- Updated Readme.

## 1.1.1

- Fixed flutter formatting issues.

## 1.1.0

**Feature Enhancement**

- Added onTap callback for all AnimatedText widget.
- Updated Readme.

## 1.0.3

- General update.

## 1.0.2

- Updated Readme.

## 1.0.1

- Initial Release.

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
* Minor updates.

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
* Updated example app readme.
* Added documentation for the various parameters of all the animated widgets.

## 1.3.0
**Feature Enhancement**
* Added attribute to align text.
* Updated Readme.

## 1.2.0
**Feature Enhancement**
* Added attribute to check whether the animation should repeat or not.
* Updated Readme.

## 1.1.1
* Fixed flutter formatting issues.

## 1.1.0
**Feature Enhancement**
* Added onTap callback for all AnimatedText widget.
* Updated Readme.

## 1.0.3
* General update.

## 1.0.2
* Updated Readme.

## 1.0.1
* Initial Release.

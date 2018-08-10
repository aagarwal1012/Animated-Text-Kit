<div align="center"><img src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/cover.gif?raw=true"/></div>

# Animated Text Kit
[![platform](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.io)
[![Build Status](https://travis-ci.com/aagarwal1012/Animated-Text-Kit.svg?token=pXLTRcXnVLpccbxqiWBi&branch=master)](https://travis-ci.com/aagarwal1012/Animated-Text-Kit)
[![pub package](https://img.shields.io/pub/v/animated_text_kit.svg)](https://pub.dartlang.org/packages/animated_text_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-orange.svg)](https://opensource.org/licenses/MIT)

Animation Text Kit is a `flutter` package which contains a collection of cool and beautiful text animations for your flutter apps by using some customized animations.

# Usage
Just add the following dependency in your app's `build.gradle`
```
dependencies {
      compile 'com.sdsmdg.harjot:rotatingtext:1.0.2'
}
```

## Example Usage 1 (Simple)
#### XML

```
<com.sdsmdg.harjot.rotatingtext.RotatingTextWrapper
        android:id="@+id/custom_switcher"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />
```

#### Java

```
RotatingTextWrapper rotatingTextWrapper = (RotatingTextWrapper) findViewById(R.id.custom_switcher);
rotatingTextWrapper.setSize(35);

Rotatable rotatable = new Rotatable(Color.parseColor("#FFA036"), 1000, "Word", "Word01", "Word02");
rotatable.setSize(35);
rotatable.setAnimationDuration(500);

rotatingTextWrapper.setContent("This is ?", rotatable);
```

#### Result
<img src="/screens/gif_example_1.gif"/>

## Example Usage 2 (Typeface + Interpolator)
#### XML

```
<com.sdsmdg.harjot.rotatingtext.RotatingTextWrapper
        android:id="@+id/custom_switcher"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />
```

#### Java

```
Typeface typeface = Typeface.createFromAsset(getAssets(), "fonts/Raleway-Light.ttf");
Typeface typeface2 = Typeface.createFromAsset(getAssets(), "fonts/Reckoner_Bold.ttf");

RotatingTextWrapper rotatingTextWrapper = (RotatingTextWrapper) findViewById(R.id.custom_switcher);
rotatingTextWrapper.setSize(35);
rotatingTextWrapper.setTypeface(typeface2);

Rotatable rotatable = new Rotatable(Color.parseColor("#FFA036"), 1000, "Word", "Word01", "Word02");
rotatable.setSize(35);
rotatable.setAnimationDuration(500);
rotatable.setTypeface(typeface);
rotatable.setInterpolator(new BounceInterpolator());

rotatingTextWrapper.setContent("This is ?", rotatable);
```

#### Result
<img src=""/>

## Example Usage 3 (Multiple Rotatables)
#### XML

```
<com.sdsmdg.harjot.rotatingtext.RotatingTextWrapper
        android:id="@+id/custom_switcher"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />
```

#### Java

```
Typeface typeface = Typeface.createFromAsset(getAssets(), "fonts/Raleway-Light.ttf");
Typeface typeface2 = Typeface.createFromAsset(getAssets(), "fonts/Reckoner_Bold.ttf");

RotatingTextWrapper rotatingTextWrapper = (RotatingTextWrapper) findViewById(R.id.custom_switcher);
rotatingTextWrapper.setSize(35);
rotatingTextWrapper.setTypeface(typeface2);

Rotatable rotatable = new Rotatable(Color.parseColor("#FFA036"), 1000, "Word", "Word01", "Word02");
rotatable.setSize(35);
rotatable.setTypeface(typeface);
rotatable.setInterpolator(new AccelerateInterpolator());
rotatable.setAnimationDuration(500);

Rotatable rotatable2 = new Rotatable(Color.parseColor("#123456"), 1000, "Word03", "Word04", "Word05");
rotatable2.setSize(25);
rotatable2.setTypeface(typeface);
rotatable2.setInterpolator(new DecelerateInterpolator());
rotatable2.setAnimationDuration(500);

rotatingTextWrapper.setContent("This is ? and ?", rotatable, rotatable2);
```

#### Result
<img src="/screens/gif_example_3.gif"/>

# Documentation

Rotating text is made of two parts : `RotatingTextWrapper` and `Rotatable`. <br>
Each rotatable encapsulates the collection of words that are two be periodically switched and also defines various properties related to these words, like, size, color, animation interpolator etc.<br>
Each Rotatable must be a part of a `RotatingTextWrapper`. This defines the actual layout of the text and the positions of the rotating text.

For eg : `rotatingTextWrapper.setContent("This is ?", rotatble);`. Here the `?` denotes the postion of the `rotatable`.

## RotatingTextWrapper
|Property         |Function                |Description                             |
|-----------------|------------------------|----------------------------------------|
|Content               | setContent(...)                    | Set the actual content. Composed of a String and array of Rotatables. |
|Typeface              | setTypeface(...)                   | Set the typeface of the non-rotating text                     |
|Size                  | setSize(...)                       | Set the size of the non-rotating text                         |
|Pause                 | pause(x)                           | Method to pause the 'x'th rotatable                           |
|Resume                | resume(x)                          | Method to resume the 'x'th rotatable                          |

## Rotatable
|Property         |Function                |Description                             |
|-----------------|------------------------|----------------------------------------|
|Color                 | setColor(...)                      | Set the color of the rotating text associated with this rotatable     |
|Size                  | setSize(...)                       | Set the size of the rotating text associated with this rotatable      |
|Typeface              | setTypeface(...)                   | Set the typeface of the rotating text associated with this rotatable  |
|Interpolator          | setInterpolator(...)               | Set the animation interpolator used while switching text              |
|Update Duration       | setUpdateDuration(...)             | Set the interval between switching the words                          |
|Animation Duration    | setAnimationDuration(...)          | Set the duration of the switching animation                           |
|Center Align          | setCenter(...)                     |Align the rotating text to center of the textview if set to **true**   |


# License
RotatingText is licensed under `MIT license`. View [license](LICENSE.md).

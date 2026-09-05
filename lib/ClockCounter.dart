import 'package:humanbeans_clock/ClockUiInheritedModel.dart';
import 'package:humanbeans_clock/NumbersAnimation.dart';
import 'package:humanbeans_clock/keyframes.dart';
import 'package:flutter/material.dart';

// Widget that holds the numbers and animations for the clock face
class ClockCounter extends StatelessWidget {
  const ClockCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting hold of the [ClockUiInheritedModel]
    //
    // Doing it here will cause the entire widget to rebuild on each change in the
    // 'minutes' aspect of the model, but many of the widgets use it anyway
    final ClockUiInheritedModel model = ClockUiInheritedModel.of(
      context,
      'minutes',
    );

    // The screen height is used so that the numbers go off the screen
    final double screenHeight = MediaQuery.sizeOf(context).height;

    // The exit animation keyframes for the numbers
    final List<Keyframe<double>> exitKeyframes = <Keyframe<double>>[
      const Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 1, value: -screenHeight),
    ];

    // The enter animation keyframes for the numbers
    final List<Keyframe<double>> enterKeyframes = <Keyframe<double>>[
      Keyframe<double>(fraction: 0, value: screenHeight),
      const Keyframe<double>(fraction: 1, value: 0),
    ];

    // [TextStyle] for the clock's numbers
    //
    // We declare it here to use the [ClockUiInheritedModel]'s utils, to scale it
    // for the current screen
    final TextStyle style = TextStyle(
      fontFamily: 'HumanBeansBird',
      fontSize: model.utils.scaleDimentions(159),
      color: const Color.fromRGBO(217, 136, 136, 1),
      decoration: TextDecoration.none,
      letterSpacing: 0,
      height: 2.5,
      fontWeight: FontWeight.w400,
    );

    // Builds one digit of the clock face.
    //
    // If the [ClockUiInheritedModel] is animating and the digit changed, build the two
    // [NumbersAnimation] widgets that are going to play the exit (old digit) and enter
    // (new digit) animation respectively. Otherwise just build a simple [Text].
    // Font scaling is disabled for the time numbers: the 159 (baseline) font should
    // provide readability on its own.
    Widget digit(String current, String previous, Interval interval) {
      if (model.clockAnimation.isAnimating && previous != current) {
        return Stack(
          children: <Widget>[
            NumbersAnimation(
              animationController: model.clockAnimation,
              keyframes: exitKeyframes,
              interval: interval,
              child: Text(
                previous,
                style: style,
                textScaler: TextScaler.noScaling,
              ),
            ),
            NumbersAnimation(
              animationController: model.clockAnimation,
              keyframes: enterKeyframes,
              interval: interval,
              child: Text(
                current,
                style: style,
                textScaler: TextScaler.noScaling,
              ),
            ),
          ],
        );
      }
      return Text(current, style: style, textScaler: TextScaler.noScaling);
    }

    // The split single numbers form the pairs of hours and minutes number.
    // The [Interval]s stagger the four digits.
    final Widget hoursTens = digit(
      model.hours[0],
      model.prevHours[0],
      const Interval(0.3, 1, curve: Curves.easeOutQuad),
    );
    final Widget hoursOnes = digit(
      model.hours[1],
      model.prevHours[1],
      const Interval(0.2, 0.90, curve: Curves.easeOutQuad),
    );
    final Widget minutesTens = digit(
      model.minutes[0],
      model.prevMinutes[0],
      const Interval(0.1, 0.8, curve: Curves.easeOutQuad),
    );
    final Widget minutesOnes = digit(
      model.minutes[1],
      model.prevMinutes[1],
      const Interval(0, 0.7, curve: Curves.easeOutQuad),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: model.utils.scaleDimentions(20)),
          child: hoursTens,
        ),
        Padding(
          padding: EdgeInsets.only(top: model.utils.scaleDimentions(40)),
          child: hoursOnes,
        ),
        SizedBox(
          width: model.utils.scaleDimentions(60),
          height: model.utils.scaleDimentions(80),
          child: Image.asset('assets/images/Dots.png', fit: BoxFit.contain),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: model.utils.scaleDimentions(20)),
          child: minutesTens,
        ),
        Padding(
          padding: EdgeInsets.only(top: model.utils.scaleDimentions(40)),
          child: minutesOnes,
        ),
      ],
    );
  }
}

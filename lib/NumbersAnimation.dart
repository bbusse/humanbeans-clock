import 'package:humanbeans_clock/keyframes.dart';
import 'package:flutter/material.dart';

// Function creating the exit end enter aniamtions for the [ClockCounter] widgets
//
// [controller] is the controller that plays the animations,
// [keyframes] is the breakpoints for the animation,
// [interval] is the [Interval] used to delay sequential number animations
Animation<double> setupTranslationY(
  AnimationController controller,
  List<Keyframe<double>> keyframes,
  Interval interval,
) {
  return Interpolation(
    keyframes: keyframes,
  ).animate(CurvedAnimation(parent: controller, curve: interval));
}

// Widget building the [AnimatedBuilder] for the clock face numbers
class NumbersAnimation extends StatelessWidget {
  NumbersAnimation({
    super.key,
    required AnimationController animationController,
    required List<Keyframe<double>> keyframes,
    required Interval interval,
    required this.child,
  }) : assert(keyframes.isNotEmpty, 'keyframes must not be empty'),
       translationY = setupTranslationY(animationController, keyframes, interval);

  final Animation<double> translationY;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: translationY,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, translationY.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

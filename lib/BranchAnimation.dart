import 'package:humanbeans_clock/keyframes.dart';
import 'package:flutter/material.dart';

// Funciton that returns animation used by the animation builder
//
// [controller] is the [AnimationController] that controls the animation.
// [keyframes] is the list of breakpoints for the animation
// [interpolation] is used to orchestrate the staggered animations
Animation<double> setupRotationZ(
  AnimationController controller,
  List<Keyframe<double>> keyframes,
  Interval interval,
) {
  return Interpolation(
    keyframes: keyframes,
  ).animate(CurvedAnimation(parent: controller, curve: interval));
}

// Class that wraps it's child in the [AnimatedBuilder] to play the "Idle Animation"
//
// The class creates it's animation and builds the [AnimatedBuilder]
class BranchAnimation extends StatelessWidget {
  BranchAnimation({
    super.key,
    required AnimationController animationController,
    required List<Keyframe<double>> keyframes,
    required Interval interval,
    this.transformOrigin = const FractionalOffset(0, 0),
    required this.child,
  }) : assert(keyframes.isNotEmpty, 'keyframes must not be empty'),
       rotationZ = setupRotationZ(animationController, keyframes, interval);

  // The animation of rotation of the branch
  final Animation<double> rotationZ;
  // Origin of the roration
  final Alignment transformOrigin;
  // The child to be used in the [AnimatedBuilder]
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // Listen for the animation value to change
      animation: rotationZ,
      builder: (context, child) {
        return Transform.rotate(
          alignment: transformOrigin,
          angle: rotationZ.value,
          child: child,
        );
      },
      child: child,
    );
  }
}

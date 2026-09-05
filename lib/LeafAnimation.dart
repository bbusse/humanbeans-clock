import 'package:humanbeans_clock/keyframes.dart';
import 'package:flutter/material.dart';

// Functions returning the animations for the [Leaf] active animation
//
// They accept the controller as argument and have preset values for the
// [Interpolation] and [Interval].
// During the 'active animation' of the leaf, the 'idle animation' continues.
Animation<double> setupRotation(AnimationController controller) {
  return Interpolation(
    keyframes: const [
      Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 0.999, value: 3.6),
      Keyframe<double>(fraction: 1, value: 0),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.05, 0.35, curve: Curves.easeOut),
    ),
  );
}

Animation<double> setupTranslationX(
  AnimationController controller,
  bool toRight,
) {
  return Interpolation(
    keyframes: [
      const Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 0.999, value: toRight ? 800 : -800),
      const Keyframe<double>(fraction: 1, value: 0),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.05, 0.35, curve: Curves.easeOut),
    ),
  );
}

Animation<double> setupTranslationY(AnimationController controller) {
  return Interpolation(
    keyframes: const [
      Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 0.999, value: 10.0),
      Keyframe<double>(fraction: 1, value: 0),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.05, 0.35, curve: Curves.easeOutQuad),
    ),
  );
}

Animation<double> setupScaleX(AnimationController controller) {
  return Interpolation(
    keyframes: const [
      Keyframe<double>(fraction: 0, value: 1),
      Keyframe<double>(fraction: 0.001, value: 0),
      Keyframe<double>(fraction: 1, value: 1),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.34, 1, curve: Curves.easeOutQuad),
    ),
  );
}

Animation<double> setupScaleY(AnimationController controller) {
  return Interpolation(
    keyframes: const [
      Keyframe<double>(fraction: 0, value: 1),
      Keyframe<double>(fraction: 0.001, value: 0),
      Keyframe<double>(fraction: 1, value: 1),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.34, 1, curve: Curves.easeOutQuad),
    ),
  );
}

// Class building the [AnimatedBuilder] for the 'active animation' of the [Leaf]
//
// Most of the time this widget is not animating, so if there's no [LeafAniamtion.isActive] flag
// true, it builds just the child. When it gets rebuilded with [LeafAniamtion.isActive] flag true,
// it builds the [AnimationController] and plays the animation.
class LeafAnimation extends StatelessWidget {
  // Constructor that creates the animations if [this.isActive] is true,
  //
  // Otherwise, if [this.isActive] is false, we don't need those values,
  // and we assign them to null
  LeafAnimation({
    super.key,
    required AnimationController activeController,
    required this.isActive,
    this.transformOrigin = const FractionalOffset(0, 0),
    bool toRight = true,
    required this.child,
  }) : rotation = isActive ? setupRotation(activeController) : null,
       translationX = isActive
           ? setupTranslationX(activeController, toRight)
           : null,
       translationY = isActive ? setupTranslationY(activeController) : null,
       scaleX = isActive ? setupScaleX(activeController) : null,
       scaleY = isActive ? setupScaleY(activeController) : null;

  // Flag indicating if this widget will animate on this time iteration
  final bool isActive;

  // Animations for transforms during the 'active animations'
  final Animation<double>? rotation;
  final Animation<double>? translationX;
  final Animation<double>? translationY;
  final Animation<double>? scaleX;
  final Animation<double>? scaleY;
  // The transform origin of the animaitons
  final Alignment transformOrigin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final rotation = this.rotation;
    final translationX = this.translationX;
    final translationY = this.translationY;
    final scaleX = this.scaleX;
    final scaleY = this.scaleY;

    // If [this.isActive] flag is false (no animations were created) build just the child.
    if (!isActive ||
        rotation == null ||
        translationX == null ||
        translationY == null ||
        scaleX == null ||
        scaleY == null) {
      return child;
    }

    // Else build the [AnimatedBuilder].
    return AnimatedBuilder(
      animation: Listenable.merge([
        rotation,
        translationX,
        translationY,
        scaleX,
        scaleY,
      ]),
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(translationX.value, translationY.value, 0)
                ..scaleByDouble(scaleX.value, scaleY.value, 1, 1)
                ..rotateZ(rotation.value),
          alignment: transformOrigin,
          child: child,
        );
      },
      child: child,
    );
  }
}

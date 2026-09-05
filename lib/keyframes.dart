import 'package:flutter/animation.dart';

// Keyframe based animation, replacing the abandoned `supernova_flutter_ui_toolkit`.
//
// Semantics match the original package: keyframes are sorted by [Keyframe.fraction],
// values are interpolated linearly between neighbouring keyframes and clamped to the
// first/last keyframe value outside of their range.

/// A value the animation must have at [fraction] (0.0 - 1.0) of its progress.
class Keyframe<T> {
  const Keyframe({required this.fraction, required this.value});

  final double fraction;
  final T value;
}

/// [Animatable] that linearly interpolates between [keyframes].
class Interpolation extends Animatable<double> {
  Interpolation({required List<Keyframe<double>> keyframes})
    : assert(keyframes.isNotEmpty, 'keyframes must not be empty'),
      keyframes = List<Keyframe<double>>.of(keyframes)
        ..sort((a, b) => a.fraction.compareTo(b.fraction));

  final List<Keyframe<double>> keyframes;

  @override
  double transform(double t) {
    if (t <= keyframes.first.fraction) {
      return keyframes.first.value;
    }
    if (t >= keyframes.last.fraction) {
      return keyframes.last.value;
    }

    // Find the first keyframe after [t]; its predecessor is the one before.
    final toIndex = keyframes.indexWhere((keyframe) => keyframe.fraction > t);
    final from = keyframes[toIndex - 1];
    final to = keyframes[toIndex];

    final localT = (t - from.fraction) / (to.fraction - from.fraction);
    return from.value + (to.value - from.value) * localT;
  }
}

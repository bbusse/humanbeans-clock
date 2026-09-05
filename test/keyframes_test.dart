import 'package:humanbeans_clock/keyframes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Interpolation', () {
    final interpolation = Interpolation(
      keyframes: const <Keyframe<double>>[
        Keyframe<double>(fraction: 0, value: 0),
        Keyframe<double>(fraction: 0.9, value: 0.03),
        Keyframe<double>(fraction: 1, value: 0),
      ],
    );

    test('returns the keyframe values at their fractions', () {
      expect(interpolation.transform(0), 0);
      expect(interpolation.transform(0.9), closeTo(0.03, 1e-12));
      expect(interpolation.transform(1), 0);
    });

    test('interpolates linearly between keyframes', () {
      expect(interpolation.transform(0.45), closeTo(0.015, 1e-12));
      expect(interpolation.transform(0.95), closeTo(0.015, 1e-12));
    });

    test('clamps outside of the keyframe range', () {
      expect(interpolation.transform(-1), 0);
      expect(interpolation.transform(2), 0);
    });

    test('sorts keyframes by fraction', () {
      final unsorted = Interpolation(
        keyframes: const <Keyframe<double>>[
          Keyframe<double>(fraction: 1, value: 10),
          Keyframe<double>(fraction: 0, value: 0),
        ],
      );
      expect(unsorted.transform(0.25), closeTo(2.5, 1e-12));
    });

    test('rejects an empty keyframe list', () {
      expect(
        () => Interpolation(keyframes: const <Keyframe<double>>[]),
        throwsAssertionError,
      );
    });
  });
}

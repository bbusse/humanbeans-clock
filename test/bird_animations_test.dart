import 'dart:math';

import 'package:humanbeans_clock/BirdAnimations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BirdAnimations', () {
    test('exposes the enter and exit animation names', () {
      final animations = BirdAnimations();
      expect(animations.getFlyIn(), 'Flying_in');
      expect(animations.getFlyOut(), 'Flying_Away');
    });

    test('returns null when no animation fits in the time left', () {
      final animations = BirdAnimations();
      expect(animations.getRandom(0), isNull);
      // The shortest animation (Wing_span) is 1520 ms long.
      expect(animations.getRandom(1520), isNull);
    });

    test('only returns animations shorter than the time left', () {
      final animations = BirdAnimations(random: Random(42));
      for (var i = 0; i < 50; i++) {
        final name = animations.getRandom(3000);
        expect(name, anyOf('Wing_span', 'Wings_Move'));
      }
    });

    test('can return every animation when there is enough time', () {
      final animations = BirdAnimations(random: Random(7));
      final seen = <String>{};
      for (var i = 0; i < 500; i++) {
        seen.add(animations.getRandom(60000)!);
      }
      expect(seen, {'Nap', 'Grooming', 'Wing_span', 'Wings_Move', 'Head_move'});
    });
  });
}

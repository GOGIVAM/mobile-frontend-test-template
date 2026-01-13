import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/utils/percent_utils.dart';

void main() {
  group('calculatePercentChange', () {
    test('positive change', () {
      expect(calculatePercentChange(current: 120, previous: 100), 20.0);
      expect(calculatePercentChange(current: 150, previous: 100), 50.0);
    });

    test('negative change', () {
      expect(calculatePercentChange(current: 85, previous: 100), -15.0);
      expect(calculatePercentChange(current: 70, previous: 140), -50.0);
    });

    test('zero change', () {
      expect(calculatePercentChange(current: 200, previous: 200), 0.0);
    });

    test('from zero previous value', () {
      expect(calculatePercentChange(current: 50, previous: 0), double.infinity);
      expect(calculatePercentChange(current: 0, previous: 0), 0.0);
      expect(calculatePercentChange(current: -10, previous: 0), double.negativeInfinity);
    });

    test('small decimal precision', () {
      final result = calculatePercentChange(current: 1234, previous: 1200);

      expect(result, closeTo(2.8333, 0.0001));
    });
  });
}
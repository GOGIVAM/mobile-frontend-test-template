import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend_test_template/utils/math_utils.dart';

void main() {
  test('calculatePercent should return correct percentage', () {
    expect(calculatePercent(50, 200), 25.0);
    expect(calculatePercent(10, 100), 10.0);
  });

  test('calculatePercent should return 0 if total is 0', () {
    expect(calculatePercent(50, 0), 0.0);
  });

  test('calculatePercent should handle decimal results', () {
    expect(calculatePercent(1, 3), closeTo(33.33, 0.01));
  });
}

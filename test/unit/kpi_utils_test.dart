import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend_test_template/utils/kpi_utils.dart';

void main() {
  test('calculateTotals should return the sum of all values in the list', () {
    expect(calculateTotals([10.0, 20.0, 30.0]), 60.0);
    expect(calculateTotals([5.5, 4.5]), 10.0);
  });

  test('calculateTotals should return 0 for an empty list', () {
    expect(calculateTotals([]), 0.0);
  });

  test('calculateTotals should handle negative values', () {
    expect(calculateTotals([10.0, -5.0, 2.0]), 7.0);
  });
}

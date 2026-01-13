import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend_test_template/utils/date_utils.dart';

void main() {
  test('formatDate should return date in dd/MM/yyyy format', () {
    final date = DateTime(2023, 12, 25);
    expect(formatDate(date), '25/12/2023');
  });

  test('formatDate should handle different months and days correctly', () {
    final date = DateTime(2023, 1, 5);
    expect(formatDate(date), '05/01/2023');
  });
}

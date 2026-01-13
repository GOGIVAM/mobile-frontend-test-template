import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/utils/date_utils.dart';

void main() {
  group('formatDate', () {
    test('formats normal date correctly', () {
      final date = DateTime(2025, 12, 25);
      expect(formatDate(date), '12/25/2025');
    });

    test('pads single digit month and day', () {
      final date = DateTime(2026, 3, 7);
      expect(formatDate(date), '03/07/2026');
    });

    test('returns empty string for null', () {
      expect(formatDate(null), '');
    });

    test('handles year 2000 edge case', () {
      final date = DateTime(2000, 1, 1);
      expect(formatDate(date), '01/01/2000');
    });
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_1/providers/dashboard_provider.dart';
import 'package:module_1/widgets/bar_chart.dart';


void main() {
  group('CustomBarChart Tests', () {

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: CustomBarChart()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sales'), findsOneWidget);
      expect(find.text('2100'), findsOneWidget);
      expect(find.text('12% higher than last month.'), findsOneWidget);
    });

    testWidgets('handles empty data gracefully', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            barChartDataProvider.overrideWith((ref) => []),
          ],
          child: const MaterialApp(
            home: Scaffold(body: CustomBarChart()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should not crash
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports text scaling', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(2.0)),
            child: MaterialApp(
              home: Scaffold(body: CustomBarChart()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
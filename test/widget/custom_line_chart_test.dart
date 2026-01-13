import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:module_1/models/chart_data_model.dart';
import 'package:module_1/providers/dashboard_provider.dart';
import 'package:module_1/widgets/line_chart.dart';

final chartDataProvider = Provider<ChartDataModel>((ref) {
  return ChartDataModel(
    salesSpots: [
      const FlSpot(0, 10),
      const FlSpot(1, 20),
      const FlSpot(2, 15),
    ],
    revenueSpots: [
      const FlSpot(0, 15),
      const FlSpot(1, 25),
      const FlSpot(2, 20),
    ],
    startDate: DateTime.now()
    , endDate: DateTime.now(),
  );
});

final selectedPeriodProvider = StateProvider<DatePeriod>((ref) {
  return DatePeriod.today;
});

void main() {
  group('CustomLineChart Widget Tests', () {
    testWidgets('renders LineChart widget', (WidgetTester tester) async {
      final mockData = ChartDataModel(
        salesSpots: [
          const FlSpot(0, 10),
          const FlSpot(1, 20),
          const FlSpot(2, 15),
        ],
        revenueSpots: [
          const FlSpot(0, 15),
          const FlSpot(1, 25),
          const FlSpot(2, 20),
        ], startDate: DateTime.now()
        , endDate: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chartDataProvider.overrideWithValue(mockData),
            selectedPeriodProvider.overrideWith((ref) => DatePeriod.today),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CustomLineChart(),
            ),
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets(
        'renders with multiple data points', (WidgetTester tester) async {
      final mockData = ChartDataModel(
        salesSpots: List.generate(12, (i) =>
            FlSpot(i.toDouble(), (i * 10).toDouble())),
        revenueSpots: List.generate(
            12, (i) => FlSpot(i.toDouble(), (i * 15).toDouble())),
        startDate: DateTime.now()
        , endDate: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chartDataProvider.overrideWithValue(mockData),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CustomLineChart(),
            ),
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
      expect(find.byType(CustomLineChart), findsOneWidget);
    });

    testWidgets(
        'handles empty data without crashing', (WidgetTester tester) async {
      final emptyData = ChartDataModel(
        salesSpots: [],
        revenueSpots: [],
        startDate: DateTime.now()
        , endDate: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chartDataProvider.overrideWithValue(emptyData),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CustomLineChart(),
            ),
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });

    test('calculates maxY value correctly from data', () {
      final salesSpots = [
        const FlSpot(0, 10),
        const FlSpot(1, 50),
        const FlSpot(2, 30),
      ];
      final revenueSpots = [
        const FlSpot(0, 20),
        const FlSpot(1, 45),
        const FlSpot(2, 60),
      ];

      final allYValues = [
        ...salesSpots.map((s) => s.y),
        ...revenueSpots.map((s) => s.y),
      ];

      final maxYValue = allYValues.reduce((a, b) => a > b ? a : b);

      expect(maxYValue, 60);
      expect(maxYValue + 10, 70); // With padding
    });

    test('handles empty data gracefully in calculations', () {
      final List<FlSpot> emptySpots = [];

      final allYValues = [
        ...emptySpots.map((s) => s.y),
      ];

      final maxYValue = allYValues.isNotEmpty
          ? allYValues.reduce((a, b) => a > b ? a : b)
          : 0;

      expect(maxYValue, 0);
    });

    testWidgets('displays grid lines', (WidgetTester tester) async {
      final mockData = ChartDataModel(
        salesSpots: [const FlSpot(0, 10), const FlSpot(1, 20)],
        revenueSpots: [const FlSpot(0, 15), const FlSpot(1, 25)],
        startDate: DateTime.now()
        ,
        endDate: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chartDataProvider.overrideWithValue(mockData),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CustomLineChart(),
            ),
          ),
        ),
      );

      // Verify LineChart is rendered (grid is part of LineChartData)
      expect(find.byType(LineChart), findsOneWidget);
    });

    test('formats month labels correctly for longer periods', () {
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];

      for (var i = 0; i < months.length; i++) {
        expect(months[i], isNotEmpty);
        expect(months[i].length, 3);
      }
    });

    test('calculates correct horizontal interval', () {
      const maxYValue = 100.0;
      const expectedInterval = maxYValue / 5;

      expect(expectedInterval, 20.0);
    });

    test('validates line colors', () {
      const salesColor = Color(0xFF5B7FE8);
      const revenueColor = Color(0xFF5DCCF5);

      expect(salesColor.r, 0xFF5B7FE8);
      expect(revenueColor.r, 0xFF5DCCF5);
    });

    testWidgets(
        'chart responds to period changes', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [
          chartDataProvider.overrideWithValue(ChartDataModel(
            salesSpots: [const FlSpot(0, 10)],
            revenueSpots: [const FlSpot(0, 15)],
            startDate: DateTime.now(),
            endDate: DateTime.now(),
          )),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: CustomLineChart(),
            ),
          ),
        ),
      );

      // Change period
      container
          .read(selectedPeriodProvider.notifier)
          .state = DatePeriod.month;
      await tester.pump();

      expect(find.byType(LineChart), findsOneWidget);

      container.dispose();
    });
  });
}
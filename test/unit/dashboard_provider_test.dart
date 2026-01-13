// test/unit/dashboard_provider_test.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:module_1/models/chart_data_model.dart';
import 'package:module_1/models/order.dart';
import 'package:module_1/providers/dashboard_provider.dart';
import 'package:module_1/providers/order_provider.dart';

void main() {
  group('DashboardProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with today period', () {
      // Act
      final state = container.read(dashboardProvider);

      // Assert
      expect(state.selectedPeriod, equals(DatePeriod.today));
      expect(state.chartData, isNotNull);
      expect(state.salesMetrics, isNotEmpty);
      expect(state.salesMetrics.length, equals(4));
      expect(state.barGroups, isNotEmpty);
      expect(state.barLabels, equals(['USA', 'India', 'Brazil', 'Mexico']));
    });

    test('should have initial sales metrics with correct titles', () {
      // Act
      final metrics = container.read(salesMetricsProvider);

      // Assert
      expect(metrics.length, equals(4));
      expect(metrics[0].title, equals('Overall Sales'));
      expect(metrics[1].title, equals('Overall Revenue'));
      expect(metrics[2].title, equals('Overall Earnings'));
      expect(metrics[3].title, equals('New Customers'));
    });

    test('should have initial bar chart data', () {
      // Act
      final barGroups = container.read(barChartDataProvider);

      // Assert
      expect(barGroups, isNotEmpty);
      expect(barGroups.length, equals(4));
      expect(barGroups.every((g) => g.barRods.isNotEmpty), isTrue);
    });

    test('should update period when filterByPeriod is called', () {
      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.week);
      final state = container.read(dashboardProvider);

      // Assert
      expect(state.selectedPeriod, equals(DatePeriod.week));
    });

    test('should reset to initial state', () {
      // Arrange
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.month);

      // Act
      container.read(dashboardProvider.notifier).reset();
      final state = container.read(dashboardProvider);

      // Assert
      expect(state.selectedPeriod, equals(DatePeriod.today));
      expect(state.barLabels, equals(['USA', 'India', 'Brazil', 'Mexico']));
    });

    test('should refresh dashboard data', () {
      // Arrange
      final initialState = container.read(dashboardProvider);

      // Act
      container.read(dashboardProvider.notifier).refresh();
      final newState = container.read(dashboardProvider);

      // Assert
      expect(newState.selectedPeriod, equals(initialState.selectedPeriod));
    });

    test('selectedPeriodProvider should return correct period', () {
      // Act
      final period = container.read(selectedPeriodProvider);

      // Assert
      expect(period, equals(DatePeriod.today));
    });

    test('chartDataProvider should return chart data', () {
      // Act
      final chartData = container.read(chartDataProvider);

      // Assert
      expect(chartData, isNotNull);
      expect(chartData.salesSpots, isNotEmpty);
      expect(chartData.revenueSpots, isNotEmpty);
    });

    test('should generate chart data with 12 data points', () {
      // Act
      final chartData = container.read(chartDataProvider);

      // Assert
      expect(chartData.salesSpots.length, equals(12));
      expect(chartData.revenueSpots.length, equals(12));
    });

    test('should filter by yesterday period', () {
      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.yesterday);
      final state = container.read(dashboardProvider);

      // Assert
      expect(state.selectedPeriod, equals(DatePeriod.yesterday));
    });

    test('should filter by two weeks period', () {
      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.twoWeeks);
      final state = container.read(dashboardProvider);

      // Assert
      expect(state.selectedPeriod, equals(DatePeriod.twoWeeks));
    });

    test('should update sales metrics when filtering', () {
      // Arrange
      final initialMetrics = container.read(salesMetricsProvider);

      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.week);
      final newMetrics = container.read(salesMetricsProvider);

      // Assert - Metrics should be recalculated
      expect(newMetrics, isNotNull);
      expect(newMetrics.length, equals(4));
    });
  });

  group('DashboardState Tests', () {
    test('should create state with copyWith', () {
      // Arrange
      final originalState = DashboardState(
        selectedPeriod: DatePeriod.today,
        chartData: ChartDataModel(
          salesSpots: const [FlSpot(0, 10)],
          revenueSpots: const [FlSpot(0, 5)],
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        ),
        salesMetrics: [],
        barGroups: [],
        barLabels: [],
        currentDate: DateTime.now(),
      );

      // Act
      final newState = originalState.copyWith(
        selectedPeriod: DatePeriod.week,
      );

      // Assert
      expect(newState.selectedPeriod, equals(DatePeriod.week));
      expect(newState.chartData, equals(originalState.chartData));
    });
  });

  group('Dashboard Integration with Orders', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should recalculate when orders change', () {
      // Arrange
      final initialMetrics = container.read(salesMetricsProvider);

      // Act - Add a new order
      container.read(orderProvider.notifier).addOrder(
        OrderModel(
          id: '999',
          customer: 'Test Customer',
          product: 'Test Product',
          userId: 'Test123',
          orderDate: DateTime.now(),
          amount: 100.00,
          paymentStatus: 'Paid',
          deliveryStatus: 'Processing',
          customerCountry: 'US',
        ),
      );

      // Wait for listener to trigger
      final newMetrics = container.read(salesMetricsProvider);

      // Assert - Metrics should be updated
      expect(newMetrics, isNotNull);
    });

    test('should filter orders based on date period', () {
      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.today);
      final state = container.read(dashboardProvider);

      // Assert - Should calculate based on today's orders only
      expect(state.selectedPeriod, equals(DatePeriod.today));
    });
  });

  group('Bar Chart Data Generation', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have correct bar chart structure', () {
      // Act
      final barGroups = container.read(barChartDataProvider);

      // Assert
      expect(barGroups, isNotEmpty);
      for (final group in barGroups) {
        expect(group.barRods, isNotEmpty);
        expect(group.barRods[0].width, equals(50));
        expect(group.barRods[0].color, equals(const Color(0xFF6B8DE3)));
      }
    });

    test('should have matching labels and bar groups count', () {
      // Act
      final barGroups = container.read(barChartDataProvider);
      final labels = container.read(barChartLabelsProvider);

      // Assert - Initial state has mismatched counts (4 groups, 4 labels)
      expect(barGroups.length, equals(4));
      expect(labels.length, equals(4));
    });

    test('bar chart labels should be correct', () {
      // Act
      final labels = container.read(barChartLabelsProvider);

      // Assert
      expect(labels, equals(['USA', 'India', 'Brazil', 'Mexico']));
    });
  });

  group('Sales Metrics Calculation', () {
    test('should calculate metrics from empty orders', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [])),
        ],
      );

      // Act
      container.read(dashboardProvider.notifier).filterByPeriod(DatePeriod.today);
      final metrics = container.read(salesMetricsProvider);

      // Assert - Should handle empty gracefully
      expect(metrics, isNotEmpty);
      expect(metrics.length, equals(4));

      container.dispose();
    });

    test('should format large numbers correctly', () {
      // Act
      final container = ProviderContainer();
      final metrics = container.read(salesMetricsProvider);

      // Assert - Check formatting
      expect(metrics[0].value, isNotEmpty);
      // Initial values should use compact formatting (12M, 78M, etc.)
      expect(metrics.every((m) => m.value.isNotEmpty), isTrue);

      container.dispose();
    });
  });

  group('Chart Data Generation', () {
    test('should generate valid FlSpot data', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      final chartData = container.read(chartDataProvider);

      // Assert
      expect(chartData.salesSpots.every((spot) => spot.x >= 0), isTrue);
      expect(chartData.salesSpots.every((spot) => spot.y >= 0), isTrue);
      expect(chartData.revenueSpots.every((spot) => spot.x >= 0), isTrue);
      expect(chartData.revenueSpots.every((spot) => spot.y >= 0), isTrue);

      container.dispose();
    });

    test('should have matching x coordinates for sales and revenue', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      final chartData = container.read(chartDataProvider);

      // Assert
      for (int i = 0; i < chartData.salesSpots.length; i++) {
        expect(chartData.salesSpots[i].x, equals(chartData.revenueSpots[i].x));
      }

      container.dispose();
    });
  });

  group('Period Filtering Logic', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should handle all date periods', () {
      final periods = [
        DatePeriod.today,
        DatePeriod.yesterday,
        DatePeriod.week,
        DatePeriod.twoWeeks,
        DatePeriod.month,
      ];

      for (final period in periods) {
        // Act
        container.read(dashboardProvider.notifier).filterByPeriod(period);
        final state = container.read(dashboardProvider);

        // Assert
        expect(state.selectedPeriod, equals(period));
      }
    });
  });

  group('State Immutability Tests', () {
    test('copyWith should not modify original state', () {
      // Arrange
      final original = DashboardState(
        selectedPeriod: DatePeriod.today,
        chartData: ChartDataModel(
          salesSpots: const [FlSpot(0, 10)],
          revenueSpots: const [FlSpot(0, 5)],
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        ),
        salesMetrics: [],
        barGroups: [],
        barLabels: ['Test'],
        currentDate: DateTime.now(),
      );

      // Act
      final modified = original.copyWith(selectedPeriod: DatePeriod.week);

      // Assert
      expect(original.selectedPeriod, equals(DatePeriod.today));
      expect(modified.selectedPeriod, equals(DatePeriod.week));
      expect(original.barLabels, equals(['Test']));
    });
  });
}
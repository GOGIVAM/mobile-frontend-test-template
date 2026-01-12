import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import '../models/chart_data_model.dart';
import '../models/order.dart';
import 'order_provider.dart';

enum DatePeriod { today, yesterday, week, twoWeeks, month }

class DashboardState {
  final DatePeriod selectedPeriod;
  final ChartDataModel chartData;
  final List<SalesMetric> salesMetrics;
  final List<BarChartGroupData> barGroups;
  final List<String> barLabels; // NEW: country labels
  final DateTime currentDate;

  DashboardState({
    required this.selectedPeriod,
    required this.chartData,
    required this.salesMetrics,
    required this.barGroups,
    required this.barLabels,
    required this.currentDate,
  });

  DashboardState copyWith({
    DatePeriod? selectedPeriod,
    ChartDataModel? chartData,
    List<SalesMetric>? salesMetrics,
    List<BarChartGroupData>? barGroups,
    List<String>? barLabels,
    DateTime? currentDate,
  }) {
    return DashboardState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      chartData: chartData ?? this.chartData,
      salesMetrics: salesMetrics ?? this.salesMetrics,
      barGroups: barGroups ?? this.barGroups,
      barLabels: barLabels ?? this.barLabels,
      currentDate: currentDate ?? this.currentDate,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this.ref)
      : super(DashboardState(
    selectedPeriod: DatePeriod.today,
    chartData: _generateInitialChartData(DatePeriod.today),
    barGroups: _generateInitialBarGroups(),
    barLabels: ['USA', 'India', 'Brazil', 'Mexico'], // initial labels

    salesMetrics: _generateInitialSalesMetrics(),
    currentDate: DateTime.now(),
  ));

  final Ref ref;

  static ChartDataModel _generateInitialChartData(DatePeriod period) {
    return ChartDataModel(
      salesSpots: const [
        FlSpot(0, 15), FlSpot(1, 32), FlSpot(2, 22), FlSpot(3, 35),
        FlSpot(4, 20), FlSpot(5, 28), FlSpot(6, 48), FlSpot(7, 38),
        FlSpot(8, 30), FlSpot(9, 42), FlSpot(10, 52), FlSpot(11, 55),
      ],
      revenueSpots: const [
        FlSpot(0, 8), FlSpot(1, 18), FlSpot(2, 25), FlSpot(3, 12),
        FlSpot(4, 20), FlSpot(5, 15), FlSpot(6, 22), FlSpot(7, 35),
        FlSpot(8, 28), FlSpot(9, 32), FlSpot(10, 38), FlSpot(11, 48),
      ],
      startDate: DateTime.now().subtract(const Duration(days: 365)),
      endDate: DateTime.now(),
    );
  }

  static List<SalesMetric> _generateInitialSalesMetrics() {
    final formatter = NumberFormat.compact();

    // Example baseline values (replace with your actual initial dataset if needed)
    const totalSales = 12000000; // 12 million
    const totalRevenue = 78000000; // 78 million
    const totalEarnings = 12000000; // 12 million
    const newCustomers = 23000; // 23k

    return [
      SalesMetric(
        title: 'Overall Sales',
        value: formatter.format(totalSales),
        color: const Color(0xFF2196F3),
      ),
      SalesMetric(
        title: 'Overall Revenue',
        value: formatter.format(totalRevenue),
        color: const Color(0xFF4CAF50),
      ),
      SalesMetric(
        title: 'Overall Earnings',
        value: formatter.format(totalEarnings),
        color: const Color(0xFFFF9800),
      ),
      SalesMetric(
        title: 'New Customers',
        value: formatter.format(newCustomers),
        color: const Color(0xFFFF5722),
      ),
    ];
  }


  // Initial dummy bar chart data
  static List<BarChartGroupData> _generateInitialBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          toY: 3,
          color: const Color(0xFF6B8DE3),
          width: 50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
          toY: 10,
          color: const Color(0xFF6B8DE3),
          width: 50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
          toY: 15,
          color: const Color(0xFF6B8DE3),
          width: 50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(
          toY: 23,
          color: const Color(0xFF6B8DE3),
          width: 50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),      ]),
    ];
  }

  // Generate bar chart groups from filtered orders
  List<BarChartGroupData> _generateBarGroupsFromOrders(
      List<OrderModel> orders) {
    final Map<String, int> salesByCountry = {};
    for (var order in orders) {
      final country = order.customerCountry ?? 'Unknown';
      salesByCountry[country] = (salesByCountry[country] ?? 0) + 1;
    }

    int index = 0;
    return salesByCountry.entries.map((entry) {
      return BarChartGroupData(
        x: index++,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: const Color(0xFF6B8DE3),
            width: 40,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    }).toList();
  }

  /// Filters dashboard data by the selected time period
  /// This function updates chart data and sales metrics based on the period
  void filterByPeriod(DatePeriod period) {
    state = state.copyWith(selectedPeriod: period);

    // Calculate date range based on period
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    switch (period) {
      case DatePeriod.today:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case DatePeriod.yesterday:
        startDate = DateTime(now.year, now.month, now.day - 1);
        endDate = DateTime(now.year, now.month, now.day);
        break;
      case DatePeriod.week:
        startDate = now.subtract(const Duration(days: 7));
        break;
      case DatePeriod.twoWeeks:
        startDate = now.subtract(const Duration(days: 15));
        break;
      case DatePeriod.month:
        startDate = now.subtract(const Duration(days: 30));
        break;
    }

    // Get orders within the period
    final orders = ref
        .read(orderProvider)
        .orders;
    final filteredOrders = orders.where((order) {
      return order.orderDate.isAfter(startDate) &&
          order.orderDate.isBefore(endDate);
    }).toList();

    // Generate chart data based on filtered orders
    final chartData = _generateChartDataFromOrders(
      filteredOrders,
      startDate,
      endDate,
      period,
    );

    // Calculate sales metrics from filtered orders
    final salesMetrics = _calculateSalesMetricsFromOrders(filteredOrders);

    final barGroups = _generateBarGroupsFromOrders(filteredOrders);
    final labels = <String>[];

    state = state.copyWith(
        chartData: chartData,
        salesMetrics: salesMetrics,
        barGroups: barGroups,
    );
  }

  ChartDataModel _generateChartDataFromOrders(List<OrderModel> orders,
      DateTime startDate,
      DateTime endDate,
      DatePeriod period,) {
    // Group orders by time buckets based on period
    final int bucketCount = period == DatePeriod.today ? 24 : 12;
    final salesData = List<double>.filled(bucketCount, 0);
    final revenueData = List<double>.filled(bucketCount, 0);

    for (var order in orders) {
      final bucket = _calculateBucket(
          order.orderDate, startDate, endDate, bucketCount);
      if (bucket >= 0 && bucket < bucketCount) {
        salesData[bucket] += 1;
        if (order.paymentStatus.toLowerCase() == 'paid') {
          revenueData[bucket] += order.amount;
        }
      }
    }

    // Convert to FlSpot with some smoothing
    final salesSpots = List<FlSpot>.generate(
      bucketCount,
          (i) => FlSpot(i.toDouble(), salesData[i] * 10 + (15 - i % 15)),
    );

    final revenueSpots = List<FlSpot>.generate(
      bucketCount,
          (i) => FlSpot(i.toDouble(), revenueData[i] / 100 + (8 + i % 10)),
    );

    return ChartDataModel(
      salesSpots: salesSpots,
      revenueSpots: revenueSpots,
      startDate: startDate,
      endDate: endDate,
    );
  }

  int _calculateBucket(DateTime date, DateTime start, DateTime end,
      int bucketCount) {
    final totalDuration = end
        .difference(start)
        .inSeconds;
    final dateDuration = date
        .difference(start)
        .inSeconds;

    if (totalDuration == 0) return 0;

    return ((dateDuration / totalDuration) * bucketCount).floor();
  }


  List<SalesMetric> _calculateSalesMetricsFromOrders(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return [
        SalesMetric(
            title: 'Overall Sales', value: '0', color: const Color(0xFF2196F3)),
        SalesMetric(title: 'Overall Revenue',
            value: '0',
            color: const Color(0xFF4CAF50)),
        SalesMetric(title: 'Overall Earnings',
            value: '0',
            color: const Color(0xFFFF9800)),
        SalesMetric(
            title: 'New Customers', value: '0', color: const Color(0xFFFF5722)),
      ];
    }

    final totalSales = orders
        .where((o) => o.paymentStatus.toLowerCase() == 'paid')
        .length;
    final totalRevenue = orders
        .where((o) => o.paymentStatus.toLowerCase() == 'paid')
        .fold<double>(0.0, (sum, o) => sum + o.amount);
    final totalEarnings = totalRevenue * 0.15;
    final newCustomers = orders
        .map((o) => o.customer)
        .toSet()
        .length;

    final formatter = NumberFormat.compact();

    return [
      SalesMetric(
        title: 'Overall Sales',
        value: formatter.format(totalSales),
        color: const Color(0xFF2196F3),
      ),
      SalesMetric(
        title: 'Overall Revenue',
        value: formatter.format(totalRevenue),
        color: const Color(0xFF4CAF50),
      ),
      SalesMetric(
        title: 'Overall Earnings',
        value: formatter.format(totalEarnings),
        color: const Color(0xFFFF9800),
      ),
      SalesMetric(
        title: 'New Customers',
        value: formatter.format(newCustomers),
        color: const Color(0xFFFF5722),
      ),
    ];
  }

  void reset() {
    state = DashboardState(
      selectedPeriod: DatePeriod.today,
      chartData: _generateInitialChartData(DatePeriod.today),
      barGroups: _generateInitialBarGroups(),
      salesMetrics: _generateInitialSalesMetrics(),
      barLabels: ['USA', 'India', 'Brazil', 'Mexico'],
      currentDate: DateTime.now(),
    );
  }

  void refresh() {
    filterByPeriod(state.selectedPeriod);
  }
}

// Provider
final dashboardProvider = StateNotifierProvider<
    DashboardNotifier,
    DashboardState>((ref) {
  final notifier = DashboardNotifier(ref);

  // Listen to order changes and refresh dashboard
  ref.listen(orderProvider, (_, __) {
    notifier.refresh();
  });

  return notifier;
});

// Helper providers for easier access
final selectedPeriodProvider = Provider<DatePeriod>((ref) {
  return ref
      .watch(dashboardProvider)
      .selectedPeriod;
});

final chartDataProvider = Provider<ChartDataModel>((ref) {
  return ref
      .watch(dashboardProvider)
      .chartData;
});

final salesMetricsProvider = Provider<List<SalesMetric>>((ref) {
  return ref
      .watch(dashboardProvider)
      .salesMetrics;
});

final barChartDataProvider = Provider<List<BarChartGroupData>>((ref) {
  return ref
      .watch(dashboardProvider)
      .barGroups;
});

final barChartLabelsProvider = Provider<List<String>>((ref) {
  return ref
      .watch(dashboardProvider)
      .barLabels;});
// Navigation provider
  final selectedNavIndexProvider = StateProvider<int>((ref) => 0);



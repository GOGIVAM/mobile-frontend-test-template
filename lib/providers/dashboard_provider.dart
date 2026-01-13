import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends GetxController {
  // Reactive state for line and bar charts
  final lineChartSpots = <FlSpot>[].obs;
  final secondaryLineChartSpots = <FlSpot>[].obs;
  final barChartGroups = <BarChartGroupData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Default initialization with 30-day data
    filterByPeriod(30);
  }

  // Updates chart data based on the selected period (7, 15, or 30 days)
  void filterByPeriod(int days) {
    if (days == 7) {
      lineChartSpots.assignAll([
        const FlSpot(0, 3),
        const FlSpot(2, 2),
        const FlSpot(4, 5),
        const FlSpot(6, 3.5),
      ]);
      secondaryLineChartSpots.assignAll([
        const FlSpot(0, 1),
        const FlSpot(2, 4),
        const FlSpot(4, 2),
        const FlSpot(6, 4.5),
      ]);
      barChartGroups.assignAll([
        _makeBarGroup(0, 12),
        _makeBarGroup(1, 15),
        _makeBarGroup(2, 8),
        _makeBarGroup(3, 10),
      ]);
    } else if (days == 15) {
      lineChartSpots.assignAll([
        const FlSpot(0, 2),
        const FlSpot(3, 4),
        const FlSpot(6, 3),
        const FlSpot(9, 5),
        const FlSpot(12, 4),
      ]);
      secondaryLineChartSpots.assignAll([
        const FlSpot(0, 4),
        const FlSpot(3, 2),
        const FlSpot(6, 5),
        const FlSpot(9, 3),
        const FlSpot(12, 4.5),
      ]);
      barChartGroups.assignAll([
        _makeBarGroup(0, 15),
        _makeBarGroup(1, 10),
        _makeBarGroup(2, 18),
        _makeBarGroup(3, 14),
      ]);
    } else {
      // Logic for 30 days or default state
      lineChartSpots.assignAll([
        const FlSpot(0, 1),
        const FlSpot(2, 4),
        const FlSpot(4, 3),
        const FlSpot(6, 5),
        const FlSpot(8, 2),
        const FlSpot(10, 4),
        const FlSpot(11, 3),
      ]);
      secondaryLineChartSpots.assignAll([
        const FlSpot(0, 0.5),
        const FlSpot(2, 2.5),
        const FlSpot(4, 3.5),
        const FlSpot(6, 2.5),
        const FlSpot(8, 3.8),
        const FlSpot(10, 4.5),
        const FlSpot(11, 5.5),
      ]);
      barChartGroups.assignAll([
        _makeBarGroup(0, 5),
        _makeBarGroup(1, 8),
        _makeBarGroup(2, 12),
        _makeBarGroup(3, 17),
      ]);
    }
  }

  // Helper to create bar groups with consistent styling
  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFF6373D1),
          width: 25,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}

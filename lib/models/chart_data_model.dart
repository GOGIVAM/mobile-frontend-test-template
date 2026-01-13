import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartDataModel {
  final List<FlSpot> salesSpots;
  final List<FlSpot> revenueSpots;
  final DateTime startDate;
  final DateTime endDate;

  ChartDataModel({
    required this.salesSpots,
    required this.revenueSpots,
    required this.startDate,
    required this.endDate,
  });
}

class SalesMetric {
  final String title;
  final String value;
  final Color color;

  SalesMetric({
    required this.title,
    required this.value,
    required this.color,
  });
}
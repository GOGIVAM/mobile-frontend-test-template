import 'package:flutter/material.dart';


class KpiModel {
  final String title;
  final double value;
  final String displayValue;
  final Color color;
  final IconData icon;
  final double changePercentage;

  KpiModel({
    required this.title,
    required this.value,
    required this.displayValue,
    required this.color,
    required this.icon,
    this.changePercentage = 0.0,
  });
}
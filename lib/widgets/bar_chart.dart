import 'package:fl_chart/fl_chart.dart' as fl_chart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../providers/dashboard_provider.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardProvider provider = Get.find();

    return Obx(() {
      // Accessing reactive variable to register listener
      if (provider.barChartGroups.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      
      return fl_chart.BarChart(
        fl_chart.BarChartData(
          alignment: fl_chart.BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: fl_chart.BarTouchData(enabled: false),
          titlesData: fl_chart.FlTitlesData(
            show: true,
            bottomTitles: fl_chart.AxisTitles(
              sideTitles: fl_chart.SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const labels = ['Usa', 'Ind', 'Brz', 'Mex'];
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        labels[value.toInt()],
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                reservedSize: 25,
              ),
            ),
            leftTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
            topTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
            rightTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
          ),
          gridData: const fl_chart.FlGridData(show: false),
          borderData: fl_chart.FlBorderData(show: false),
          barGroups: provider.barChartGroups.toList(),
        ),
      );
    });
  }
}

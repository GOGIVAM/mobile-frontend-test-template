import 'package:fl_chart/fl_chart.dart' as fl_chart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../providers/dashboard_provider.dart';

class LineChart extends StatelessWidget {
  const LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardProvider provider = Get.find();

    return Obx(() {
      // Accessing reactive variables explicitly to register listeners
      final spots1 = provider.lineChartSpots.toList();
      final spots2 = provider.secondaryLineChartSpots.toList();

      return fl_chart.LineChart(
        fl_chart.LineChartData(
          gridData: fl_chart.FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => fl_chart.FlLine(
              color: const Color(0xFFE0E5F2),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            getDrawingVerticalLine: (value) => fl_chart.FlLine(
              color: const Color(0xFFE0E5F2),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          titlesData: fl_chart.FlTitlesData(
            show: true,
            rightTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
            topTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
            leftTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
            bottomTitles: fl_chart.AxisTitles(
              sideTitles: fl_chart.SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                  ];
                  if (value.toInt() >= 0 && value.toInt() < months.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        months[value.toInt()],
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: fl_chart.FlBorderData(show: false),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            fl_chart.LineChartBarData(
              spots: spots1,
              isCurved: true,
              color: const Color(0xFF4318FF).withOpacity(0.7),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const fl_chart.FlDotData(show: false),
              belowBarData: fl_chart.BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4318FF).withOpacity(0.3),
                    const Color(0xFF4318FF).withOpacity(0.01),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            fl_chart.LineChartBarData(
              spots: spots2,
              isCurved: true,
              color: const Color(0xFF6AD2FF),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const fl_chart.FlDotData(show: false),
              belowBarData: fl_chart.BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6AD2FF).withOpacity(0.3),
                    const Color(0xFF6AD2FF).withOpacity(0.01),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

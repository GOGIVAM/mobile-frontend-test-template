import 'package:fl_chart/fl_chart.dart' as fl_chart;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      labels[value.toInt()],
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  );
                }
                return const SizedBox();
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
          topTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
          rightTitles: const fl_chart.AxisTitles(sideTitles: fl_chart.SideTitles(showTitles: false)),
        ),
        gridData: const fl_chart.FlGridData(show: false),
        borderData: fl_chart.FlBorderData(show: false),
        barGroups: [
          _buildBarGroup(0, 5),
          _buildBarGroup(1, 8),
          _buildBarGroup(2, 12),
          _buildBarGroup(3, 17),
        ],
      ),
    );
  }

  fl_chart.BarChartGroupData _buildBarGroup(int x, double y) {
    return fl_chart.BarChartGroupData(
      x: x,
      barRods: [
        fl_chart.BarChartRodData(
          toY: y,
          color: const Color(0xFF6373D1),
          width: 30,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}

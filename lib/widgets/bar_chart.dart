import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl_chart;

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return fl_chart.BarChart(
      fl_chart.BarChartData(
        alignment: fl_chart.BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: fl_chart.BarTouchData(enabled: false),
        titlesData: fl_chart.FlTitlesData(
          show: true,
          rightTitles: const fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
          topTitles: const fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
          bottomTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const labels = ['Usa', 'Ind', 'Brz', 'Mex'];
                final index = value.toInt();
                if (index >= 0 && index < labels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: const fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
        ),
        gridData: const fl_chart.FlGridData(show: false),
        borderData: fl_chart.FlBorderData(show: false),
        barGroups: [
          fl_chart.BarChartGroupData(
            x: 0,
            barRods: [
              fl_chart.BarChartRodData(
                toY: 20,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5B67F1),
                    Color(0xFF8E9AFF),
                  ],
                ),
                width: 20,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
            ],
          ),
          fl_chart.BarChartGroupData(
            x: 1,
            barRods: [
              fl_chart.BarChartRodData(
                toY: 50,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5B67F1),
                    Color(0xFF8E9AFF),
                  ],
                ),
                width: 20,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
            ],
          ),
          fl_chart.BarChartGroupData(
            x: 2,
            barRods: [
              fl_chart.BarChartRodData(
                toY: 70,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5B67F1),
                    Color(0xFF8E9AFF),
                  ],
                ),
                width: 20,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
            ],
          ),
          fl_chart.BarChartGroupData(
            x: 3,
            barRods: [
              fl_chart.BarChartRodData(
                toY: 90,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5B67F1),
                    Color(0xFF8E9AFF),
                  ],
                ),
                width: 20,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

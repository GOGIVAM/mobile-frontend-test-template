import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dashboard_provider.dart';

class CustomLineChart extends ConsumerWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartData = ref.watch(chartDataProvider);
    final selectedPeriod = ref.watch(selectedPeriodProvider);

    // Dynamically calculate maxY from data
    final allYValues = [
      ...chartData.salesSpots.map((s) => s.y),
      ...chartData.revenueSpots.map((s) => s.y),
    ];
    final maxYValue = allYValues.isNotEmpty
        ? allYValues.reduce((a, b) => a > b ? a : b)
        : 0;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: maxYValue / 5, // dynamic interval
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withValues(alpha:0.1),
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Colors.grey.withValues(alpha:0.1),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (selectedPeriod == DatePeriod.today) {
                  // Show hours for today
                  if (value % 6 == 0) {
                    return Text('${value.toInt()}h',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12));
                  }
                } else {
                  // Show months for longer periods
                  const months = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                  ];
                  if (value.toInt() >= 0 && value.toInt() < months.length) {
                    return Text(months[value.toInt()],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12));
                  }
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),

        // Dynamic axis limits
        minX: 0,
        maxX: chartData.salesSpots.length - 1,
        minY: 0,
        maxY: maxYValue + 10, // add padding

        lineBarsData: [
          _buildLineChartBarData(chartData.salesSpots, const Color(0xFF5B7FE8)),
          _buildLineChartBarData(chartData.revenueSpots, const Color(0xFF5DCCF5)),
        ],
        lineTouchData: _buildLineTouchData(selectedPeriod),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.4,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha:0.3),
            color.withValues(alpha:0.1),
            color.withValues(alpha:0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  LineTouchData _buildLineTouchData(DatePeriod period) {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBorder: BorderSide(color: Colors.black.withValues(alpha:0.8)),
        tooltipBorderRadius: BorderRadius.circular(8),
        tooltipPadding: const EdgeInsets.all(12),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            String label;
            if (period == DatePeriod.today) {
              label = '${spot.x.toInt()}h';
            } else {
              const months = [
                'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
              ];
              label = months[spot.x.toInt()];
            }
            final isRevenue = spot.barIndex == 1;

            return LineTooltipItem(
              '$label\n',
              const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: '${isRevenue ? 'Revenue' : 'Sales'}: ',
                  style: TextStyle(
                    color: isRevenue ? const Color(0xFF5DCCF5) : const Color(0xFF5B7FE8),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '${spot.y.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    );
  }
}

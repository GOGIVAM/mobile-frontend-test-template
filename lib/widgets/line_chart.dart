import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 10,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha:0.1),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha:0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      months[value.toInt()],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 60,
        lineBarsData: [
          // Sales line (darker blue)
          LineChartBarData(
            spots: const [
              FlSpot(0, 15),
              FlSpot(1, 32),
              FlSpot(2, 22),
              FlSpot(3, 35),
              FlSpot(4, 20),
              FlSpot(5, 28),
              FlSpot(6, 48),
              FlSpot(7, 38),
              FlSpot(8, 30),
              FlSpot(9, 42),
              FlSpot(10, 52),
              FlSpot(11, 55),
            ],
            isCurved: true,
            curveSmoothness: 0.4,
            color: const Color(0xFF5B7FE8),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF5B7FE8).withValues(alpha:0.3),
                  const Color(0xFF5B7FE8).withValues(alpha:0.1),
                  const Color(0xFF5B7FE8).withValues(alpha:0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Revenue line (light blue)
          LineChartBarData(
            spots: const [
              FlSpot(0, 8),
              FlSpot(1, 18),
              FlSpot(2, 25),
              FlSpot(3, 12),
              FlSpot(4, 20),
              FlSpot(5, 15),
              FlSpot(6, 22),
              FlSpot(7, 35),
              FlSpot(8, 28),
              FlSpot(9, 32),
              FlSpot(10, 38),
              FlSpot(11, 48),
            ],
            isCurved: true,
            curveSmoothness: 0.4,
            color: const Color(0xFF5DCCF5),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF5DCCF5).withValues(alpha:0.3),
                  const Color(0xFF5DCCF5).withValues(alpha:0.1),
                  const Color(0xFF5DCCF5).withValues(alpha:0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBorder: BorderSide(color: Colors.black.withValues(alpha:0.8),),
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding: const EdgeInsets.all(12),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                final monthName = months[touchedSpot.x.toInt()];
                final isRevenue = touchedSpot.barIndex == 1;

                return LineTooltipItem(
                  '$monthName\n',
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: '${isRevenue ? 'Revenue' : 'Sales'}: ',
                      style: TextStyle(
                        color: isRevenue
                            ? const Color(0xFF5DCCF5)
                            : const Color(0xFF5B7FE8),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${touchedSpot.y.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
          getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.grey.withValues(alpha:0.5),
                  strokeWidth: 2,
                  dashArray: [5, 5],
                ),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: Colors.white,
                      strokeWidth: 3,
                      strokeColor: barData.color ?? Colors.blue,
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
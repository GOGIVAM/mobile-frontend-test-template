import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl_chart;
import '../utils/mock_data.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  String selectedPeriod = 'Today';
  final List<String> periods = ['Today', 'Yesterday', '7 days', '15 days', '30 days'];

  @override
  Widget build(BuildContext context) {
    final salesData = MockData.getSalesData();

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPeriodSelector(),
            ],
          ),
          SizedBox(
            height: 250,
            child: fl_chart.LineChart(
              fl_chart.LineChartData(
                gridData: fl_chart.FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return fl_chart.FlLine(
                      color: Colors.grey.withValues(alpha: 0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: fl_chart.FlTitlesData(
                  leftTitles: const fl_chart.AxisTitles(
                    sideTitles: fl_chart.SideTitles(showTitles: false),
                  ),
                  rightTitles: const fl_chart.AxisTitles(
                    sideTitles: fl_chart.SideTitles(showTitles: false),
                  ),
                  topTitles: const fl_chart.AxisTitles(
                    sideTitles: fl_chart.SideTitles(showTitles: false),
                  ),
                  bottomTitles: fl_chart.AxisTitles(
                    sideTitles: fl_chart.SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < salesData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              salesData[value.toInt()].month,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
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
                maxX: (salesData.length - 1).toDouble(),
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  // Sales line
                  fl_chart.LineChartBarData(
                    spots: salesData.asMap().entries.map((e) {
                      return fl_chart.FlSpot(e.key.toDouble(), e.value.sales);
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFF5B67F1),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const fl_chart.FlDotData(show: false),
                    belowBarData: fl_chart.BarAreaData(
                      show: true,
                      color: const Color(0xFF5B67F1).withValues(alpha: 0.2),
                    ),
                  ),
                  // Revenue line
                  fl_chart.LineChartBarData(
                    spots: salesData.asMap().entries.map((e) {
                      return fl_chart.FlSpot(e.key.toDouble(), e.value.revenue);
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFF7DD8F7),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const fl_chart.FlDotData(show: false),
                    belowBarData: fl_chart.BarAreaData(
                      show: true,
                      color: const Color(0xFF7DD8F7).withValues(alpha: 0.2),
                    ),
                  ),
                ],
                lineTouchData: fl_chart.LineTouchData(
                  touchTooltipData: fl_chart.LineTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItems: (List<fl_chart.LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        final month = salesData[flSpot.x.toInt()].month;
                        return fl_chart.LineTooltipItem(
                          '${barSpot.barIndex == 0 ? 'Sales' : 'Revenue'}: ${flSpot.y.toInt()}\n$month',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(const Color(0xFF5B67F1), 'Sales'),
              const SizedBox(width: 24),
              _buildLegend(const Color(0xFF7DD8F7), 'Revenue'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = period == selectedPeriod;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPeriod = period;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6FCF97) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                period,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

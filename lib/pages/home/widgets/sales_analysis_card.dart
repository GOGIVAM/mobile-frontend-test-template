import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class SalesAnalysisCard extends StatelessWidget {
  const SalesAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side stats
              _buildStatsSide(),
              const SizedBox(width: 32),
              // Right side chart and header
              Expanded(
                child: Column(
                  children: [
                    _buildTimeFilters(),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 250,
                      child: _buildChart(),
                    ),
                    const SizedBox(height: 20),
                    _buildLegend(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatItem('Overall Sales', '12 Millions', const Color(0xFF4318FF)),
        const SizedBox(height: 20),
        _buildStatItem('Overall Earnings', '78 Millions', const Color(0xFF05CD99)),
        const SizedBox(height: 20),
        _buildStatItem('Overall Revenue', '60 Millions', const Color(0xFFEE5D50)),
        const SizedBox(height: 20),
        _buildStatItem('New Customers', '23k', const Color(0xFFFFB547)),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4318FF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('View Reports', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildFilterChip('Today', isSelected: true),
        _buildFilterChip('Yesterday'),
        _buildFilterChip('7 days'),
        _buildFilterChip('15 days'),
        _buildFilterChip('30 days'),
      ],
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF05CD99) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: const Color(0xFFE0E5F2),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: const Color(0xFFE0E5F2),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
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
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          // Revenue Line
          LineChartBarData(
            spots: const [
              FlSpot(0, 1), FlSpot(2, 4), FlSpot(4, 3), FlSpot(6, 5),
              FlSpot(8, 2), FlSpot(10, 4), FlSpot(11, 3),
            ],
            isCurved: true,
            color: const Color(0xFF4318FF).withOpacity(0.7),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
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
          // Sales Line
          LineChartBarData(
            spots: const [
              FlSpot(0, 0.5), FlSpot(2, 2.5), FlSpot(4, 3.5), FlSpot(6, 2.5),
              FlSpot(8, 3.8), FlSpot(10, 4.5), FlSpot(11, 5.5),
            ],
            isCurved: true,
            color: const Color(0xFF6AD2FF),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
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
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Sales', const Color(0xFF4318FF)),
        const SizedBox(width: 24),
        _buildLegendItem('Revenue', const Color(0xFF6AD2FF)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

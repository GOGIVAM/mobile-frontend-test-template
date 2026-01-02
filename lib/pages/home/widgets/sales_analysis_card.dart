import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/line_chart.dart';

class SalesAnalysisCard extends StatelessWidget {
  const SalesAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(02),
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
              _buildStatsSide(),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildTimeFilters(),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 170,
                      child: LineChart(),
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
        _buildStatItem(
            'Overall Earnings', '78 Millions', const Color(0xFF59BA50)),
        const SizedBox(height: 20),
        _buildStatItem(
            'Overall Revenue', '60 Millions', const Color(0xFFEE5D50)),
        const SizedBox(height: 20),
        _buildStatItem('New Customers', '23k', const Color(0xFFFFB547)),
        const SizedBox(height: 18),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF4318FF),
            borderRadius: BorderRadius.circular(02),
          ),
          child: const Text('View Reports',
              style: TextStyle(fontSize: 12, color: Colors.white)),
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
            Text(label, style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF59BA50) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Sales', const Color(0xFF4318FF)),
        const SizedBox(width: 22),
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
        const SizedBox(width: 6),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/line_chart.dart';
import '../../../providers/dashboard_provider.dart';

class SalesAnalysisCard extends StatelessWidget {
  const SalesAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardProvider provider = Get.find();

    return Container(
      padding: const EdgeInsets.all(24),
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
                    _buildTimeFilters(provider),
                    const SizedBox(height: 20),
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
        _buildStatItem('Overall Earnings', '78 Millions', const Color(0xFF05CD99)),
        const SizedBox(height: 20),
        _buildStatItem('Overall Revenue', '60 Millions', const Color(0xFFEE5D50)),
        const SizedBox(height: 20),
        _buildStatItem('New Customers', '23k', const Color(0xFFFFB547)),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(08),
          decoration: BoxDecoration(
            color: const Color(0xFF4318FF),
            borderRadius: BorderRadius.circular(01)
          ),
          child: const Text('View Reports', style: TextStyle(color: Colors.white, fontSize: 12)),
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
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
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

  Widget _buildTimeFilters(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFilterChip('Today', 1, provider),
          _buildFilterChip('Yesterday', 2, provider),
          _buildFilterChip('7 days', 7, provider),
          _buildFilterChip('15 days', 15, provider),
          _buildFilterChip('30 days', 30, provider),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int days, DashboardProvider provider) {
    return Obx(() {
      final bool isSelected = provider.selectedPeriod.value == days;

      return InkWell(
        onTap: () => provider.filterByPeriod(days),
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF05CD99) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      );
    });
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

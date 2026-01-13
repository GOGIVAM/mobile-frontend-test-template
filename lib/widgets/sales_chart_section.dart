import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/dashboard_screen.dart';
import '../providers/dashboard_provider.dart';
import '../utils/app_colors.dart';
import 'chart_legend.dart';
import 'date_filter_chips.dart';
import 'line_chart.dart';

class SalesChartSection extends ConsumerWidget {
  final bool isMobile;

  const SalesChartSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesMetrics = ref.watch(salesMetricsProvider);
    final selectedPeriod = ref.watch(selectedPeriodProvider);

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: AppColors.cardBg),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...salesMetrics.map((metric) => SalesData(
                      title: metric.title,
                      subtitle: metric.value,
                      color: metric.color,
                    )),
                    const ViewReportsButton(),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(child: DateFilterChips(selectedPeriod: selectedPeriod)),
              ],
            ),
            const SizedBox(height: 240, child: CustomLineChart()),
            const SizedBox(height: 24),
            const ChartLegend(),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.cardBg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...salesMetrics.map((metric) => SalesData(
                title: metric.title,
                subtitle: metric.value,
                color: metric.color,
              )),
              const ViewReportsButton(),
            ],
          ),
          const SizedBox(width: 124),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DateFilterChips(selectedPeriod: selectedPeriod),
                const SizedBox(height: 340, child: CustomLineChart()),
                const SizedBox(height: 24),
                const ChartLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

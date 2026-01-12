import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dashboard_provider.dart';
import '../utils/app_colors.dart';

class DateFilterChips extends ConsumerWidget {
  final DatePeriod selectedPeriod;

  const DateFilterChips({super.key, required this.selectedPeriod});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = [
      ('Today', DatePeriod.today),
      ('Yesterday', DatePeriod.yesterday),
      ('7 days', DatePeriod.week),
      ('15 days', DatePeriod.twoWeeks),
      ('30 days', DatePeriod.month),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      runAlignment: WrapAlignment.end,
      children: filters.map((filter) {
        final (label, period) = filter;
        return FilterChip(
          label: Text(label),
          selectedColor: AppColors.green,
          selected: period == selectedPeriod,
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.transparent),
          ),
          onSelected: (_) {
            ref.read(dashboardProvider.notifier).filterByPeriod(period);
          },
        );
      }).toList(),
    );
  }
}

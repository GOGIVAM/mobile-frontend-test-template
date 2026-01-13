import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_1/providers/dashboard_provider.dart';
import '../models/kpi_data.dart';
import '../providers/kpi_provider.dart';
import '../utils/app_breakpoints.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../widgets/kpi_card.dart';
import '../widgets/orders_table.dart';
import '../widgets/bar_chart.dart';
import '../widgets/sales_chart_section.dart';


class DashboardContent extends ConsumerWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = AppBreakpoints.isDesktop(width);
    final kpis = ref.watch(kpiProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dashboardProvider.notifier).reset();
        ref.read(kpiProvider.notifier).refresh();
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.getPaddingMedium(width)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesktop) const DashboardHeader(),
            const SizedBox(height: 32),
            KpiCardsGrid(kpis: kpis),
            const SizedBox(height: 32),
            isDesktop
                ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: SalesChartSection(isMobile: false)),
                SizedBox(width: 24),
                Expanded(flex: 1, child: CustomBarChart()),
              ],
            )
                : const Column(
              children: [
                SalesChartSection(isMobile: true),
                SizedBox(height: 32),
                CustomBarChart(),
              ],
            ),
            const SizedBox(height: 32),
            const OrdersTable(),
          ],
        ),
      ),
    );
  }
}

class KpiCardsGrid extends StatelessWidget {
  final List<KpiModel> kpis;

  const KpiCardsGrid({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppBreakpoints.isMobile(constraints.maxWidth) ? 2 : 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          itemBuilder: (context, index) {
            final kpi = kpis[index];
            return KpiCard(
              title: kpi.title,
              value: kpi.displayValue,
              color: kpi.color,
              icon: kpi.icon,
              changePercentage: kpi.changePercentage,
            );
          },
        );
      },
    );
  }
}

class BreadcrumbNav extends StatelessWidget {
  const BreadcrumbNav({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 2,
      children: [
        Icon(Icons.home_outlined, size: 16, color: AppColors.blue),
        Text('Home', style: TextStyle(fontSize: 12)),
        Icon(Icons.arrow_forward_ios_sharp, size: 12),
        Text('Sales', style: TextStyle(fontSize: 12))
      ],
    );
  }
}

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: AppColors.green,
      label: Text(count.toString()),
      child: const Icon(Icons.notifications, color: Colors.orange),
    );
  }
}

class ViewReportsButton extends StatelessWidget {
  const ViewReportsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Text('View Reports', style: TextStyle(color: Colors.white)),
    );
  }
}


class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BreadcrumbNav(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 16,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.cardBg),
                padding: const EdgeInsets.all(8),
                width: 200,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Search anything'), Icon(Icons.search)],
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.cardBg),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'You have '),
                          TextSpan(text: '21 ', style: TextStyle(color: AppColors.green)),
                          TextSpan(text: 'new leads'),
                        ],
                      ),
                    ),
                    const NotificationBadge(count: 21,),
                  ],
                ),
              ),
              const SizedBox(width: 68, child: Text('Abigail Helen', overflow: TextOverflow.ellipsis)),
              const Badge(backgroundColor: AppColors.green, child: CircleAvatar(child: Text('A.H')))
            ],
          ),
        )
      ],
    );
  }
}



class SalesData extends StatelessWidget {
  const SalesData({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
            )
          ],
        )
      ],
    );
  }
}

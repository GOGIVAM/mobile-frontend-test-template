import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/stat_card.dart';
import 'widgets/header.dart';
import 'widgets/sidebar.dart';
import 'widgets/sales_analysis_card.dart';
import 'widgets/sales_bar_chart_card.dart';
import 'widgets/orders_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 1100;

        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: isMobile ? const Sidebar() : null,
          body: Row(
            children: [
              if (!isMobile) const Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    Header(showMenu: isMobile),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          children: [
                            _buildStatRow(context),
                            const SizedBox(height: 24),
                            if (isMobile) ...[
                              const SalesAnalysisCard(),
                              const SizedBox(height: 24),
                              const SalesBarChartCard(),
                            ] else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(flex: 2, child: SalesAnalysisCard()),
                                  const SizedBox(width: 24),
                                  const Expanded(flex: 1, child: SalesBarChartCard()),
                                ],
                              ),
                            ],
                            const SizedBox(height: 24),
                            const OrdersCard(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(
            width: 280,
            child: StatCard(
              title: 'Sales',
              value: '250k',
              icon: Icons.bar_chart,
              iconColor: Color(0xFFE17D36),
              iconBackgroundColor: Color(0xFFFCEFE5),
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            width: 280,
            child: StatCard(
              title: 'Customers',
              value: '24m',
              icon: Icons.person,
              iconColor: Color(0xFF4318FF),
              iconBackgroundColor: Color(0xFFF4F7FE),
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            width: 280,
            child: StatCard(
              title: 'Products',
              value: '15k',
              icon: Icons.shopping_bag,
              iconColor: Color(0xFFFFB547),
              iconBackgroundColor: Color(0xFFFFF8ED),
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            width: 280,
            child: StatCard(
              title: 'Revenue',
              value: '180m',
              icon: Icons.attach_money,
              iconColor: Color(0xFF05CD99),
              iconBackgroundColor: Color(0xFFE6FAF5),
            ),
          ),
        ],
      ),
    );
  }
}

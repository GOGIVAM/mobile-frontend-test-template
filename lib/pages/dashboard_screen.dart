import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/kpi_card.dart';
import '../widgets/chatbot_widget.dart';
import '../widgets/orders_table.dart';
import 'home/widgets/header.dart';
import 'home/widgets/sidebar.dart';
import 'home/widgets/sales_analysis_card.dart';
import 'home/widgets/sales_bar_chart_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 1100;

        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: isMobile ? const Sidebar() : null,
          body: Stack(
            children: [
              Row(
                children: [
                  if (!isMobile) const Sidebar(),
                  Expanded(
                    child: Column(
                      children: [
                        Header(showMenu: isMobile),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                              children: [
                                _buildKpiRow(),
                                const SizedBox(height: 24),
                                if (isMobile) ...[
                                  const SalesAnalysisCard(),
                                  const SizedBox(height: 20),
                                  const SalesBarChartCard(),
                                ] else ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Expanded(
                                          flex: 3, child: SalesAnalysisCard()),
                                      SizedBox(width: 16),
                                      Expanded(
                                          child: SizedBox(
                                              width: 310,
                                              child: SalesBarChartCard())),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 20),
                                const OrdersTable(),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Positioned(
                bottom: 24,
                right: 24,
                child: ChatbotWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKpiRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(
            width: 310,
            child: KpiCard(
              title: 'Sales',
              value: '250k',
              icon: Icons.bar_chart,
              iconColor: Color(0xFFE17D36),
              iconBackgroundColor: Color(0xFFFCEFE5),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 310,
            child: KpiCard(
              title: 'Customers',
              value: '24m',
              icon: Icons.person,
              iconColor: Color(0xFF4318FF),
              iconBackgroundColor: Color(0xFFF4F7FE),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 310,
            child: KpiCard(
              title: 'Products',
              value: '15k',
              icon: Icons.shopping_bag,
              iconColor: Color(0xFFFFB547),
              iconBackgroundColor: Color(0xFFFFF8ED),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 310,
            child: KpiCard(
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

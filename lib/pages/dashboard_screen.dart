import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../widgets/kpi_card.dart';
import '../widgets/chatbot_widget.dart';
import '../widgets/orders_table.dart';
import '../providers/kpi_provider.dart';
import '../providers/order_provider.dart';
import 'home/widgets/header.dart';
import 'home/widgets/sidebar.dart';
import 'home/widgets/sales_analysis_card.dart';
import 'home/widgets/sales_bar_chart_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KpiProvider kpiProvider = Get.find();
    final OrderProvider orderProvider = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 1100;
        final bool isLandscape = constraints.maxWidth > constraints.maxHeight;

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
                          child: RefreshIndicator(
                            onRefresh: () => orderProvider.fetchOrders(),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 08),
                              child: Column(
                                children: [
                                  _buildKpiRow(kpiProvider),
                                  const SizedBox(height: 24),
                                  if (isMobile && !isLandscape) ...[
                                    const SalesAnalysisCard(),
                                    const SizedBox(height: 24),
                                    const SalesBarChartCard(),
                                  ] else ...[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Expanded(flex: 3, child: SalesAnalysisCard()),
                                        SizedBox(width: 24),
                                        Expanded(flex: 1, child: SalesBarChartCard()),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 24),
                                  const OrdersTable(),
                                  const SizedBox(height: 80),
                                ],
                              ),
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

  Widget _buildKpiRow(KpiProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
        children: [
          SizedBox(
            width: 320,
            child: KpiCard(
              title: 'Sales',
              value: provider.sales.value,
              icon: Icons.bar_chart,
              iconColor: const Color(0xFFE17D36),
              iconBackgroundColor: const Color(0xFFFCEFE5),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 320,
            child: KpiCard(
              title: 'Customers',
              value: provider.customers.value,
              icon: Icons.person,
              iconColor: const Color(0xFF4318FF),
              iconBackgroundColor: const Color(0xFFF4F7FE),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 320,
            child: KpiCard(
              title: 'Products',
              value: provider.products.value,
              icon: Icons.shopping_bag,
              iconColor: const Color(0xFFFFB547),
              iconBackgroundColor: const Color(0xFFFFF8ED),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 320,
            child: KpiCard(
              title: 'Revenue',
              value: provider.revenue.value,
              icon: Icons.attach_money,
              iconColor: const Color(0xFF05CD99),
              iconBackgroundColor: const Color(0xFFE6FAF5),
            ),
          ),
        ],
      )),
    );
  }
}

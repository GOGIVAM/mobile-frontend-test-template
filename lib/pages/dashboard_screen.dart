import 'package:flutter/material.dart';
import 'package:module_1/pages/products_page.dart';
import 'package:module_1/pages/reports_page.dart';
import '../models/nav_items.dart';
import '../utils/app_breakpoints.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../widgets/kpi_card.dart';
import '../widgets/orders_table.dart';
import '../widgets/line_chart.dart';
import '../widgets/bar_chart.dart';
import '../widgets/navigation_drawer.dart';
import 'analytics_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AnalyticsPage(),
    const ReportsPage(),
    const ProductsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    // TODO: real navigation (Navigator.pushNamed or go_router)
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final isDesktop = AppBreakpoints.isDesktop(width);

    Widget bodyContent = SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.getPaddingMedium(width)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Row(
              children: [
                const Row(
                  spacing: 2,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 16,
                      color: AppColors.blue,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 12,
                    ),
                    Text('Sales', style: TextStyle(fontSize: 12))
                  ],
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 16,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.cardBg),
                      padding: const EdgeInsets.all(8),
                      width: 200,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Search anything'), Icon(Icons.search)],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.cardBg),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(text: 'You have '),
                                TextSpan(
                                    text: '21 ',
                                    style: TextStyle(color: AppColors.green)),
                                TextSpan(text: 'new leads'),
                              ])),
                          const Badge(
                            backgroundColor: AppColors.green,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                        width: 68,
                        child: Text(
                          'Abigail Helen',
                          overflow: TextOverflow.ellipsis,
                        )),
                    const Badge(
                      backgroundColor: AppColors.green,
                      child: CircleAvatar(
                        child: Text('A.H'),
                      ),
                    )
                  ],
                ))
              ],
            ),
          const SizedBox(
            height: 32,
          ),
          LayoutBuilder(
            builder: (_, constraints) {
              final crossCount =
                  (constraints.maxWidth / 220).floor().clamp(1, 4);
              return GridView.count(
                crossAxisCount:
                    AppBreakpoints.isMobile(constraints.maxWidth) ? 2 : 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
                children: const [
                  KpiCard(
                      title: 'Sales',
                      value: '250k',
                      color: AppColors.orangeAccent,
                      icon: Icons.trending_up),
                  KpiCard(
                      title: 'Customers',
                      value: '24m',
                      color: AppColors.blue,
                      icon: Icons.people),
                  KpiCard(
                      title: 'Products',
                      value: '15k',
                      color: AppColors.orange,
                      icon: Icons.inventory),
                  KpiCard(
                      title: 'Revenue',
                      value: '180m',
                      color: AppColors.green,
                      icon: Icons.attach_money),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Charts (stack on mobile/tablet, side-by-side on desktop)
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildSalesChartSection(false)),
                    const SizedBox(width: 24),
                    const Expanded(flex: 1, child: CustomBarChart()),
                  ],
                )
              : Column(
                  children: [
                    _buildSalesChartSection(true),
                    const SizedBox(height: 32),
                    const CustomBarChart(),
                  ],
                ),

          const SizedBox(height: 32),
          const OrdersTable(),
        ],
      ),
    );

    Widget scaffold;

    if (isMobile) {
      scaffold = Scaffold(
        appBar: AppBar(
          title: const Row(
            spacing: 2,
            children: [
              Icon(
                Icons.home_outlined,
                size: 16,
                color: AppColors.blue,
              ),
              Text(
                'Home',
                style: TextStyle(fontSize: 12),
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 12,
              ),
              Text('Sales', style: TextStyle(fontSize: 12))
            ],
          ),
          actions: const [
            Icon(Icons.search),
            SizedBox(
              width: 8,
            ),
            Badge(
              child: Icon(
                Icons.notifications,
                color: Colors.orange,
              ),
              backgroundColor: AppColors.green,
            ),
            SizedBox(
              width: 8,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(radius: 16, child: Text('A')),
            ),
          ],
        ),
        drawer: AppDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [bodyContent, ..._pages],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex.clamp(0, 3),
          // limit to 4 for bottom bar
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.blue,
          items: mainNavItems.take(4).map((e) {
            return BottomNavigationBarItem(icon: Icon(e.icon), label: e.label);
          }).toList(),
        ),
      );
    } else {
      // Tablet + Desktop
      scaffold = Scaffold(
        body: Row(
          children: [
            ResponsiveNavigation(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              isRailExtended: isDesktop,
            ),
            Expanded(
                child: IndexedStack(
              index: _selectedIndex,
              children: [bodyContent, ..._pages],
            ))
          ],
        ),
      );
    }

    return scaffold;
  }

  Widget _buildSalesChartSection(bool isMobile) {
    if(isMobile) {
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
                    const SalesData(
                      title: 'Overall Sales',
                      subtitle: '12 millions',
                      color: AppColors.blue,
                    ),
                    const SalesData(
                      title: 'Overall Revenue',
                      subtitle: '78 millions',
                      color: AppColors.green,
                    ),
                    const SalesData(
                      title: 'Overall Earnings',
                      subtitle: '12 millions',
                      color: AppColors.orange,
                    ),
                    const SalesData(
                      title: 'New customers',
                      subtitle: '23k',
                      color: AppColors.orangeAccent,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        'View Reports',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.end,
                    children: ['Today', 'Yesterday', '7 days', '15 days', '30 days']
                        .map((label) => FilterChip(
                      label: Text(label),
                      selectedColor: AppColors.green,
                      selected: label == 'Today',
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          side:
                          const BorderSide(color: Colors.transparent)),
                      onSelected: (_) {},
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 240, child: CustomLineChart()),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5B7FE8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sales',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5DCCF5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Revenue',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              const SalesData(
                title: 'Overall Sales',
                subtitle: '12 millions',
                color: AppColors.blue,
              ),
              const SalesData(
                title: 'Overall Revenue',
                subtitle: '78 millions',
                color: AppColors.green,
              ),
              const SalesData(
                title: 'Overall Earnings',
                subtitle: '12 millions',
                color: AppColors.orange,
              ),
              const SalesData(
                title: 'New customers',
                subtitle: '23k',
                color: AppColors.orangeAccent,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text(
                  'View Reports',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(width: 124),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                runAlignment: WrapAlignment.end,
                children: ['Today', 'Yesterday', '7 days', '15 days', '30 days']
                    .map((label) => FilterChip(
                          label: Text(label),
                          selectedColor: AppColors.green,
                          selected: label == 'Today',
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                              side:
                                  const BorderSide(color: Colors.transparent)),
                          onSelected: (_) {},
                        ))
                    .toList(),
              ),
              const SizedBox(height: 340, child: CustomLineChart()),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5B7FE8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sales',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5DCCF5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Revenue',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
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

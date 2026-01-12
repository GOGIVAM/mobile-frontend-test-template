import 'package:flutter/material.dart';
import '../models/nav_items.dart';
import '../utils/app_breakpoints.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../widgets/kpi_card.dart';
import '../widgets/orders_table.dart';
import '../widgets/line_chart.dart';
import '../widgets/bar_chart.dart';
import '../widgets/navigation_drawer.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7FAFC),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Row(
//           children: [
//             Icon(Icons.home_outlined, color: Color(0xFF5B6FED)),
//             SizedBox(width: 8),
//             Text(
//               'Home',
//               style: TextStyle(
//                 color: Color(0xFF2D3748),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(Icons.chevron_right, color: Colors.grey, size: 20),
//             SizedBox(width: 8),
//             Text(
//               'Sales',
//               style: TextStyle(
//                 color: Color(0xFF2D3748),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Row(
//                     children: [
//                       Text(
//                         'You have ',
//                         style: TextStyle(fontSize: 13, color: Color(0xFF2D3748)),
//                       ),
//                       Text(
//                         '21',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         ' new leads',
//                         style: TextStyle(fontSize: 13, color: Color(0xFF2D3748)),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.celebration, color: Colors.amber, size: 18),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 const CircleAvatar(
//                   radius: 18,
//                   backgroundColor: Color(0xFF5B6FED),
//                   child: Icon(Icons.person, color: Colors.white, size: 20),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Abigale He...',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: const AppNavigationDrawer(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // KPI Cards Row
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 4,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 16,
//               childAspectRatio: 2.5,
//               children: const [
//                 KpiCard(
//                   icon: Icons.access_time,
//                   value: '250k',
//                   label: 'Sales',
//                   color: Color(0xFFFF6B6B),
//                 ),
//                 KpiCard(
//                   icon: Icons.emoji_emotions,
//                   value: '24m',
//                   label: 'Customers',
//                   color: Color(0xFF5B6FED),
//                 ),
//                 KpiCard(
//                   icon: Icons.shopping_bag,
//                   value: '15k',
//                   label: 'Products',
//                   color: Color(0xFFFFB020),
//                 ),
//                 KpiCard(
//                   icon: Icons.shopping_bag_outlined,
//                   value: '180m',
//                   label: 'Revenue',
//                   color: Color(0xFF51CF66),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             // Charts Row
//             const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: LineChart(),
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   flex: 1,
//                   child: BarChart(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             // Orders Table
//             const OrdersTable(),
//           ],
//         ),
//       ),
//     );
//   }
// }


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

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
          // KPI Cards (grid responsive)
          LayoutBuilder(
            builder: (_, constraints) {
              final crossCount = (constraints.maxWidth / 220).floor().clamp(1, 4);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: const [
                  KpiCard(title: 'Sales', value: '250k', color: AppColors.kpiSales, icon: Icons.trending_up),
                  KpiCard(title: 'Customers', value: '24m', color: AppColors.kpiCustomers, icon: Icons.people),
                  KpiCard(title: 'Products', value: '15k', color: AppColors.kpiProducts, icon: Icons.inventory),
                  KpiCard(title: 'Revenue', value: '180m', color: AppColors.kpiRevenue, icon: Icons.attach_money),
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
              Expanded(flex: 3, child: _buildSalesChartSection()),
              const SizedBox(width: 24),
              Expanded(flex: 2, child: CustomBarChart()),
            ],
          )
              : Column(
            children: [
              _buildSalesChartSection(),
              const SizedBox(height: 32),
              CustomBarChart(),
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
          title: const Text('Sales Dashboard'),
          actions: [
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(radius: 16, child: Text('A')),
            ),
          ],
        ),
        drawer: AppDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: bodyContent,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex.clamp(0, 3), // limit to 4 for bottom bar
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
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
            Expanded(child: bodyContent),
          ],
        ),
      );
    }

    return scaffold;
  }

  Widget _buildSalesChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Overall Sales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Today', 'Yesterday', '7 days', '15 days', '30 days']
                  .map((label) => FilterChip(
                label: Text(label),
                selected: label == 'Today',
                onSelected: (_) {},
              ))
                  .toList(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(height: 340, child: CustomLineChart()),
      ],
    );
  }
}
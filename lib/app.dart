import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_1/pages/analytics_page.dart';
import 'package:module_1/pages/dashboard_screen.dart';
import 'package:module_1/pages/products_page.dart';
import 'package:module_1/pages/reports_page.dart';
import 'package:module_1/providers/dashboard_provider.dart';
import 'package:module_1/utils/app_breakpoints.dart';
import 'package:module_1/utils/app_colors.dart';
import 'package:module_1/widgets/navigation_drawer.dart';

import 'models/nav_items.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final isDesktop = AppBreakpoints.isDesktop(width);

    final pages = [
      const DashboardContent(),
      const AnalyticsPage(),
      const ReportsPage(),
      const ProductsPage(),
    ];

    void onItemTapped(int index) {
      ref.read(selectedNavIndexProvider.notifier).state = index;
    }

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const BreadcrumbNav(),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 8),
            NotificationBadge(),
            SizedBox(width: 8),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(radius: 16, child: Text('A')),
            ),
          ],
        ),
        drawer: AppDrawer(
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
        body: IndexedStack(index: selectedIndex, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex.clamp(0, 3),
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.blue,
          items: mainNavItems.take(4).map((e) {
            return BottomNavigationBarItem(icon: Icon(e.icon), label: e.label);
          }).toList(),
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          ResponsiveNavigation(
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTapped,
            isRailExtended: isDesktop,
          ),
          Expanded(child: IndexedStack(index: selectedIndex, children: pages))
        ],
      ),
    );
  }
}

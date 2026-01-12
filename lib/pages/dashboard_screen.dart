// lib/pages/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../widgets/kpi_card.dart';
import '../widgets/orders_table.dart';
import '../widgets/line_chart.dart';
import '../widgets/bar_chart.dart';
import '../widgets/navigation_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.home_outlined, color: Color(0xFF5B6FED)),
            const SizedBox(width: 8),
            const Text(
              'Home',
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Sales',
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'You have ',
                        style: TextStyle(fontSize: 13, color: Color(0xFF2D3748)),
                      ),
                      const Text(
                        '21',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' new leads',
                        style: TextStyle(fontSize: 13, color: Color(0xFF2D3748)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.celebration, color: Colors.amber, size: 18),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF5B6FED),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  'Abigale He...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const AppNavigationDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Cards Row
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: const [
                KpiCard(
                  icon: Icons.access_time,
                  value: '250k',
                  label: 'Sales',
                  color: Color(0xFFFF6B6B),
                ),
                KpiCard(
                  icon: Icons.emoji_emotions,
                  value: '24m',
                  label: 'Customers',
                  color: Color(0xFF5B6FED),
                ),
                KpiCard(
                  icon: Icons.shopping_bag,
                  value: '15k',
                  label: 'Products',
                  color: Color(0xFFFFB020),
                ),
                KpiCard(
                  icon: Icons.shopping_bag_outlined,
                  value: '180m',
                  label: 'Revenue',
                  color: Color(0xFF51CF66),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Charts Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 2,
                  child: LineChart(),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: BarChart(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Orders Table
            const OrdersTable(),
          ],
        ),
      ),
    );
  }
}
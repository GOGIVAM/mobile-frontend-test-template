import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../models/stat_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/sales_chart.dart';
import '../widgets/orders_table.dart';
import '../widgets/main_layout.dart';
import '../widgets/bar_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = [
      StatCardData(
        title: 'Sales',
        value: '250k',
        icon: Icons.schedule,
        color: const Color(0xFFFF6B6B),
      ),
      StatCardData(
        title: 'Customers',
        value: '24m',
        icon: Icons.emoji_emotions_outlined,
        color: const Color(0xFF5B67F1),
      ),
      StatCardData(
        title: 'Products',
        value: '15k',
        icon: Icons.inventory_2_outlined,
        color: const Color(0xFFFFA726),
      ),
      StatCardData(
        title: 'Revenue',
        value: '180m',
        icon: Icons.shopping_bag_outlined,
        color: const Color(0xFF6FCF97),
      ),
    ];

    return MainLayout(
      title: const Row(
        children: [
          Icon(Icons.home_outlined, color: Colors.grey, size: 20),
          SizedBox(width: 8),
          Text(
            'Home',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey, size: 16),
          SizedBox(width: 8),
          Text(
            'Sales',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Search anything',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              suffixIcon: Icon(Icons.search, color: Colors.grey[600], size: 20),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              isDense: true,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const Text(
                'You have 21 new leads',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFF6FCF97),
                ),
                badgeContent: const SizedBox(
                  width: 2,
                  height: 2,
                ),
                position: badges.BadgePosition.topEnd(top: -1, end: -1),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF6FCF97),
                child: Text('🇧🇷', style: TextStyle(fontSize: 12)),
              ),
              SizedBox(width: 8),
              Text(
                'Abigale He...',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=1661&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
              ),
            ],
          ),
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              // Stats Cards Grid - 4 cartes horizontales
            Row(
              children: [
                ...stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < stats.length - 1 ? 16 : 0,
                      ),
                      child: KpiCard(data: stat),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 24),

            // Section principale : Graphique + Barre latérale (même hauteur)
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height:400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Graphique principal à gauche
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Titre et filtres

                              // Contenu principal : Légendes + Graphique
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Légendes à gauche
                                    SizedBox(
                                      width: 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildLegendItem(
                                            title: 'Overall Sales',
                                            value: '12 Millions',
                                            color: const Color(0xFF5B67F1),
                                          ),
                                          const SizedBox(height: 12),
                                          _buildLegendItem(
                                            title: 'Overall Earnings',
                                            value: '78 Millions',
                                            color: const Color(0xFF6FCF97),
                                          ),
                                          const SizedBox(height: 12),
                                          _buildLegendItem(
                                            title: 'Overall Revenue',
                                            value: '60 Millions',
                                            color: const Color(0xFFFF6B6B),
                                          ),
                                          const SizedBox(height: 12),
                                          _buildLegendItem(
                                            title: 'New Customers',
                                            value: '23k',
                                            color: const Color(0xFFFFA726),
                                          ),

                                          const SizedBox(height: 24),
                                          // View Reports Button
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF5B67F1),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal: 20,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text(
                                                'View Reports',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 64),
                                    // Graphique à droite
                                    const Expanded(
                                      child: LineChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Barre latérale droite avec le graphique Sales
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sales',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // Graphique en barres
                            const  Expanded(
                                child: Padding(
                                  padding:
                                       EdgeInsets.symmetric(vertical: 16),
                                  child: BarChart(),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '2100',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '12% higher than last month.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // Orders Table
            const OrdersTable(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        // TODO: Implémenter la logique de sélection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6FCF97) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF6FCF97) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

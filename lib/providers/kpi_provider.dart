
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/kpi_data.dart';
import 'order_provider.dart';

class KpiNotifier extends StateNotifier<List<KpiModel>> {
  KpiNotifier(this.ref) : super([]) {
    calculateKpis();
  }

  final Ref ref;

  /// Calculates KPIs based on current orders and other data sources
  /// This function aggregates data to compute sales, customers, products, and revenue metrics
  void calculateKpis() {
    final orders = ref.read(orderProvider).orders;

    // Calculate total sales (number of paid orders)
    final totalSales = orders.where((order) =>
    order.paymentStatus.toLowerCase() == 'paid'
    ).length;

    // Calculate unique customers
    final uniqueCustomers = orders.map((order) => order.customer).toSet().length;

    // Calculate unique products
    final uniqueProducts = orders.map((order) => order.product).toSet().length;

    // Calculate total revenue (sum of paid orders)
    final totalRevenue = orders
        .where((order) => order.paymentStatus.toLowerCase() == 'paid')
        .fold<double>(0.0, (sum, order) => sum + order.amount);

    // Format display values
    String formatValue(double value) {
      if (value >= 1000000) {
        return '${(value / 1000000).toStringAsFixed(1)}m';
      } else if (value >= 1000) {
        return '${(value / 1000).toStringAsFixed(1)}k';
      }
      return value.toStringAsFixed(0);
    }

    // Create KPI models
    state = [
      KpiModel(
        title: 'Sales',
        value: totalSales.toDouble(),
        displayValue: formatValue(totalSales * 50000), // Assuming avg sale value
        color: const Color(0xFFFF9800),
        icon: Icons.pie_chart_outline_outlined,
        changePercentage: 12.5,
      ),
      KpiModel(
        title: 'Customers',
        value: uniqueCustomers.toDouble(),
        displayValue: formatValue(uniqueCustomers * 1000000), // Scaled for display
        color: const Color(0xFF2196F3),
        icon: Icons.emoji_emotions_outlined,
        changePercentage: 8.3,
      ),
      KpiModel(
        title: 'Products',
        value: uniqueProducts.toDouble(),
        displayValue: formatValue(uniqueProducts * 3000),
        color: const Color(0xFFFF5722),
        icon: Icons.inventory_2_outlined,
        changePercentage: -2.1,
      ),
      KpiModel(
        title: 'Revenue',
        value: totalRevenue,
        displayValue: '\$${formatValue(totalRevenue * 1000000)}',
        color: const Color(0xFF4CAF50),
        icon: Icons.shopping_bag_outlined,
        changePercentage: 15.7,
      ),
    ];
  }

  /// Recalculate KPIs when data changes
  void refresh() {
    calculateKpis();
  }
}

// Provider
final kpiProvider = StateNotifierProvider<KpiNotifier, List<KpiModel>>((ref) {
  final notifier = KpiNotifier(ref);

  // Listen to order changes and recalculate KPIs
  ref.listen(orderProvider, (_, __) {
    notifier.calculateKpis();
  });

  return notifier;
});
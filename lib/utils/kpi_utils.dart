import 'package:module_1/models/order.dart';

/// Counts only paid orders (sales count)
int calculatePaidSalesCount(List<OrderModel> orders) {
  return orders.where((order) => order.paymentStatus.toLowerCase() == 'paid').length;
}

/// Counts unique customers
int calculateUniqueCustomers(List<OrderModel> orders) {
  return orders.map((order) => order.customer).toSet().length;
}

/// Counts unique products
int calculateUniqueProducts(List<OrderModel> orders) {
  return orders.map((order) => order.product).toSet().length;
}

/// Sums revenue only from paid orders
double calculatePaidRevenue(List<OrderModel> orders) {
  return orders
      .where((order) => order.paymentStatus.toLowerCase() == 'paid')
      .fold<double>(0.0, (sum, order) => sum + order.amount);
}

/// Simple formatter for display values (k, m suffixes)
String formatKpiValue(double value, {bool isCurrency = false}) {
  String prefix = isCurrency ? '\$' : '';
  if (value >= 1000000) {
    return '$prefix${(value / 1000000).toStringAsFixed(1)}m';
  } else if (value >= 1000) {
    return '$prefix${(value / 1000).toStringAsFixed(1)}k';
  }
  return '$prefix${value.toStringAsFixed(0)}';
}
import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/models/order.dart';
import 'package:module_1/utils/kpi_utils.dart';

void main() {
  final mockOrders = [
    OrderModel(
      id: '1',
      customer: 'Aisha',
      product: 'Headphones',
      userId: 'u1',
      customerCountry: 'CM',
      orderDate: DateTime(2025),
      amount: 120.0,
      paymentStatus: 'Paid',
      deliveryStatus: 'Delivered',
    ),
    OrderModel(
      id: '2',
      customer: 'Aisha',
      product: 'Headphones',
      userId: 'u1',
      customerCountry: 'CM',
      orderDate: DateTime(2025),
      amount: 200.0,
      paymentStatus: 'Pending',
      deliveryStatus: 'Processing',
    ),
    OrderModel(
      id: '3',
      customer: 'Jean',
      product: 'Watch',
      userId: 'u2',
      customerCountry: 'FR',
      orderDate: DateTime(2025),
      amount: 350.0,
      paymentStatus: 'Paid',
      deliveryStatus: 'Delivered',
    ),
  ];

  group('KPI calculation utilities', () {
    test('calculatePaidSalesCount counts only paid orders', () {
      expect(calculatePaidSalesCount(mockOrders), 2);
    });

    test('calculateUniqueCustomers counts distinct customers', () {
      expect(calculateUniqueCustomers(mockOrders), 2);
    });

    test('calculateUniqueProducts counts distinct products', () {
      expect(calculateUniqueProducts(mockOrders), 2);
    });

    test('calculatePaidRevenue sums only paid orders', () {
      expect(calculatePaidRevenue(mockOrders), 470.0); // 120 + 350
    });

    test('formatKpiValue adds k/m suffixes correctly', () {
      expect(formatKpiValue(2500000), '2.5m');
      expect(formatKpiValue(15000), '15.0k');
      expect(formatKpiValue(842), '842');
      expect(formatKpiValue(1200000, isCurrency: true), '\$1.2m');
    });

    test('formatKpiValue handles zero and small values', () {
      expect(formatKpiValue(0), '0');
      expect(formatKpiValue(999), '999');
    });
  });
}
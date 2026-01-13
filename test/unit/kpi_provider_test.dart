// test/unit/kpi_provider_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_1/models/order.dart';
import 'package:module_1/providers/kpi_provider.dart';
import 'package:module_1/providers/order_provider.dart';

void main() {
  group('KpiProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with KPI data', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis, isNotEmpty);
      expect(kpis.length, equals(4));
    });

    test('should have correct KPI titles', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].title, equals('Sales'));
      expect(kpis[1].title, equals('Customers'));
      expect(kpis[2].title, equals('Products'));
      expect(kpis[3].title, equals('Revenue'));
    });

    test('should have correct KPI icons', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].icon, equals(Icons.pie_chart_outline_outlined));
      expect(kpis[1].icon, equals(Icons.emoji_emotions_outlined));
      expect(kpis[2].icon, equals(Icons.inventory_2_outlined));
      expect(kpis[3].icon, equals(Icons.shopping_bag_outlined));
    });

    test('should have correct KPI colors', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].color, equals(const Color(0xFFFF9800)));
      expect(kpis[1].color, equals(const Color(0xFF2196F3)));
      expect(kpis[2].color, equals(const Color(0xFFFF5722)));
      expect(kpis[3].color, equals(const Color(0xFF4CAF50)));
    });

    test('should calculate KPIs based on orders', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].value, greaterThan(0)); // Sales
      expect(kpis[1].value, greaterThan(0)); // Customers
      expect(kpis[2].value, greaterThan(0)); // Products
      expect(kpis[3].value, greaterThan(0)); // Revenue
    });

    test('should have change percentages', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].changePercentage, equals(12.5));
      expect(kpis[1].changePercentage, equals(8.3));
      expect(kpis[2].changePercentage, equals(-2.1));
      expect(kpis[3].changePercentage, equals(15.7));
    });

    test('should refresh KPIs when called', () {
      // Arrange
      final initialKpis = container.read(kpiProvider);

      // Act
      container.read(kpiProvider.notifier).refresh();
      final refreshedKpis = container.read(kpiProvider);

      // Assert
      expect(refreshedKpis.length, equals(4));
      expect(refreshedKpis.length, equals(initialKpis.length));
    });

    test('should have formatted display values', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert
      expect(kpis[0].displayValue, isNotEmpty);
      expect(kpis[1].displayValue, isNotEmpty);
      expect(kpis[2].displayValue, isNotEmpty);
      expect(kpis[3].displayValue, isNotEmpty);
    });

    test('should format values with k for thousands', () {
      // Act
      final kpis = container.read(kpiProvider);

      // Assert - At least one should have 'k' or 'm' formatting
      final hasFormattedValue = kpis.any((kpi) =>
      kpi.displayValue.contains('k') || kpi.displayValue.contains('m')
      );
      expect(hasFormattedValue, isTrue);
    });

    test('should include dollar sign for revenue', () {
      // Act
      final kpis = container.read(kpiProvider);
      final revenueKpi = kpis.firstWhere((kpi) => kpi.title == 'Revenue');

      // Assert
      expect(revenueKpi.displayValue, startsWith('\$'));
    });
  });

  group('KPI Calculation Logic', () {
    test('should count only paid orders for sales', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [
              OrderModel(
                id: '1',
                customer: 'Customer 1',
                product: 'Product 1',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 100.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'US',
              ),
              OrderModel(
                id: '2',
                customer: 'Customer 2',
                product: 'Product 2',
                userId: 'User2',
                orderDate: DateTime.now(),
                amount: 200.0,
                paymentStatus: 'Pending',
                deliveryStatus: 'Processing',
                customerCountry: 'CA',
              ),
            ])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);
      final salesKpi = kpis.firstWhere((kpi) => kpi.title == 'Sales');

      // Assert - Should count only 1 paid order
      expect(salesKpi.value, equals(1.0));

      container.dispose();
    });

    test('should count unique customers', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [
              OrderModel(
                id: '1',
                customer: 'Customer A',
                product: 'Product 1',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 100.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'US',
              ),
              OrderModel(
                id: '2',
                customer: 'Customer A', // Same customer
                product: 'Product 2',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 200.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Processing',
                customerCountry: 'US',
              ),
              OrderModel(
                id: '3',
                customer: 'Customer B',
                product: 'Product 3',
                userId: 'User2',
                orderDate: DateTime.now(),
                amount: 150.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'CA',
              ),
            ])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);
      final customersKpi = kpis.firstWhere((kpi) => kpi.title == 'Customers');

      // Assert - Should count 2 unique customers
      expect(customersKpi.value, equals(2.0));

      container.dispose();
    });

    test('should count unique products', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [
              OrderModel(
                id: '1',
                customer: 'Customer 1',
                product: 'Product A',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 100.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'US',
              ),
              OrderModel(
                id: '2',
                customer: 'Customer 2',
                product: 'Product A', // Same product
                userId: 'User2',
                orderDate: DateTime.now(),
                amount: 200.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Processing',
                customerCountry: 'CA',
              ),
              OrderModel(
                id: '3',
                customer: 'Customer 3',
                product: 'Product B',
                userId: 'User3',
                orderDate: DateTime.now(),
                amount: 150.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'UK',
              ),
            ])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);
      final productsKpi = kpis.firstWhere((kpi) => kpi.title == 'Products');

      // Assert - Should count 2 unique products
      expect(productsKpi.value, equals(2.0));

      container.dispose();
    });

    test('should sum revenue from paid orders only', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [
              OrderModel(
                id: '1',
                customer: 'Customer 1',
                product: 'Product 1',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 100.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'US',
              ),
              OrderModel(
                id: '2',
                customer: 'Customer 2',
                product: 'Product 2',
                userId: 'User2',
                orderDate: DateTime.now(),
                amount: 200.0,
                paymentStatus: 'Pending', // Not paid
                deliveryStatus: 'Processing',
                customerCountry: 'CA',
              ),
              OrderModel(
                id: '3',
                customer: 'Customer 3',
                product: 'Product 3',
                userId: 'User3',
                orderDate: DateTime.now(),
                amount: 150.0,
                paymentStatus: 'Paid',
                deliveryStatus: 'Delivered',
                customerCountry: 'UK',
              ),
            ])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);
      final revenueKpi = kpis.firstWhere((kpi) => kpi.title == 'Revenue');

      // Assert - Should sum only paid orders (100 + 150 = 250)
      expect(revenueKpi.value, equals(250.0));

      container.dispose();
    });
  });

  group('KPI Formatting Tests', () {
    test('should format millions correctly', () {
      // Arrange
      const testValue = 2500000.0; // 2.5 million

      String formatValue(double value) {
        if (value >= 1000000) {
          return '${(value / 1000000).toStringAsFixed(1)}m';
        } else if (value >= 1000) {
          return '${(value / 1000).toStringAsFixed(1)}k';
        }
        return value.toStringAsFixed(0);
      }

      // Act
      final formatted = formatValue(testValue);

      // Assert
      expect(formatted, equals('2.5m'));
    });

    test('should format thousands correctly', () {
      // Arrange
      const testValue = 15000.0; // 15 thousand

      String formatValue(double value) {
        if (value >= 1000000) {
          return '${(value / 1000000).toStringAsFixed(1)}m';
        } else if (value >= 1000) {
          return '${(value / 1000).toStringAsFixed(1)}k';
        }
        return value.toStringAsFixed(0);
      }

      // Act
      final formatted = formatValue(testValue);

      // Assert
      expect(formatted, equals('15.0k'));
    });

    test('should format small numbers without suffix', () {
      // Arrange
      const testValue = 500.0;

      String formatValue(double value) {
        if (value >= 1000000) {
          return '${(value / 1000000).toStringAsFixed(1)}m';
        } else if (value >= 1000) {
          return '${(value / 1000).toStringAsFixed(1)}k';
        }
        return value.toStringAsFixed(0);
      }

      // Act
      final formatted = formatValue(testValue);

      // Assert
      expect(formatted, equals('500'));
    });
  });

  group('KPI Integration with Orders', () {
    test('should recalculate when orders are added', () {
      // Arrange
      final container = ProviderContainer();
      // Act - Add a new order
      container.read(orderProvider.notifier).addOrder(
        OrderModel(
          id: '999',
          customer: 'New Customer',
          product: 'New Product',
          userId: 'NewUser',
          orderDate: DateTime.now(),
          amount: 500.0,
          paymentStatus: 'Paid',
          deliveryStatus: 'Processing',
          customerCountry: 'US',
        ),
      );

      // Get updated KPIs
      final updatedKpis = container.read(kpiProvider);

      // Assert - KPIs should be recalculated
      expect(updatedKpis, isNotNull);
      expect(updatedKpis.length, equals(4));

      container.dispose();
    });

    test('should handle order deletion', () {
      // Arrange
      final container = ProviderContainer();

      // Act - Delete an order
      container.read(orderProvider.notifier).deleteOrder('1');
      final kpis = container.read(kpiProvider);

      // Assert - KPIs should be updated
      expect(kpis, isNotEmpty);

      container.dispose();
    });

    test('should handle order update', () {
      // Arrange
      final container = ProviderContainer();
      final orders = container.read(orderProvider).orders;
      final firstOrder = orders.first;

      // Act - Update an order
      container.read(orderProvider.notifier).updateOrder(
        firstOrder.copyWith(paymentStatus: 'Failed'),
      );
      final kpis = container.read(kpiProvider);

      // Assert - KPIs should reflect the change
      expect(kpis, isNotEmpty);

      container.dispose();
    });
  });

  group('Edge Cases', () {
    test('should handle empty orders list', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);

      // Assert - Should handle gracefully
      expect(kpis, isNotEmpty);
      expect(kpis.length, equals(4));
      expect(kpis.every((kpi) => kpi.value == 0), isTrue);

      container.dispose();
    });

    test('should handle all pending orders', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref) => OrderNotifier()
            ..state = OrderState(orders: [
              OrderModel(
                id: '1',
                customer: 'Customer 1',
                product: 'Product 1',
                userId: 'User1',
                orderDate: DateTime.now(),
                amount: 100.0,
                paymentStatus: 'Pending',
                deliveryStatus: 'Processing',
                customerCountry: 'US',
              ),
            ])),
        ],
      );

      // Act
      final kpis = container.read(kpiProvider);
      final salesKpi = kpis.firstWhere((kpi) => kpi.title == 'Sales');
      final revenueKpi = kpis.firstWhere((kpi) => kpi.title == 'Revenue');

      // Assert - No paid orders
      expect(salesKpi.value, equals(0.0));
      expect(revenueKpi.value, equals(0.0));

      container.dispose();
    });
  });
}
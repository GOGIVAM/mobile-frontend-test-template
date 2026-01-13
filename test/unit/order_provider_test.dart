// test/unit/order_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_1/models/order.dart';
import 'package:module_1/providers/order_provider.dart';


void main() {
  group('OrderProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with mock orders', () {
      // Act
      final state = container.read(orderProvider);

      // Assert
      expect(state.orders, isNotEmpty);
      expect(state.orders.length, equals(5));
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should have correct initial orders data', () {
      // Act
      final orders = container.read(orderProvider).orders;

      // Assert
      expect(orders[0].customer, equals('Ellie Collins'));
      expect(orders[0].product, equals('Ginger Snacks'));
      expect(orders[0].amount, equals(18.00));
      expect(orders[0].paymentStatus, equals('Paid'));
    });

    test('should add new order', () {
      // Arrange
      final newOrder = OrderModel(
        id: '6',
        customer: 'Test Customer',
        product: 'Test Product',
        userId: 'Test123',
        orderDate: DateTime.now(),
        amount: 99.99,
        paymentStatus: 'Paid',
        deliveryStatus: 'Processing',
        customerCountry: 'US',
      );

      // Act
      container.read(orderProvider.notifier).addOrder(newOrder);
      final state = container.read(orderProvider);

      // Assert
      expect(state.orders.length, equals(6));
      expect(state.orders.last.id, equals('6'));
      expect(state.orders.last.customer, equals('Test Customer'));
    });

    test('should update existing order', () {
      // Arrange
      final orders = container.read(orderProvider).orders;
      final orderToUpdate = orders.first;
      final updatedOrder = orderToUpdate.copyWith(
        paymentStatus: 'Failed',
        deliveryStatus: 'Cancelled',
      );

      // Act
      container.read(orderProvider.notifier).updateOrder(updatedOrder);
      final state = container.read(orderProvider);

      // Assert
      final updatedInState = state.orders.firstWhere((o) => o.id == orderToUpdate.id);
      expect(updatedInState.paymentStatus, equals('Failed'));
      expect(updatedInState.deliveryStatus, equals('Cancelled'));
    });

    test('should delete order by ID', () {
      // Arrange
      final initialCount = container.read(orderProvider).orders.length;

      // Act
      container.read(orderProvider.notifier).deleteOrder('1');
      final state = container.read(orderProvider);

      // Assert
      expect(state.orders.length, equals(initialCount - 1));
      expect(state.orders.any((o) => o.id == '1'), isFalse);
    });
  });

  group('Swipe to Action Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should approve order on swipe approve', () {
      // Arrange
      final orderId = container.read(orderProvider).orders.first.id;

      // Act
      container.read(orderProvider.notifier).swipeToAction(
        orderId,
        OrderAction.approve,
      );
      final state = container.read(orderProvider);

      // Assert
      final order = state.orders.firstWhere((o) => o.id == orderId);
      expect(order.paymentStatus, equals('Paid'));
      expect(order.deliveryStatus, equals('Processing'));
    });

    test('should reject order on swipe reject', () {
      // Arrange
      final orderId = container.read(orderProvider).orders.first.id;

      // Act
      container.read(orderProvider.notifier).swipeToAction(
        orderId,
        OrderAction.reject,
      );
      final state = container.read(orderProvider);

      // Assert
      final order = state.orders.firstWhere((o) => o.id == orderId);
      expect(order.paymentStatus, equals('Failed'));
      expect(order.deliveryStatus, equals('Cancelled'));
    });

    test('should delete order on swipe delete', () {
      // Arrange
      final orderId = '2';
      final initialCount = container.read(orderProvider).orders.length;

      // Act
      container.read(orderProvider.notifier).swipeToAction(
        orderId,
        OrderAction.delete,
      );
      final state = container.read(orderProvider);

      // Assert
      expect(state.orders.length, equals(initialCount - 1));
      expect(state.orders.any((o) => o.id == orderId), isFalse);
    });

    test('should handle swipe on non-existent order', () {
      // Arrange
      final initialOrders = container.read(orderProvider).orders;

      // Act
      container.read(orderProvider.notifier).swipeToAction(
        'non-existent-id',
        OrderAction.approve,
      );
      final state = container.read(orderProvider);

      // Assert - Should not change anything
      expect(state.orders.length, equals(initialOrders.length));
    });
  });

  group('OrderState Tests', () {
    test('should create state with copyWith', () {
      // Arrange
      final originalState = OrderState(
        orders: [],
        isLoading: true,
      );

      // Act
      final newState = originalState.copyWith(
        isLoading: false,
        orders: [
          OrderModel(
            id: '1',
            customer: 'Test',
            product: 'Test Product',
            userId: 'User1',
            orderDate: DateTime.now(),
            amount: 100.0,
            paymentStatus: 'Paid',
            deliveryStatus: 'Delivered',
            customerCountry: 'US',
          ),
        ],
      );

      // Assert
      expect(newState.isLoading, isFalse);
      expect(originalState.isLoading, isTrue); // Original unchanged
      expect(newState.orders.length, equals(1));
      expect(originalState.orders, isEmpty); // Original unchanged
    });

    test('should preserve fields when not specified in copyWith', () {
      // Arrange
      final originalState = OrderState(
        orders: [
          OrderModel(
            id: '1',
            customer: 'Test',
            product: 'Test Product',
            userId: 'User1',
            orderDate: DateTime.now(),
            amount: 100.0,
            paymentStatus: 'Paid',
            deliveryStatus: 'Delivered',
            customerCountry: 'US',
          ),
        ],
        isLoading: true,
      );

      // Act
      final newState = originalState.copyWith(
        isLoading: false,
      );

      // Assert
      expect(newState.isLoading, isFalse);
      expect(newState.orders.length, equals(1)); // Preserved from original
    });
  });

  group('Order Model Tests', () {
    test('should create order with copyWith', () {
      // Arrange
      final original = OrderModel(
        id: '1',
        customer: 'John Doe',
        product: 'Product A',
        userId: 'User1',
        orderDate: DateTime(2021, 12, 1),
        amount: 100.0,
        paymentStatus: 'Pending',
        deliveryStatus: 'Processing',
        customerCountry: 'US',
      );

      // Act
      final updated = original.copyWith(
        paymentStatus: 'Paid',
        deliveryStatus: 'Shipped',
      );

      // Assert
      expect(updated.paymentStatus, equals('Paid'));
      expect(updated.deliveryStatus, equals('Shipped'));
      expect(updated.customer, equals('John Doe')); // Unchanged
      expect(updated.amount, equals(100.0)); // Unchanged
    });
  });

  group('Integration Tests', () {
    test('should handle multiple operations in sequence', () {
      // Arrange
      final container = ProviderContainer();

      // Act - Add order
      container.read(orderProvider.notifier).addOrder(
        OrderModel(
          id: '100',
          customer: 'New Customer',
          product: 'New Product',
          userId: 'New123',
          orderDate: DateTime.now(),
          amount: 150.0,
          paymentStatus: 'Pending',
          deliveryStatus: 'Processing',
          customerCountry: 'CA',
        ),
      );

      // Approve it
      container.read(orderProvider.notifier).swipeToAction(
        '100',
        OrderAction.approve,
      );

      // Assert
      final state = container.read(orderProvider);
      final order = state.orders.firstWhere((o) => o.id == '100');
      expect(order.paymentStatus, equals('Paid'));
      expect(order.deliveryStatus, equals('Processing'));

      container.dispose();
    });

    test('should maintain order count correctly', () {
      // Arrange
      final container = ProviderContainer();
      final initialCount = container.read(orderProvider).orders.length;

      // Act - Add 3, delete 2
      for (int i = 0; i < 3; i++) {
        container.read(orderProvider.notifier).addOrder(
          OrderModel(
            id: '${100 + i}',
            customer: 'Customer $i',
            product: 'Product $i',
            userId: 'User$i',
            orderDate: DateTime.now(),
            amount: 100.0 * i,
            paymentStatus: 'Pending',
            deliveryStatus: 'Processing',
            customerCountry: 'US',
          ),
        );
      }

      container.read(orderProvider.notifier).deleteOrder('1');
      container.read(orderProvider.notifier).deleteOrder('2');

      // Assert
      final finalCount = container.read(orderProvider).orders.length;
      expect(finalCount, equals(initialCount + 3 - 2)); // 5 + 3 - 2 = 6

      container.dispose();
    });
  });

  group('Edge Cases', () {
    test('should handle updating non-existent order', () {
      // Arrange
      final container = ProviderContainer();
      final initialOrders = container.read(orderProvider).orders;

      // Act
      container.read(orderProvider.notifier).updateOrder(
        OrderModel(
          id: 'non-existent',
          customer: 'Test',
          product: 'Test',
          userId: 'Test',
          orderDate: DateTime.now(),
          amount: 100.0,
          paymentStatus: 'Paid',
          deliveryStatus: 'Delivered',
          customerCountry: 'US',
        ),
      );

      // Assert - Should not add new order, just ignore
      final finalOrders = container.read(orderProvider).orders;
      expect(finalOrders.length, equals(initialOrders.length));

      container.dispose();
    });

    test('should handle deleting already deleted order', () {
      // Arrange
      final container = ProviderContainer();
      container.read(orderProvider.notifier).deleteOrder('1');

      // Act - Try to delete again
      container.read(orderProvider.notifier).deleteOrder('1');
      final state = container.read(orderProvider);

      // Assert - Should not crash
      expect(state.orders.any((o) => o.id == '1'), isFalse);

      container.dispose();
    });

    test('should handle orders with same customer', () {
      // Arrange
      final container = ProviderContainer();

      // Act - Add multiple orders for same customer
      for (int i = 0; i < 3; i++) {
        container.read(orderProvider.notifier).addOrder(
          OrderModel(
            id: '${100 + i}',
            customer: 'Same Customer',
            product: 'Product $i',
            userId: 'User1',
            orderDate: DateTime.now(),
            amount: 100.0,
            paymentStatus: 'Paid',
            deliveryStatus: 'Delivered',
            customerCountry: 'US',
          ),
        );
      }

      final state = container.read(orderProvider);

      // Assert - All orders should be added
      final sameCustomerOrders = state.orders
          .where((o) => o.customer == 'Same Customer')
          .length;
      expect(sameCustomerOrders, equals(3));

      container.dispose();
    });

    test('should handle orders with zero amount', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      container.read(orderProvider.notifier).addOrder(
        OrderModel(
          id: '200',
          customer: 'Test Customer',
          product: 'Free Product',
          userId: 'User1',
          orderDate: DateTime.now(),
          amount: 0.0,
          paymentStatus: 'Paid',
          deliveryStatus: 'Delivered',
          customerCountry: 'US',
        ),
      );

      final state = container.read(orderProvider);
      final order = state.orders.firstWhere((o) => o.id == '200');

      // Assert
      expect(order.amount, equals(0.0));

      container.dispose();
    });
  });

  group('Data Validation Tests', () {
    test('all initial orders should have required fields', () {
      final container = ProviderContainer();

      // Act
      final orders = container.read(orderProvider).orders;

      // Assert
      for (final order in orders) {
        expect(order.id, isNotEmpty);
        expect(order.customer, isNotEmpty);
        expect(order.product, isNotEmpty);
        expect(order.userId, isNotEmpty);
        expect(order.paymentStatus, isNotEmpty);
        expect(order.deliveryStatus, isNotEmpty);
        expect(order.customerCountry, isNotEmpty);
        expect(order.amount, greaterThanOrEqualTo(0));
      }
    });

    test('should have valid payment statuses', () {
      final container = ProviderContainer();

      // Act
      final orders = container.read(orderProvider).orders;

      // Assert
      final validStatuses = ['Paid', 'Pending', 'Failed'];
      for (final order in orders) {
        expect(validStatuses.contains(order.paymentStatus), isTrue);
      }
    });

    test('should have valid delivery statuses', () {
      final container = ProviderContainer();

      // Act
      final orders = container.read(orderProvider).orders;

      // Assert
      final validStatuses = ['Delivered', 'Shipped', 'Processing', 'Cancelled'];
      for (final order in orders) {
        expect(validStatuses.contains(order.deliveryStatus), isTrue);
      }
    });
  });
}

import 'package:flutter_riverpod/legacy.dart';

import '../models/order.dart';

class OrderState {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;

  OrderState({
    required this.orders,
    this.isLoading = false,
    this.error,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState(orders: _generateMockOrders()));

  static List<OrderModel> _generateMockOrders() {
    return [
      OrderModel(
        id: '1',
        customer: 'Ellie Collins',
        product: 'Ginger Snacks',
        userId: 'Arise827',
        orderDate: DateTime(2021, 12, 12),
        amount: 18.00,
        paymentStatus: 'Paid',
        deliveryStatus: 'Delivered', customerCountry: 'US',
      ),
      OrderModel(
        id: '2',
        customer: 'John Smith',
        product: 'Chocolate Bars',
        userId: 'Wave123',
        orderDate: DateTime(2021, 12, 10),
        amount: 25.00,
        paymentStatus: 'Paid',
        deliveryStatus: 'Shipped', customerCountry: 'CA',
      ),
      OrderModel(
        id: '3',
        customer: 'Sarah Johnson',
        product: 'Protein Powder',
        userId: 'Peak456',
        orderDate: DateTime(2021, 12, 8),
        amount: 45.00,
        paymentStatus: 'Pending',
        deliveryStatus: 'Processing', customerCountry: 'CM',
      ),
      OrderModel(
        id: '4',
        customer: 'Mike Davis',
        product: 'Energy Drinks',
        userId: 'Bolt789',
        orderDate: DateTime(2021, 12, 5),
        amount: 32.00,
        paymentStatus: 'Paid',
        deliveryStatus: 'Delivered', customerCountry: 'JA',
      ),
      OrderModel(
        id: '5',
        customer: 'Emma Wilson',
        product: 'Vitamin Pack',
        userId: 'Vital321',
        orderDate: DateTime(2021, 12, 3),
        amount: 55.00,
        paymentStatus: 'Failed',
        deliveryStatus: 'Cancelled', customerCountry: 'CH',
      ),
    ];
  }

  /// Handles swipe-to-action functionality for orders
  /// This function is called when a user swipes on an order item
  void swipeToAction(String orderId, OrderAction action) {
    final orderIndex = state.orders.indexWhere((order) => order.id == orderId);

    if (orderIndex == -1) return;

    final updatedOrders = List<OrderModel>.from(state.orders);
    final order = updatedOrders[orderIndex];

    switch (action) {
      case OrderAction.approve:
      // Approve order - update payment and delivery status
        updatedOrders[orderIndex] = order.copyWith(
          paymentStatus: 'Paid',
          deliveryStatus: 'Processing',
        );
        break;

      case OrderAction.reject:
      // Reject order - update to cancelled status
        updatedOrders[orderIndex] = order.copyWith(
          paymentStatus: 'Failed',
          deliveryStatus: 'Cancelled',
        );
        break;

      case OrderAction.delete:
      // Delete order from list
        updatedOrders.removeAt(orderIndex);
        break;
    }

    state = state.copyWith(orders: updatedOrders);
  }

  /// Add a new order
  void addOrder(OrderModel order) {
    state = state.copyWith(
      orders: [...state.orders, order],
    );
  }

  /// Update an existing order
  void updateOrder(OrderModel updatedOrder) {
    final updatedOrders = state.orders.map((order) {
      return order.id == updatedOrder.id ? updatedOrder : order;
    }).toList();

    state = state.copyWith(orders: updatedOrders);
  }

  /// Delete an order by ID
  void deleteOrder(String orderId) {
    swipeToAction(orderId, OrderAction.delete);
  }
}

// Provider
final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier();
});
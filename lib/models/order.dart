import 'package:flutter/material.dart';


enum OrderAction { approve, reject, delete }

class OrderModel {
  final String id;
  final String customer;
  final String product;
  final String userId;
  final String customerCountry;
  final DateTime orderDate;
  final double amount;
  final String paymentStatus;
  final String deliveryStatus;

  OrderModel({
    required this.id,
    required this.customer,
    required this.product,
    required this.userId,
    required this.customerCountry,
    required this.orderDate,
    required this.amount,
    required this.paymentStatus,
    required this.deliveryStatus,
  });

  Color get paymentColor {
    switch (paymentStatus.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get deliveryColor {
    switch (deliveryStatus.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.orange;
      case 'processing':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  OrderModel copyWith({
    String? id,
    String? customer,
    String? customerCountry,
    String? product,
    String? userId,
    DateTime? orderDate,
    double? amount,
    String? paymentStatus,
    String? deliveryStatus,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      customerCountry: customerCountry ?? this.customerCountry,
      product: product ?? this.product,
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      amount: amount ?? this.amount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    );
  }
}


class Order {
  final String customerName;
  final String customerImage;
  final String product;
  final String productImage;
  final String userId;
  final String orderedDate;
  final double amount;
  final PaymentStatus paymentStatus;
  final DeliveryStatus deliveryStatus;

  Order({
    required this.customerName,
    required this.customerImage,
    required this.product,
    required this.productImage,
    required this.userId,
    required this.orderedDate,
    required this.amount,
    required this.paymentStatus,
    required this.deliveryStatus,
  });
}

enum PaymentStatus {
  paid,
  pending,
  failed,
}

enum DeliveryStatus {
  delivered,
  pending,
  cancelled,
}


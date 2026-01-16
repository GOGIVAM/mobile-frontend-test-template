class Order {
  final String customerName;
  final String customerImage;
  final String productName;
  final String productImage;
  final String userId;
  final String date;
  final String amount;
  final String paymentStatus; // e.g., 'Paid'
  final String deliveryStatus; // e.g., 'Delivered'

  Order({
    required this.customerName,
    required this.customerImage,
    required this.productName,
    required this.productImage,
    required this.userId,
    required this.date,
    required this.amount,
    required this.paymentStatus,
    required this.deliveryStatus,
  });
}

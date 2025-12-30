import '../models/order.dart';

class MockData {
  static List<Order> getOrders() {
    return [
      Order(
        customerName: 'Ellie Collins',
        customerImage: '👨‍💼',
        product: 'Ginger Snacks',
        productImage: '🥗',
        userId: 'Arise827',
        orderedDate: '12/12/2021',
        amount: 18.00,
        paymentStatus: PaymentStatus.paid,
        deliveryStatus: DeliveryStatus.delivered,
      ),
      Order(
        customerName: 'John Smith',
        customerImage: '👨',
        product: 'Organic Fruits',
        productImage: '🍎',
        userId: 'User123',
        orderedDate: '15/12/2021',
        amount: 25.50,
        paymentStatus: PaymentStatus.paid,
        deliveryStatus: DeliveryStatus.pending,
      ),
      Order(
        customerName: 'Sarah Johnson',
        customerImage: '👩',
        product: 'Healthy Drinks',
        productImage: '🥤',
        userId: 'Sarah456',
        orderedDate: '18/12/2021',
        amount: 12.75,
        paymentStatus: PaymentStatus.pending,
        deliveryStatus: DeliveryStatus.pending,
      ),
      Order(
        customerName: 'Mike Brown',
        customerImage: '👨‍🦰',
        product: 'Protein Bars',
        productImage: '🍫',
        userId: 'Mike789',
        orderedDate: '20/12/2021',
        amount: 32.00,
        paymentStatus: PaymentStatus.paid,
        deliveryStatus: DeliveryStatus.delivered,
      ),
      Order(
        customerName: 'Emily Davis',
        customerImage: '👩‍🦱',
        product: 'Salad Bowl',
        productImage: '🥗',
        userId: 'Emily321',
        orderedDate: '22/12/2021',
        amount: 15.25,
        paymentStatus: PaymentStatus.failed,
        deliveryStatus: DeliveryStatus.cancelled,
      ),
    ];
  }

  static List<SalesDataPoint> getSalesData() {
    return [
      SalesDataPoint(month: 'Jan', sales: 20, revenue: 15),
      SalesDataPoint(month: 'Feb', sales: 35, revenue: 28),
      SalesDataPoint(month: 'Mar', sales: 25, revenue: 22),
      SalesDataPoint(month: 'Apr', sales: 40, revenue: 35),
      SalesDataPoint(month: 'May', sales: 20, revenue: 20),
      SalesDataPoint(month: 'Jun', sales: 45, revenue: 38),
      SalesDataPoint(month: 'Jul', sales: 50, revenue: 42),
      SalesDataPoint(month: 'Aug', sales: 55, revenue: 48),
      SalesDataPoint(month: 'Sep', sales: 48, revenue: 45),
      SalesDataPoint(month: 'Oct', sales: 65, revenue: 55),
      SalesDataPoint(month: 'Nov', sales: 70, revenue: 62),
      SalesDataPoint(month: 'Dec', sales: 75, revenue: 68),
    ];
  }
}

class SalesDataPoint {
  final String month;
  final double sales;
  final double revenue;

  SalesDataPoint({
    required this.month,
    required this.sales,
    required this.revenue,
  });
}


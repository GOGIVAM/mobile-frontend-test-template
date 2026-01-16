import 'package:get/get.dart';
import '../models/order.dart';

class OrderProvider extends GetxController {
  // Reactive list of orders
  final orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // Fetches orders from a mock source
  Future<void> fetchOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    orders.assignAll([
      Order(
        customerName: 'Ellie Collins',
        customerImage: 'assets/images/avatar.png',
        productName: 'Ginger Snacks',
        productImage: 'assets/images/ginger.png',
        userId: 'Arise827',
        date: '12/12/2021',
        amount: '\$18.00',
        paymentStatus: 'Paid',
        deliveryStatus: 'Delivered',
      ),
      Order(
        customerName: 'John Doe',
        customerImage: 'assets/images/avatar.png',
        productName: 'Banana Chips',
        productImage: 'assets/images/ginger.png',
        userId: 'JDoe99',
        date: '15/12/2021',
        amount: '\$12.50',
        paymentStatus: 'Paid',
        deliveryStatus: 'Pending',
      ),
    ]);
  }

  // Handles swipe-to-action
  void swipeToAction(int index) {
    if (index >= 0 && index < orders.length) {
      orders.removeAt(index);
      Get.snackbar(
        'Success',
        'Order removed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

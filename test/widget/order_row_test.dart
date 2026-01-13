import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_frontend_test_template/widgets/orders_table.dart';
import 'package:mobile_frontend_test_template/providers/order_provider.dart';

void main() {
  testWidgets('OrdersTable displays the delivery status badge', (WidgetTester tester) async {
    // Initialize the provider needed by OrdersTable
    Get.put(OrderProvider());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: OrdersTable(),
        ),
      ),
    );

    // Wait for the mock fetch in OrderProvider (1 second delay)
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    // Verify the status badge text exists
    expect(find.text('Delivered'), findsOneWidget);
  });
}

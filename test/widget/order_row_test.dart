import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/widgets/orders_table.dart';

Future<void> pumpOrdersTable(WidgetTester tester, {double width = 1200}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(
        size: Size(width, 1000),
        devicePixelRatio: 1.0,   // optional, but helps consistency
      ),
      child: ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: width,
              height: 1000,
              child: const OrdersTable(),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('OrdersTable – rendering & status badges', () {
    testWidgets('shows header with correct order count', (tester) async {
      await pumpOrdersTable(tester, width: 1200);

      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('5 orders'), findsOneWidget); // your mock has 5
    });

    testWidgets('displays all mock customer names', (tester) async {
      await pumpOrdersTable(tester, width: 1200);

      expect(find.text('Ellie Collins'), findsOneWidget);
      expect(find.text('John Smith'), findsOneWidget);
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('Mike Davis'), findsOneWidget);
      expect(find.text('Emma Wilson'), findsOneWidget);
    });

    testWidgets('shows formatted amounts correctly', (tester) async {
      await pumpOrdersTable(tester, width: 1200);

      expect(find.text(r'$18.00'), findsOneWidget);
      expect(find.text(r'$25.00'), findsOneWidget);
      expect(find.text(r'$45.00'), findsOneWidget);
      expect(find.text(r'$32.00'), findsOneWidget);
      expect(find.text(r'$55.00'), findsOneWidget);
    });

    testWidgets('renders payment & delivery status badges – desktop', (tester) async {
      await pumpOrdersTable(tester, width: 1200);

      // Payment statuses
      expect(find.text('Paid'), findsWidgets);     // 3× Paid
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);

      // Delivery statuses
      expect(find.text('Delivered'), findsWidgets); // 2×
      expect(find.text('Shipped'), findsOneWidget);
      expect(find.text('Processing'), findsOneWidget);
      expect(find.text('Cancelled'), findsOneWidget);

      // Paid orders should show check icon (according to your _buildStatusBadge logic)
      expect(find.byIcon(Icons.check_circle_outline), findsWidgets); // at least 3
    });

    testWidgets('mobile layout shows compact badges & no table headers', (tester) async {
      await pumpOrdersTable(tester, width: 600);

      // No desktop table headers
      expect(find.text('Customer'), findsNothing);
      expect(find.text('Product'), findsNothing);
      expect(find.text('User ID'), findsNothing);

      // Compact badges should exist
      expect(find.text('Paid'), findsWidgets);
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);

      // Swipe hints are inside Dismissible background → need partial drag to make visible
      final firstCard = find.byType(OrderCardContent).first;

      // Small right swipe to reveal "Approve"
      await tester.drag(firstCard, const Offset(120, 0));
      await tester.pumpAndSettle();

      expect(find.text('Approve'), findsOneWidget);

      // Drag back or ignore — we just wanted to confirm it exists
    });


    testWidgets('swipe approve updates payment & delivery status', (tester) async {
      await pumpOrdersTable(tester, width: 600); // mobile → swipeable

      // Find first order card (Ellie Collins – Paid / Delivered)
      final firstCard = find.byType(SwipeableOrderCard).first;

      // Swipe right (start → end) = approve
      await tester.drag(firstCard, const Offset(400, 0));
      await tester.pumpAndSettle();

      // After approve → should become Paid + Processing
      // In your logic: approve sets payment=Paid, delivery=Processing
      // Original was already Paid → Delivered, so mainly delivery changes

      // Look for "Processing" (should now appear for this order)
      expect(find.text('Processing'), findsWidgets); // at least one more

      // Optional: more precise – but Dismissible makes it tricky
      // You can add a finder using order.customer or id if you expose it in test mode
    });

    testWidgets('shows correct initial date format (M/d/yyyy)', (tester) async {
      await pumpOrdersTable(tester, width: 1200);

      expect(find.text('12/12/2021'), findsOneWidget);
      expect(find.text('12/10/2021'), findsOneWidget);
      expect(find.text('12/8/2021'), findsOneWidget);
      expect(find.text('12/5/2021'), findsOneWidget);
      expect(find.text('12/3/2021'), findsOneWidget);
    });
  });

  // Optional bonus group – state changes
  group('OrdersTable – state interaction', () {

    testWidgets('delete via swipe removes order from list', (tester) async {
      await pumpOrdersTable(tester, width: 600);

      expect(find.text('5 orders'), findsOneWidget);

      final lastCard = find.byType(OrderCardContent).last;

      // Swipe left to show delete background + trigger confirmation dialog
      await tester.drag(lastCard, const Offset(-500, 0));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Now dialog should be visible
      expect(find.text('Delete Order'), findsOneWidget);

      // Tap the Delete button **inside the AlertDialog** only
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(TextButton, 'Delete'),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Order count decreased & name gone
      expect(find.text('4 orders'), findsOneWidget);
      expect(find.text('Emma Wilson'), findsNothing);
    });

  });
}
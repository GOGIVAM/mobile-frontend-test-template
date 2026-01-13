import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order.dart';
import '../providers/order_provider.dart';

class SwipeableRow extends ConsumerWidget {
  final Widget child;
  final OrderModel order;

  const SwipeableRow({
    super.key,
    required this.child,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key('desktop-${order.id}'),
      direction: DismissDirection.horizontal,
      background: Container(
        color: const Color(0xFF48BB78),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'Approve',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: const Color(0xFFF56565),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Approve
          ref.read(orderProvider.notifier).swipeToAction(order.id, OrderAction.approve);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order from ${order.customer} approved'),
              backgroundColor: const Color(0xFF48BB78),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false; // Don't dismiss (we update state instead)
        } else if (direction == DismissDirection.endToStart) {
          // Delete with confirmation
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Order'),
              content: Text('Are you sure you want to delete the order from ${order.customer}?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Delete', style: TextStyle(color: Color(0xFFF56565))),
                ),
              ],
            ),
          );

          if (confirm == true && context.mounted) {
            ref.read(orderProvider.notifier).swipeToAction(order.id, OrderAction.delete);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order from ${order.customer} deleted'),
                backgroundColor: const Color(0xFFF56565),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return confirm ?? false;
        }
        return false;
      },
      child: child,
    );
  }
}
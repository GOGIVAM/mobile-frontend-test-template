import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order.dart';
import '../providers/order_provider.dart';

class OrdersTable extends ConsumerWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768; // Mobile breakpoint

    if (isMobile) {
      return _buildMobileOrdersList(orderState, ref, context);
    }

    return _buildDesktopOrdersTable(orderState, ref, context);
  }

  Widget _buildMobileOrdersList(
      OrderState orderState, WidgetRef ref, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  '${orderState.orders.length} orders',
                  style: const TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderState.orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orderState.orders[index];
                return SwipeableOrderCard(order: order);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopOrdersTable(
      OrderState orderState, WidgetRef ref, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  '${orderState.orders.length} orders',
                  style: const TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Table Headers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Customer',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Product',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'User ID',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Ordered Placed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Payment Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),

          // Table Rows
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderState.orders.length,
            itemBuilder: (context, index) {
              final order = orderState.orders[index];
              return _buildDesktopOrderRow(order, ref, context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopOrderRow(
      OrderModel order, WidgetRef ref, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
      ),
      child: Row(
        children: [
          // Customer
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey),
                  child: Center(
                    child: Text(
                      order.customer.substring(0, 1),
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  order.customer,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),

          // Product
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/product.png',
                  height: 40,
                  width: 80,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    order.product,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5568),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // User ID
          Expanded(
            flex: 2,
            child: Text(
              order.userId,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A5568),
              ),
            ),
          ),

          // Order Date
          Expanded(
            flex: 2,
            child: Text(
              '${order.orderDate.month}/${order.orderDate.day}/${order.orderDate.year}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A5568),
              ),
            ),
          ),

          // Amount
          Expanded(
            flex: 2,
            child: Text(
              '\$${order.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ),

          // Payment Status
          Expanded(
            flex: 2,
            child: _buildStatusBadge(order.paymentStatus, order.paymentColor),
          ),
          const SizedBox(width: 2,),
          // Delivery Status
          Expanded(
            flex: 2,
            child: _buildStatusBadge(order.deliveryStatus, order.deliveryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.toLowerCase() == 'paid'
            ? Colors.transparent
            : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status.toLowerCase() == 'paid') ...[
            Icon(Icons.check_circle_outline, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeableOrderCard extends ConsumerWidget {
  final OrderModel order;

  const SwipeableOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(order.id),
      background: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF48BB78),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text(
              'Approve',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF56565),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          ref
              .read(orderProvider.notifier)
              .swipeToAction(order.id, OrderAction.approve);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order from ${order.customer} approved'),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF48BB78),
            ),
          );
          return false;
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Delete Order'),
              content: Text(
                'Are you sure you want to delete the order from ${order.customer}?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Color(0xFFF56565)),
                  ),
                ),
              ],
            ),
          );
          if (confirm == true) {
            ref
                .read(orderProvider.notifier)
                .swipeToAction(order.id, OrderAction.delete);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order from ${order.customer} deleted'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFFF56565),
              ),
            );
          }
          return confirm ?? false;
        }
        return false;
      },
      child: OrderCardContent(order: order),
    );
  }
}

class OrderCardContent extends StatelessWidget {
  final OrderModel order;

  const OrderCardContent({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Customer Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.grey),
            child: Center(
              child: Text(
                order.customer.substring(0, 1),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.customer,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.product,
                  style: const TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      order.userId,
                      style: const TextStyle(
                        color: Color(0xFFA0AEC0),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${order.orderDate.month}/${order.orderDate.day}/${order.orderDate.year}',
                      style: const TextStyle(
                        color: Color(0xFFA0AEC0),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${order.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 8),
              _buildCompactStatusBadge(
                  order.paymentStatus, order.paymentColor, true),
              const SizedBox(height: 4),
              _buildCompactStatusBadge(
                  order.deliveryStatus, order.deliveryColor, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatusBadge(String status, Color color, bool showTick) {
    return Row(
      children: [
        if (showTick)
          Icon(
            Icons.verified_outlined,
            color: color,
          ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration:
              BoxDecoration(color: showTick ? Colors.transparent : color),
          child: Text(
            status,
            style: TextStyle(
              color: showTick ? color : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

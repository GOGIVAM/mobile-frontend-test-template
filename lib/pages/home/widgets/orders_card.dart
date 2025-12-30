import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../models/order.dart';

class OrdersCard extends StatelessWidget {
  const OrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = [
      Order(
        customerName: 'Ellie Collins',
        customerImage: 'https://i.pravatar.cc/150?u=ellie',
        productName: 'Ginger Snacks',
        productImage: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?q=80&w=150',
        userId: 'Arise827',
        date: '12/12/2021',
        amount: '\$18.00',
        paymentStatus: 'Paid',
        deliveryStatus: 'Delivered',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: 40,
              headingTextStyle: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              columns: const [
                DataColumn(label: Text('Customer')),
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('User ID')),
                DataColumn(label: Text('Ordered Placed')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Payment Status')),
                DataColumn(label: Text('')), // For status button
              ],
              rows: orders.map((order) {
                return DataRow(cells: [
                  DataCell(_buildCustomerCell(order)),
                  DataCell(_buildProductCell(order)),
                  DataCell(Text(order.userId, style: const TextStyle(color: AppColors.textPrimary))),
                  DataCell(Text(order.date, style: const TextStyle(color: AppColors.textPrimary))),
                  DataCell(Text(order.amount, style: const TextStyle(color: AppColors.textPrimary))),
                  DataCell(_buildPaymentStatusCell(order)),
                  DataCell(_buildDeliveryStatusCell(order)),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCell(Order order) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(order.customerImage, width: 32, height: 32, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Text(order.customerName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildProductCell(Order order) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(order.productImage, width: 40, height: 32, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Text(order.productName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildPaymentStatusCell(Order order) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, color: Color(0xFF28C76F), size: 18),
        const SizedBox(width: 8),
        Text(order.paymentStatus, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildDeliveryStatusCell(Order order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF28C76F),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        order.deliveryStatus,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

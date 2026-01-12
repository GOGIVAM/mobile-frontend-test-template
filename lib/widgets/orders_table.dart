// lib/widgets/orders_table.dart
import 'package:flutter/material.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                children: [
                  _buildHeaderCell('Customer'),
                  _buildHeaderCell('Product'),
                  _buildHeaderCell('User ID'),
                  _buildHeaderCell('Ordered Placed'),
                  _buildHeaderCell('Amount'),
                  _buildHeaderCell('Payment Status'),
                ],
              ),
              _buildOrderRow(
                'Ellie Collins',
                'Ginger Snacks',
                'Arise827',
                '12/12/2021',
                '\$18.00',
                'Paid',
                'Delivered',
              ),
              _buildOrderRow(
                'John Doe',
                'Apple Juice',
                'User123',
                '12/10/2021',
                '\$25.00',
                'Paid',
                'Shipped',
              ),
              _buildOrderRow(
                'Jane Smith',
                'Organic Tea',
                'Jane456',
                '12/08/2021',
                '\$15.50',
                'Pending',
                'Processing',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  TableRow _buildOrderRow(
      String customer,
      String product,
      String userId,
      String date,
      String amount,
      String paymentStatus,
      String deliveryStatus,
      ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 20, color: Colors.grey[600]),
              ),
              const SizedBox(width: 10),
              Text(
                customer,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.fastfood, color: Colors.green[700], size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                product,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            userId,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            date,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            amount,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: paymentStatus == 'Paid'
                      ? Colors.green[100]
                      : Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      paymentStatus == 'Paid' ? Icons.check_circle : Icons.pending,
                      size: 14,
                      color: paymentStatus == 'Paid'
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      paymentStatus,
                      style: TextStyle(
                        fontSize: 12,
                        color: paymentStatus == 'Paid'
                            ? Colors.green[700]
                            : Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  deliveryStatus,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
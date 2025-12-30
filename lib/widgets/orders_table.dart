import 'package:flutter/material.dart';
import '../models/order.dart';
import '../utils/mock_data.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = MockData.getOrders();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                      columnSpacing: 24,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Customer',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Product',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'User ID',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Ordered Placed',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Payment Status',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      rows: orders.map((order) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey[200],
                                    child: Text(
                                      order.customerImage,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(order.customerName),
                                ],
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    order.productImage,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(order.product),
                                ],
                              ),
                            ),
                            DataCell(Text(order.userId)),
                            DataCell(Text(order.orderedDate)),
                            DataCell(Text('\$${order.amount.toStringAsFixed(2)}')),
                            DataCell(_buildPaymentStatus(order.paymentStatus)),
                            DataCell(_buildDeliveryStatus(order.deliveryStatus)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentStatus(PaymentStatus status) {
    Color color;
    String text;

    switch (status) {
      case PaymentStatus.paid:
        color = const Color(0xFF6FCF97);
        text = 'Paid';
        break;
      case PaymentStatus.pending:
        color = const Color(0xFFFFA726);
        text = 'Pending';
        break;
      case PaymentStatus.failed:
        color = const Color(0xFFEF5350);
        text = 'Failed';
        break;
    }

    return Row(
      children: [
        Icon(
          status == PaymentStatus.paid ? Icons.check_circle : Icons.schedule,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryStatus(DeliveryStatus status) {
    Color color;
    String text;

    switch (status) {
      case DeliveryStatus.delivered:
        color = const Color(0xFF6FCF97);
        text = 'Delivered';
        break;
      case DeliveryStatus.pending:
        color = const Color(0xFFFFA726);
        text = 'Pending';
        break;
      case DeliveryStatus.cancelled:
        color = const Color(0xFFEF5350);
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


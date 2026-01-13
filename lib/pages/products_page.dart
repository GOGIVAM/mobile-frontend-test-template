// lib/pages/products_page.dart
import 'package:flutter/material.dart';

import '../utils/app_breakpoints.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = AppBreakpoints.isDesktop(width);
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B6FED),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop?4:2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildProductCard(
                  'Ginger Snacks',
                  '\$18.00',
                  '152 in stock',
                  Icons.cookie,
                  Colors.orange,
                ),
                _buildProductCard(
                  'Apple Juice',
                  '\$25.00',
                  '89 in stock',
                  Icons.local_drink,
                  Colors.red,
                ),
                _buildProductCard(
                  'Organic Tea',
                  '\$15.50',
                  '234 in stock',
                  Icons.emoji_food_beverage,
                  Colors.green,
                ),
                _buildProductCard(
                  'Protein Bars',
                  '\$32.00',
                  '67 in stock',
                  Icons.fastfood,
                  Colors.brown,
                ),
                _buildProductCard(
                  'Energy Drink',
                  '\$8.99',
                  '412 in stock',
                  Icons.local_cafe,
                  Colors.blue,
                ),
                _buildProductCard(
                  'Vitamin C',
                  '\$22.50',
                  '198 in stock',
                  Icons.medication,
                  Colors.yellow,
                ),
                _buildProductCard(
                  'Almonds Pack',
                  '\$28.00',
                  '156 in stock',
                  Icons.eco,
                  Colors.teal,
                ),
                _buildProductCard(
                  'Greek Yogurt',
                  '\$12.99',
                  '321 in stock',
                  Icons.soup_kitchen,
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha:0.1),
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
                    'Product Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildCategoryChip('Snacks', 45, Colors.orange),
                      _buildCategoryChip('Beverages', 32, Colors.blue),
                      _buildCategoryChip('Health', 28, Colors.green),
                      _buildCategoryChip('Supplements', 19, Colors.purple),
                      _buildCategoryChip('Organic', 56, Colors.teal),
                      _buildCategoryChip('Dairy', 23, Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String stock, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5B6FED),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              stock,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                color: Colors.grey[600],
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18),
                color: Colors.red[400],
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha:0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
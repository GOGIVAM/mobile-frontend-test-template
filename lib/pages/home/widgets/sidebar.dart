import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: Color(0xFFE0E5F2), width: 1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buildLogo(),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(Icons.grid_view, 'Dashboards', isSelected: true, hasArrow: true),
                _buildSubMenuItem('Analytics', isSelected: true),
                _buildSubMenuItem('Reports'),
                _buildMenuItem(Icons.shopping_bag_outlined, 'Product', hasArrow: true),
                _buildMenuItem(Icons.widgets_outlined, 'Widgets', hasArrow: true),
                _buildMenuItem(Icons.auto_awesome_mosaic_outlined, 'UI Elements', hasArrow: true),
                _buildMenuItem(Icons.description_outlined, 'Pages', hasArrow: true),
                _buildMenuItem(Icons.calendar_today_outlined, 'Calendar', hasArrow: true),
                _buildMenuItem(Icons.edit_note_outlined, 'Forms', hasArrow: true),
                _buildMenuItem(Icons.table_chart_outlined, 'Tables', hasArrow: true),
                _buildMenuItem(Icons.map_outlined, 'Graphs & Maps', hasArrow: true),
                _buildMenuItem(Icons.layers_outlined, 'Layouts', hasArrow: true),
                _buildMenuItem(Icons.lock_outline, 'Authentication', hasArrow: true),
                _buildMenuItem(Icons.link, 'Link'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4318FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.grid_3x3, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        const Text(
          'HORIZON',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isSelected = false, bool hasArrow = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF4318FF) : AppColors.textSecondary,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: hasArrow
            ? Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              )
            : null,
      ),
    );
  }

  Widget _buildSubMenuItem(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 48, bottom: 8, top: 4),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF4318FF) : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontSize: 13,
        ),
      ),
    );
  }
}

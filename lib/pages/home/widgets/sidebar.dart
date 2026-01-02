import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_tile.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
              children: [
                const CustomTile(icon: Icons.grid_view, title: 'Dashboards', isSelected: true, hasArrow: true),
                _buildSubMenuItem('Analytics', isSelected: true),
                _buildSubMenuItem('Reports'),
                const CustomTile(icon: Icons.shopping_bag_outlined, title: 'Product', hasArrow: true),
                const CustomTile(icon: Icons.widgets_outlined, title: 'Widgets', hasArrow: true),
                const CustomTile(icon: Icons.auto_awesome_mosaic_outlined, title: 'UI Elements', hasArrow: true),
                const CustomTile(icon: Icons.description_outlined, title: 'Pages', hasArrow: true),
                const CustomTile(icon: Icons.calendar_today_outlined, title: 'Calendar', hasArrow: true),
                const CustomTile(icon: Icons.edit_note_outlined, title: 'Forms', hasArrow: true),
                const CustomTile(icon: Icons.table_chart_outlined, title: 'Tables', hasArrow: true),
                const CustomTile(icon: Icons.map_outlined, title: 'Graphs & Maps', hasArrow: true),
                const CustomTile(icon: Icons.layers_outlined, title: 'Layouts', hasArrow: true),
                const CustomTile(icon: Icons.lock_outline, title: 'Authentication', hasArrow: true),
                const CustomTile(icon: Icons.link, title: 'Link'),
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

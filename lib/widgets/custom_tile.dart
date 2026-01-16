import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool hasArrow;
  final VoidCallback? onTap;

  const CustomTile({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.hasArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
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
}

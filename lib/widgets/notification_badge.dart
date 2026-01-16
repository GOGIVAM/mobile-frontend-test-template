import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class NotificationBadge extends StatelessWidget {
  final String text;
  final String highlightedText;
  final String? othertext;
  final IconData icon;

  const NotificationBadge({
    super.key,
    required this.text,
    required this.highlightedText,
    this.icon = Icons.notifications_none, this.othertext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              children: [
                TextSpan(text: text),
                TextSpan(
                  text: highlightedText,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: othertext),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: AppColors.warning, size: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Breadcrumbs
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.home_outlined, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  const Text('Home', style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  const Text(
                    'Sales',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Search Bar
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search anything',
                  hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Notifications & Profile
          Row(
            children: [
              _buildNotificationBadge(),
              const SizedBox(width: 24),
              _buildUserProfile(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              children: [
                TextSpan(text: 'You have '),
                TextSpan(
                  text: '21 new leads',
                  style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.notifications_none, color: AppColors.warning, size: 20),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        // Flag icon placeholder
        Container(
          width: 24,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Center(
            child: Text('🇧🇷', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Abigale He...',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.textLight,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=abigale'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_search_input.dart';

class Header extends StatelessWidget {
  final bool showMenu;

  const Header({super.key, this.showMenu = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          if (showMenu)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          // Breadcrumbs (Hidden on small mobile)
          if (MediaQuery.of(context).size.width > 600)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.home_outlined, size: 18, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Text('Home', style: TextStyle(color: AppColors.textSecondary)),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Text(
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
          const Expanded(
            flex: 2,
            child: CustomSearchInput(hintText: 'Search anything'),
          ),
          const SizedBox(width: 16),
          // Notifications & Profile
          Row(
            children: [
              if (MediaQuery.of(context).size.width > 900) _buildNotificationBadge(),
              const SizedBox(width: 16),
              _buildUserProfile(context),
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

  Widget _buildUserProfile(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 500;
    return Row(
      children: [
        if (!isSmall) ...[
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
        ],
        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.textLight,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
      ],
    );
  }
}

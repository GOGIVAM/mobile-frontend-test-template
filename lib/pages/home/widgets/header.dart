import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_search_input.dart';
import '../../../widgets/notification_badge.dart';

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
                    Icon(Icons.home_outlined, size: 30, color: AppColors.primary),
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
          const Spacer(flex: 3),
          // Search Bar
          const Expanded(
            child: CustomSearchInput(hintText: 'Search anything'),
          ),
          const SizedBox(width: 16),
          // Notifications & Profile
          Row(
            children: [
              if (MediaQuery.of(context).size.width > 900)
                const NotificationBadge(
                  text: 'You have ',
                  highlightedText: ' 21',
                  othertext: ' new leads',
                ),
              const SizedBox(width: 16),
              _buildUserProfile(context),
            ],
          ),
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

import 'package:flutter/material.dart';

import '../models/nav_items.dart';
import '../utils/app_breakpoints.dart';

class ResponsiveNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isRailExtended; // for desktop: show labels

  const ResponsiveNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.isRailExtended = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (AppBreakpoints.isMobile(width)) {
      // Mobile: return nothing here → we use BottomNavigationBar + Drawer
      return const SizedBox.shrink();
    }

    // Tablet & Desktop: NavigationRail
    return CustomNavigationRail(
        isRailExtended: isRailExtended && AppBreakpoints.isDesktop(width),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        mainNavItems: mainNavItems);
  }
}

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomNavigationRail(
          isRailExtended: true,
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemTapped,
          mainNavItems: mainNavItems),
    );
  }
}

class CustomNavigationRail extends StatelessWidget {
  final bool isRailExtended;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavItem> mainNavItems;

  const CustomNavigationRail({
    super.key,
    required this.isRailExtended,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.mainNavItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isRailExtended ? 240 : 72,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo section at the top
          Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: isRailExtended
                ? Image.asset(
                    'assets/images/logo.png', // Your logo asset path
                    fit: BoxFit.contain,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B8DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
          ),
          // Navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Dashboards section with expandable submenu
                _buildExpandableSection(
                  title: 'Dashboards',
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  isExpanded: true,
                  subItems: [
                    _buildSubMenuItem('Analytics', 0),
                    _buildSubMenuItem('Reports', null),
                  ],
                ),

                // Other navigation items
                _buildNavItem(
                  title: 'Product',
                  icon: Icons.shopping_bag_outlined,
                  selectedIcon: Icons.shopping_bag,
                  index: 1,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Widgets',
                  icon: Icons.widgets_outlined,
                  selectedIcon: Icons.widgets,
                  index: 2,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'UI Elements',
                  icon: Icons.grid_view_outlined,
                  selectedIcon: Icons.grid_view,
                  index: 3,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Pages',
                  icon: Icons.description_outlined,
                  selectedIcon: Icons.description,
                  index: 4,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Calendar',
                  icon: Icons.calendar_today_outlined,
                  selectedIcon: Icons.calendar_today,
                  index: 5,
                  hasSubmenu: false,
                ),
                _buildNavItem(
                  title: 'Forms',
                  icon: Icons.view_list_outlined,
                  selectedIcon: Icons.view_list,
                  index: 6,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Tables',
                  icon: Icons.table_chart_outlined,
                  selectedIcon: Icons.table_chart,
                  index: 7,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Graphs & Maps',
                  icon: Icons.show_chart_outlined,
                  selectedIcon: Icons.show_chart,
                  index: 8,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Layouts',
                  icon: Icons.view_quilt_outlined,
                  selectedIcon: Icons.view_quilt,
                  index: 9,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Authentication',
                  icon: Icons.lock_outlined,
                  selectedIcon: Icons.lock,
                  index: 10,
                  hasSubmenu: true,
                ),
                _buildNavItem(
                  title: 'Link',
                  icon: Icons.link_outlined,
                  selectedIcon: Icons.link,
                  index: 11,
                  hasSubmenu: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required IconData selectedIcon,
    required bool isExpanded,
    required List<Widget> subItems,
  }) {
    if (!isRailExtended) {
      return _buildNavItem(
        title: title,
        icon: icon,
        selectedIcon: selectedIcon,
        index: 0,
        hasSubmenu: false,
      );
    }

    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          leading: Icon(
            icon,
            color: Colors.grey[700],
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
        if (isExpanded) ...subItems,
      ],
    );
  }

  Widget _buildSubMenuItem(String title, int? index) {
    final isSelected = index != null && selectedIndex == index;

    return InkWell(
      onTap: index != null ? () => onDestinationSelected(index) : null,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6B8DE3).withValues(alpha:0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? const Color(0xFF6B8DE3) : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String title,
    required IconData icon,
    required IconData selectedIcon,
    required int index,
    required bool hasSubmenu,
  }) {
    final isSelected = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: () => onDestinationSelected(index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isRailExtended ? 16 : 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6B8DE3).withValues(alpha:0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected ? const Color(0xFF6B8DE3) : Colors.grey[700],
                size: 22,
              ),
              if (isRailExtended) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF6B8DE3)
                          : Colors.grey[800],
                    ),
                  ),
                ),
                if (hasSubmenu)
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                    size: 20,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

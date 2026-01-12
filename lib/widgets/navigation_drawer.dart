import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

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
    return NavigationRail(
      extended: isRailExtended && AppBreakpoints.isDesktop(width),
      backgroundColor: Colors.white,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: isRailExtended ? NavigationRailLabelType.all : NavigationRailLabelType.selected,
      indicatorColor: AppColors.primary.withOpacity(0.2),
      destinations: mainNavItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.icon, color: AppColors.primary),
          label: Text(item.label),
        );
      }).toList(),
    );
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...List.generate(mainNavItems.length, (index) {
            final item = mainNavItems[index];
            return ListTile(
              leading: Icon(
                item.icon,
                color: selectedIndex == index ? AppColors.primary : null,
              ),
              title: Text(
                item.label,
                style: TextStyle(
                  color: selectedIndex == index ? AppColors.primary : null,
                  fontWeight: selectedIndex == index ? FontWeight.bold : null,
                ),
              ),
              selected: selectedIndex == index,
              onTap: () {
                onItemTapped(index);
                Navigator.pop(context); // close drawer
              },
            );
          }),
        ],
      ),
    );
  }
}


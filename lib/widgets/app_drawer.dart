import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../models/menu_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B67F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gogivam Dashboard',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
            Obx(() {
              return Column(
                children: [
                  // Premier groupe : Dashboards
                  ...controller.menuItems.take(1).map((item) {
                    return _buildMenuItem(context, controller, item, 0);
                  }),
                  // Séparateur
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Divider(color: Colors.grey),
                  ),
                  // Reste des items
                  ...controller.menuItems.skip(1).map((item) {
                    return _buildMenuItem(context, controller, item, 0);
                  }),
                ],
              );
            }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    NavigationController controller,
    MenuItem item,
    int level,
  ) {
    final bool isActive = controller.isActive(item.id);
    final bool isActiveOrChild = controller.isActiveOrChildActive(item.id);
    final bool isExpanded = controller.isExpanded(item.id);
    final bool hasSubItems = item.hasSubItems;
    final bool isSubItem = level > 0;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: isSubItem ? 40.0 : 0.0,
            right: 8.0,
            top: 2.0,
            bottom: 2.0,
          ),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF5B67F1).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(
              item.icon,
              color: isActive
                  ? const Color(0xFF5B67F1)
                  : (isActiveOrChild ? const Color(0xFF5B67F1) : Colors.black87),
              size: 24,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF5B67F1)
                    : (isActiveOrChild ? const Color(0xFF5B67F1) : Colors.black87),
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            trailing: hasSubItems
                ? Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    color: Colors.black54,
                    size: 20,
                  )
                : null,
            contentPadding: EdgeInsets.only(
              left: isSubItem ? 12.0 : 20.0,
              right: 20,
              top: 4,
              bottom: 4,
            ),
          onTap: () {
            if (hasSubItems) {
              // Toggle expansion
              controller.toggleExpanded(item.id);
            } else if (item.hasRoute) {
              // Naviguer vers la route
              controller.navigateToMenuItem(item.id);
              // Fermer le drawer
              Navigator.of(context).pop();
            }
          },
          ),
        ),
        // Afficher les sous-items si expansé
        if (hasSubItems && isExpanded)
          ...item.subItems!.map((subItem) {
            return _buildMenuItem(context, controller, subItem, level + 1);
          }),
      ],
    );
  }
}

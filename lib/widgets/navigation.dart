import 'package:flutter/material.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF7FAFC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF5B6FED),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.dashboard,
                      color: Color(0xFF5B6FED),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerSection('Dashboards', [
              _DrawerItem(Icons.home, 'Home', true),
              _DrawerItem(Icons.analytics, 'Analytics', false),
              _DrawerItem(Icons.assessment, 'Reports', false),
            ]),
            const Divider(),
            _buildDrawerSection('Components', [
              _DrawerItem(Icons.shopping_cart, 'Product', false),
              _DrawerItem(Icons.widgets, 'Widgets', false),
              _DrawerItem(Icons.view_module, 'UI Elements', false),
              _DrawerItem(Icons.web, 'Pages', false),
            ]),
            const Divider(),
            _buildDrawerSection('Tools', [
              _DrawerItem(Icons.calendar_today, 'Calendar', false),
              _DrawerItem(Icons.format_align_left, 'Forms', false),
              _DrawerItem(Icons.table_chart, 'Tables', false),
              _DrawerItem(Icons.show_chart, 'Graphs & Maps', false),
            ]),
            const Divider(),
            _buildDrawerSection('Other', [
              _DrawerItem(Icons.layers, 'Layouts', false),
              _DrawerItem(Icons.lock, 'Authentication', false),
              _DrawerItem(Icons.link, 'Link', false),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<_DrawerItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items.map((item) => _buildDrawerItem(item)).toList(),
      ],
    );
  }

  Widget _buildDrawerItem(_DrawerItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: item.isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: item.isSelected
            ? [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ]
            : null,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          item.icon,
          color: item.isSelected ? const Color(0xFF5B6FED) : Colors.grey[600],
          size: 22,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 14,
            color: item.isSelected ? const Color(0xFF2D3748) : Colors.grey[700],
            fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final String title;
  final bool isSelected;

  _DrawerItem(this.icon, this.title, this.isSelected);
}
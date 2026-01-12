import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  final String route; // or use index if using indexed stack

  const NavItem(this.icon, this.label, this.route);
}

final List<NavItem> mainNavItems = [
  const NavItem(Icons.dashboard, 'Dashboards', '/dashboards'),
  const NavItem(Icons.analytics, 'Analytics', '/analytics'),
  const NavItem(Icons.bar_chart, 'Reports', '/reports'),
  const NavItem(Icons.inventory_2, 'Product', '/product'),
  const NavItem(Icons.widgets, 'Widgets', '/widgets'),
  const NavItem(Icons.code, 'UI Elements', '/ui-elements'),
  const NavItem(Icons.pages, 'Pages', '/pages'),
  const NavItem(Icons.calendar_today, 'Calendar', '/calendar'),
  const NavItem(Icons.description, 'Forms', '/forms'),
  const NavItem(Icons.table_chart, 'Tables', '/tables'),
  const NavItem(Icons.show_chart, 'Graphs & Maps', '/graphs-maps'),
  const NavItem(Icons.dashboard_customize, 'Layouts', '/layouts'),
  const NavItem(Icons.security, 'Authentication', '/authentication'),
  const NavItem(Icons.link, 'Link', '/link'),
];
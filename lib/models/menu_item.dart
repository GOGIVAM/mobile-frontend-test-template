import 'package:flutter/material.dart';

class MenuItem {
  final String id;
  final String title;
  final IconData icon;
  final String? route; // Route nommée
  final Widget? page; // Widget de la page (fallback)
  final List<MenuItem>? subItems;
  final bool isExpandable;

  MenuItem({
    required this.id,
    required this.title,
    required this.icon,
    this.route,
    this.page,
    this.subItems,
    this.isExpandable = false,
  });

  bool get hasSubItems => subItems != null && subItems!.isNotEmpty;
  bool get hasRoute => route != null && route!.isNotEmpty;
  bool get hasPage => page != null;
}


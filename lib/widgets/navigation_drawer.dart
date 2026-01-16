import 'package:flutter/material.dart';
import '../pages/home/widgets/sidebar.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Sidebar(),
    );
  }
}

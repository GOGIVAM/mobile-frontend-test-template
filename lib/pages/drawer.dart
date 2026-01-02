import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_gogivam/controllers/drawer_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyDrawerController());
    
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(),
    );
  }
}
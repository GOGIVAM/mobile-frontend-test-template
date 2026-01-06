import 'package:flutter/material.dart';
import 'app_drawer.dart' as drawer;

class MainLayout extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final List<Widget>? actions;

  const MainLayout({
    Key? key,
    required this.child,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: title,
        actions: actions,
      ),
          drawer: const drawer.NavigationDrawer(),
      body: child,
    );
  }
}


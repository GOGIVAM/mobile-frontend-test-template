import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A6CF7)),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

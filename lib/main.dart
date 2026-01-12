import 'package:flutter/material.dart';
import 'package:module_1/pages/dashboard_screen.dart';
import 'package:module_1/utils/app_colors.dart';


void main() {
  ErrorWidget.builder = customErrorBuilder;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}


Widget customErrorBuilder(FlutterErrorDetails details) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: const Center(
      child:Text('Screen Not available'),
    ),
  );
}
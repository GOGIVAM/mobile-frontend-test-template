import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home/home_page.dart';

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
        fontFamily: 'GoogleFonts.poppins', // Note: actual font application requires google_fonts package usage in theme
      ),
      home: const HomePage(),
    );
  }
}

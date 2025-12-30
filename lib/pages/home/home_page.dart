import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              // Other dashboard sections will be added here
            ],
          ),
        ),
      ),
    );
  }
}

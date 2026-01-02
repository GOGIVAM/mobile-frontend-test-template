import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomSearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const CustomSearchInput({
    super.key,
    this.hintText = 'Search...',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 12),
          suffixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric( horizontal: 15),
        ),
      ),
    );
  }
}

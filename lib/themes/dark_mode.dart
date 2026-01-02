import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 20, 20, 20),
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade900,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
    onTertiary: Colors.grey.shade900 
  ),
);
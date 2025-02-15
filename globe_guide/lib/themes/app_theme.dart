import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // Primary colors from designs
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.light,
    ),
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    // Search bar theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF4F4F4),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Axiforma',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 16,
        // color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 14,
        // color: Colors.grey,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0B0B0B),
    // Primary colors from designs
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.dark,
    ),
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    // Search bar theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1C1C1E),
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontFamily: 'Axiforma',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 16,
        // color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Axiforma',
        fontSize: 14,
        // color: Colors.grey,
      ),
    ),
  );
}

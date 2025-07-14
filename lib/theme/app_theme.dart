import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        secondary: Colors.purpleAccent,
        surface: Colors.white,
        background: Colors.deepPurple.shade50,
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.deepPurple,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.deepPurple.shade50,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
        bodyMedium: TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  }
}
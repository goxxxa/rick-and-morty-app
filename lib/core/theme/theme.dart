import 'package:flutter/material.dart';

class RickAndMortyAppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 247, 249, 250),
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFF6F9FC),
      cardColor: Colors.white,
      iconTheme: IconThemeData(color: colorScheme.primary),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF13B9FF),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 87, 88, 88),
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      iconTheme: IconThemeData(color: colorScheme.secondary),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF13B9FF),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

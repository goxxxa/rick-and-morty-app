import 'package:flutter/material.dart';

class RickAndMortyAppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F6F7),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF5F6F7),
        foregroundColor: Color(0xFF272B33),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Color(0xFF272B33),
          fontFamily:
              '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif',
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color(0xFF272B33),
          fontSize: 14,
          height: 1.625,
          fontFamily:
              '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif',
          fontFeatures: [
            FontFeature.enable('kern'),
            FontFeature.enable('liga'),
          ],
        ),
        titleLarge: TextStyle(
          color: Color(0xFF202329),
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF272B33)),
      cardColor: Colors.white,
      dividerColor: const Color(0xFFDDDDDD),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF3C3E44),
        secondary: Color(0xFFE4A788),
        surface: Colors.white,
        onSurface: Color(0xFF272B33),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF272B33),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 255, 152, 0),
        foregroundColor: Colors.white70,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Color.fromRGBO(255, 255, 255, 0.85),
          fontFamily:
              '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif',
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.85),
          fontSize: 14,
          height: 1.625,
          fontFamily:
              '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif',
          fontFeatures: [
            FontFeature.enable('kern'),
            FontFeature.enable('liga'),
          ],
        ),
        titleLarge: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(255, 255, 255, 0.85),
      ),
      cardColor: const Color(0xFF202329),
      dividerColor: Color.fromRGBO(255, 255, 255, 0.15),
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 255, 152, 0),
        secondary: Color(0xFF3C3E44),
        surface: Color(0xFF202329),
        onSurface: Color.fromRGBO(255, 255, 255, 0.85),
      ),
    );
  }
}

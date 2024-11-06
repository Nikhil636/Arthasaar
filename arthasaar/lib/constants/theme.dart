import 'package:flutter/material.dart';

class AppTheme {
  // Light theme colors
  static const Color primaryColorLight = Color(0xFF047ba3);
  static const Color secondaryColorLight = Color(0xFFe5f4f6);

  // Dark theme colors
  static const Color primaryColorDark = Colors.black;
  static const Color secondaryColorDark = Color(0xFF2596be);

  // Light theme text styles
  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displaySmall: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87, // General body text color for light mode
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    titleMedium: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: primaryColorLight,
    ),
    titleSmall: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: secondaryColorLight,
    ),
    labelLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Button text
    ),
    bodySmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[700],
    ),
  );

  // Dark theme text styles
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: secondaryColorDark, // Use the secondary color in dark mode
    ),
    displayMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: secondaryColorDark,
    ),
    displaySmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: secondaryColorDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.white70, // Lighter text for contrast in dark mode
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    titleMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: secondaryColorDark,
    ),
    titleSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white60,
    ),
    labelLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Button text in dark mode
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.white60,
    ),
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      color: Colors.white54,
    ),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColorLight,
    scaffoldBackgroundColor: secondaryColorLight,
    textTheme: lightTextTheme,
    brightness: Brightness.light,
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: primaryColorDark,
    textTheme: darkTextTheme,
    brightness: Brightness.dark,
  );
}

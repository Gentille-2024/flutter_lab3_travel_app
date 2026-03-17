import 'package:flutter/material.dart';

// ============================================================
// App-wide color theme and text styles
// Ensures consistent styling across all screens
// ============================================================

class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color accentColor = Color(0xFFFF6F00);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF212121);
  static const Color textMedium = Color(0xFF616161);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color starColor = Color(0xFFFFB300);
  static const Color successColor = Color(0xFF2E7D32);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF6DD5FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black54],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Box shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // Border radius
  static BorderRadius cardRadius = BorderRadius.circular(16);
  static BorderRadius buttonRadius = BorderRadius.circular(12);
  static BorderRadius chipRadius = BorderRadius.circular(20);

  // Text styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: textDark,
    letterSpacing: -0.5,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 15,
    color: textMedium,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: textLight,
  );

  // Full ThemeData for MaterialApp
  static ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: textDark,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: cardRadius),
        ),
        useMaterial3: true,
      );
}
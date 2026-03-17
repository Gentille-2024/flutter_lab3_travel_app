import 'package:flutter/material.dart';
import 'data/app_theme.dart';
import 'screens/home_screen.dart';

// ============================================================
// Entry point for the Travel App
// Applies the consistent AppTheme and launches HomeScreen
// ============================================================

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const HomeScreen(),
    );
  }
}
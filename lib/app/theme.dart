import 'package:flutter/material.dart';

class FitFlowColors {
  static const primary = Color(0xFFFF6600);

  static const background = Color(0xFF121212);

  static const surface = Color(0xFF1E1F26);

  static const secondaryText = Color(0xFF8C8D94);

  static const text = Color(0xFFF8F9FA);
}

ThemeData buildFitFlowTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: FitFlowColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: FitFlowColors.primary,
      brightness: Brightness.dark,
    ).copyWith(primary: FitFlowColors.primary, surface: FitFlowColors.surface),

    appBarTheme: const AppBarTheme(
      backgroundColor: FitFlowColors.background,
      foregroundColor: FitFlowColors.text,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: FitFlowColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: FitFlowColors.surface,
      indicatorColor: FitFlowColors.primary.withValues(alpha: 0.20),
    ),
  );
}

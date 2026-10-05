import 'package:flutter/material.dart';

class FitFlowColors {
  static const darkPrimary = Color(0xFFFF6600);
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1F26);
  static const darkTertiary = Color(0xFF8C8D94);
  static const darkText = Color(0xFFF8F9FA);

  static const lightPrimary = Color(0xFF6D28D9);
  static const lightSecondary = Color(0xFF8B5CF6);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF6F3FB);
  static const lightTertiary = Color(0xFF64748B);
  static const lightText = Color(0xFF18181B);

  static FitFlowPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const FitFlowPalette(
              primary: lightPrimary,
              secondary: lightSecondary,
              background: lightBackground,
              surface: lightSurface,
              tertiary: lightTertiary,
              text: lightText,
            )
          : const FitFlowPalette(
              primary: darkPrimary,
              secondary: Color(0xFFFF8A3D),
              background: darkBackground,
              surface: darkSurface,
              tertiary: darkTertiary,
              text: darkText,
            );
}

class FitFlowPalette {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color tertiary;
  final Color text;

  const FitFlowPalette({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.tertiary,
    required this.text,
  });
}

const fitFlowFontFamily = 'Roboto';

ThemeData buildFitFlowTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final primary = isLight ? FitFlowColors.lightPrimary : FitFlowColors.darkPrimary;
  final secondary = isLight ? FitFlowColors.lightSecondary : const Color(0xFFFF8A3D);
  final background = isLight ? FitFlowColors.lightBackground : FitFlowColors.darkBackground;
  final surface = isLight ? FitFlowColors.lightSurface : FitFlowColors.darkSurface;
  final tertiary = isLight ? FitFlowColors.lightTertiary : FitFlowColors.darkTertiary;
  final text = isLight ? FitFlowColors.lightText : FitFlowColors.darkText;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: fitFlowFontFamily,
    scaffoldBackgroundColor: background,
    textTheme: TextTheme(
      displaySmall: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: text),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: text),
      titleLarge: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: text),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: text),
      bodyMedium: TextStyle(fontSize: 14, color: tertiary),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    ).copyWith(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: surface,
      onSurface: text,
      onSurfaceVariant: tertiary,
      onPrimary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: text,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primary, width: 1.5),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primary.withValues(alpha: 0.20),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primary;
        return tertiary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primary.withValues(alpha: 0.28);
        return tertiary.withValues(alpha: 0.20);
      }),
    ),
  );
}

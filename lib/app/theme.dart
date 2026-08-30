import 'package:flutter/material.dart';

class FitFlowColors {
  static const primary = Color(0xFFFF6600);

  static const background = Color(0xFF121212);

  static const surface = Color(0xFF1E1F26);

  static const secondaryText = Color(0xFF8C8D94);

  static const text = Color(0xFFF8F9FA);
}

/// Fonte primária da marca.
///
/// Roboto é a fonte nativa do Material Design e já acompanha o Flutter, então
/// a identidade tipográfica não depende de download em tempo de execução nem
/// de pacote externo.
const fitFlowFontFamily = 'Roboto';

/// Estilos de texto que não têm equivalente semântico no [TextTheme] do
/// Material e por isso ficam expostos à parte.
class FitFlowTextStyles {
  /// Rótulo de seção em caixa alta ("SEU TREINO DE HOJE", "RESUMO").
  static const sectionLabel = TextStyle(
    color: FitFlowColors.secondaryText,
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}

/// Escala tipográfica do FitFlow.
///
/// Os pesos altos (w900) são propositais: durante o treino o usuário lê a tela
/// de relance, com o celular na mão entre uma série e outra.
const fitFlowTextTheme = TextTheme(
  // Título de tela: "Bora treinar?", "Treinos", "Minha evolução", "Perfil".
  displaySmall: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: FitFlowColors.text,
  ),

  // Números de destaque: carga, tempo acumulado, percentual de evolução.
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: FitFlowColors.text,
  ),

  // Nome do treino dentro dos cards.
  titleLarge: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    color: FitFlowColors.text,
  ),

  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: FitFlowColors.text,
  ),

  bodyMedium: TextStyle(fontSize: 14, color: FitFlowColors.secondaryText),
);

ThemeData buildFitFlowTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: fitFlowFontFamily,
    textTheme: fitFlowTextTheme,

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

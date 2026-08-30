// Testes de widget do FitFlow.
//
// Cobrem a inicialização do app e a navegação principal entre as abas.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitflow/app/app.dart';

/// Localiza um texto dentro da barra de navegação inferior.
///
/// O [IndexedStack] mantém as quatro telas na árvore de widgets, então buscar
/// pelo texto solto encontraria também os títulos das telas em segundo plano.
Finder navLabel(String label) =>
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

void main() {
  testWidgets('abre na Home com a navegação principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FitFlowApp());

    // Marca e chamada da tela inicial.
    expect(find.text('FITFLOW'), findsOneWidget);
    expect(find.text('Bora treinar?'), findsOneWidget);

    // As quatro abas do app.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(navLabel('Início'), findsOneWidget);
    expect(navLabel('Treinos'), findsOneWidget);
    expect(navLabel('Evolução'), findsOneWidget);
    expect(navLabel('Perfil'), findsOneWidget);
  });

  testWidgets('navega da Home para a aba Treinos', (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    // Ícone da aba Treinos no estado não selecionado.
    await tester.tap(find.byIcon(Icons.fitness_center_outlined));
    await tester.pumpAndSettle();

    expect(find.text('CRIAR MEU TREINO'), findsOneWidget);
    expect(find.text('TREINOS PRONTOS'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';

import '../../app/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o FitFlow')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FITFLOW', style: TextStyle(color: colors.primary, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 3)),
                  const SizedBox(height: 14),
                  Text(
                    'O FitFlow é um aplicativo Flutter de gerenciamento, acompanhamento e evolução de treinos. Ele reúne a escolha de treinos, execução com cronômetro, criação de treinos personalizados e acompanhamento do progresso em uma experiência única.',
                    style: TextStyle(fontSize: 16, height: 1.5, color: colors.text),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'O projeto foi estruturado como um protótipo funcional, com dados simulados e navegação entre as principais áreas do aplicativo.',
                    style: TextStyle(color: colors.tertiary, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.check_circle_outline), title: Text('Treinos prontos e personalizados')),
                ListTile(leading: Icon(Icons.timer_outlined), title: Text('Execução com cronômetro e conclusão')),
                ListTile(leading: Icon(Icons.insights_outlined), title: Text('Acompanhamento de evolução')),
                ListTile(leading: Icon(Icons.tune), title: Text('Modo claro/escuro e cargas em kg ou lb')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

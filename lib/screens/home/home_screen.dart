import 'package:flutter/material.dart';

import '../../app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          // LOGO / NOME
          Text(
            'FITFLOW',
            style: TextStyle(
              color: FitFlowColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Bora treinar?',
            style: TextStyle(
              color: FitFlowColors.text,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 30),

          // TREINO DE HOJE
          Text(
            'SEU TREINO DE HOJE',
            style: TextStyle(
              color: FitFlowColors.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: FitFlowColors.primary,
                    size: 32,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Peito + Tríceps',
                    style: TextStyle(
                      color: FitFlowColors.text,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '5 exercícios • aproximadamente 50 min',
                    style: TextStyle(color: FitFlowColors.secondaryText),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'A tela de treino será criada no próximo passo!',
                            ),
                          ),
                        );
                      },

                      icon: const Icon(Icons.play_arrow),

                      label: const Text('INICIAR TREINO'),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: FitFlowColors.primary,

                        foregroundColor: Colors.white,

                        padding: const EdgeInsets.symmetric(vertical: 16),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // RESUMO
          Text(
            'RESUMO',
            style: TextStyle(
              color: FitFlowColors.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.fitness_center,
                  value: '12',
                  label: 'Treinos',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _MetricCard(
                  icon: Icons.timer_outlined,
                  value: '4h32',
                  label: 'Tempo',
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ÚLTIMO TREINO
          Text(
            'ÚLTIMO TREINO',
            style: TextStyle(
              color: FitFlowColors.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: FitFlowColors.primary.withValues(alpha: 0.15),

                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.fitness_center,
                  color: FitFlowColors.primary,
                ),
              ),

              title: const Text(
                'Costas + Bíceps',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('26/08/2026 • 48 min'),

              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(icon, color: FitFlowColors.primary),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),

            Text(
              label,
              style: const TextStyle(color: FitFlowColors.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}

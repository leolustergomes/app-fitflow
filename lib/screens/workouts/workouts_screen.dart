import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/section_title.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = [
      'Peito + Tríceps',
      'Costas + Bíceps',
      'Pernas',
      'Ombros',
      'Full Body',
      'Corrida',
      'Spinning',
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          Text(
            'Treinos',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escolha um treino ou monte o seu.',
            style: TextStyle(color: FitFlowColors.secondaryText),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,

            child: OutlinedButton.icon(
              onPressed: () {},

              icon: const Icon(Icons.add),

              label: const Text('CRIAR MEU TREINO'),

              style: OutlinedButton.styleFrom(
                foregroundColor: FitFlowColors.primary,

                side: const BorderSide(color: FitFlowColors.primary),

                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const SectionTitle(title: 'TREINOS PRONTOS'),

          const SizedBox(height: 12),

          ...workouts.map((workout) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),

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

                title: Text(
                  workout,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: const Text('Treino recomendado'),

                trailing: const Icon(Icons.chevron_right),
              ),
            );
          }),
        ],
      ),
    );
  }
}

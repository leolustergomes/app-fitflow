import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../core/widgets/section_title.dart';
import '../../data/mock_data.dart';
import '../../models/workout.dart';
import '../../models/workout_session.dart';
import '../active_workout/active_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Workout> workouts;
  final List<WorkoutSession> sessions;
  final int completedWorkoutCount;
  final int totalWorkoutSeconds;
  final WeightUnit weightUnit;
  final ValueChanged<WorkoutSession> onWorkoutCompleted;

  const HomeScreen({
    super.key,
    required this.workouts,
    required this.sessions,
    required this.completedWorkoutCount,
    required this.totalWorkoutSeconds,
    required this.weightUnit,
    required this.onWorkoutCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    final today = workouts.isNotEmpty ? workouts.first : MockData.workouts.first;
    final lastSession = sessions.isNotEmpty ? sessions.first : null;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('FITFLOW', style: TextStyle(color: colors.primary, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const SizedBox(height: 8),
          Text('Bora treinar?', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 30),
          const SectionTitle(title: 'SEU TREINO DE HOJE'),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.local_fire_department, color: colors.primary, size: 32),
                  const SizedBox(height: 15),
                  Text(today.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('${today.exercises.length} exercícios • aproximadamente ${today.estimatedMinutes} min'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActiveWorkoutScreen(
                            workout: today,
                            weightUnit: weightUnit,
                            onWorkoutCompleted: onWorkoutCompleted,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('INICIAR TREINO'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SectionTitle(title: 'RESUMO'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _MetricCard(icon: Icons.fitness_center, value: '$completedWorkoutCount', label: 'Treinos')),
              const SizedBox(width: 12),
              Expanded(child: _MetricCard(icon: Icons.timer_outlined, value: formatDuration(totalWorkoutSeconds), label: 'Tempo')),
            ],
          ),
          const SizedBox(height: 30),
          const SectionTitle(title: 'ÚLTIMO TREINO'),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: colors.primary.withValues(alpha: .15), borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.fitness_center, color: colors.primary),
              ),
              title: Text(lastSession?.workout.name ?? 'Nenhum treino finalizado', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                lastSession == null
                    ? 'Conclua seu primeiro treino'
                    : '${_formatDate(lastSession.completedAt)} • ${formatDuration(lastSession.durationSeconds)}',
              ),
              trailing: lastSession == null ? null : const Icon(Icons.chevron_right),
              onTap: lastSession == null
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActiveWorkoutScreen(
                            workout: lastSession.workout,
                            previewOnly: true,
                            weightUnit: weightUnit,
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MetricCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            Text(label, style: TextStyle(color: colors.tertiary)),
          ],
        ),
      ),
    );
  }
}

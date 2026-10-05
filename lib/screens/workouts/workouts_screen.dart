import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../core/widgets/section_title.dart';
import '../../models/workout.dart';
import '../../models/workout_session.dart';
import '../create_workout/create_workout_screen.dart';
import '../workout_detail/workout_detail_screen.dart';

class WorkoutsScreen extends StatelessWidget {
  final List<Workout> workouts;
  final WeightUnit weightUnit;
  final ValueChanged<Workout> onWorkoutCreated;
  final ValueChanged<WorkoutSession> onWorkoutCompleted;

  const WorkoutsScreen({
    super.key,
    required this.workouts,
    required this.weightUnit,
    required this.onWorkoutCreated,
    required this.onWorkoutCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Treinos', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8),
          const Text('Escolha um treino ou monte o seu.'),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final workout = await Navigator.push<Workout>(
                  context,
                  MaterialPageRoute(builder: (_) => CreateWorkoutScreen(weightUnit: weightUnit)),
                );
                if (workout != null) onWorkoutCreated(workout);
              },
              icon: const Icon(Icons.add),
              label: const Text('CRIAR MEU TREINO'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                side: BorderSide(color: colors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const SectionTitle(title: 'TREINOS DISPONÍVEIS'),
          const SizedBox(height: 12),
          ...workouts.map(
            (workout) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: colors.primary.withValues(alpha: .15), borderRadius: BorderRadius.circular(14)),
                  child: Icon(workout.category == 'Cardio' ? Icons.directions_run : Icons.fitness_center, color: colors.primary),
                ),
                title: Text(workout.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${workout.exercises.length} exercícios • ${workout.estimatedMinutes} min${workout.isCustom ? ' • Personalizado' : ''}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WorkoutDetailScreen(
                      workout: workout,
                      weightUnit: weightUnit,
                      onWorkoutCompleted: onWorkoutCompleted,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

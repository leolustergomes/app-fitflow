import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../models/workout.dart';
import '../../models/workout_session.dart';
import '../active_workout/active_workout_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;
  final WeightUnit weightUnit;
  final ValueChanged<WorkoutSession> onWorkoutCompleted;

  const WorkoutDetailScreen({
    super.key,
    required this.workout,
    required this.weightUnit,
    required this.onWorkoutCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(workout.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(workout.category.toUpperCase(), style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text('${workout.exercises.length} exercícios • ${workout.estimatedMinutes} minutos'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...workout.exercises.asMap().entries.map((entry) {
            final i = entry.key + 1;
            final exercise = entry.value;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors.primary.withValues(alpha: .15),
                  child: Text('$i', style: TextStyle(color: colors.primary)),
                ),
                title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  exercise.weight > 0
                      ? '${exercise.sets} séries × ${exercise.reps} reps • ${weightUnit.format(exercise.weight)}'
                      : '${exercise.sets} bloco(s) • ${exercise.reps} min',
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ActiveWorkoutScreen(
                  workout: workout,
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
            ),
          ),
        ],
      ),
    );
  }
}

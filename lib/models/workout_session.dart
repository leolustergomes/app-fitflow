import 'workout.dart';

class WorkoutSession {
  final Workout workout;
  final DateTime completedAt;
  final int durationSeconds;

  const WorkoutSession({
    required this.workout,
    required this.completedAt,
    required this.durationSeconds,
  });
}

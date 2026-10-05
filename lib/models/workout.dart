
class WorkoutExercise {
  final String name;
  final int sets;
  final int reps;
  final double weight;

  const WorkoutExercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight = 0,
  });
}

class Workout {
  final String id;
  final String name;
  final String category;
  final int estimatedMinutes;
  final List<WorkoutExercise> exercises;
  final bool isCustom;

  const Workout({
    required this.id,
    required this.name,
    required this.category,
    required this.estimatedMinutes,
    required this.exercises,
    this.isCustom = false,
  });
}

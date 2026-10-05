
import '../models/workout.dart';

class MockData {
  static const workouts = <Workout>[
    Workout(
      id: 'peito-triceps',
      name: 'Peito + Tríceps',
      category: 'Musculação',
      estimatedMinutes: 50,
      exercises: [
        WorkoutExercise(name: 'Supino reto', sets: 4, reps: 10, weight: 70),
        WorkoutExercise(name: 'Supino inclinado', sets: 3, reps: 10, weight: 50),
        WorkoutExercise(name: 'Crucifixo', sets: 3, reps: 12, weight: 16),
        WorkoutExercise(name: 'Tríceps pulley', sets: 3, reps: 12, weight: 35),
        WorkoutExercise(name: 'Tríceps francês', sets: 3, reps: 10, weight: 24),
      ],
    ),
    Workout(
      id: 'costas-biceps',
      name: 'Costas + Bíceps',
      category: 'Musculação',
      estimatedMinutes: 48,
      exercises: [
        WorkoutExercise(name: 'Puxada frontal', sets: 4, reps: 10, weight: 60),
        WorkoutExercise(name: 'Remada baixa', sets: 3, reps: 10, weight: 55),
        WorkoutExercise(name: 'Remada unilateral', sets: 3, reps: 10, weight: 26),
        WorkoutExercise(name: 'Rosca direta', sets: 3, reps: 10, weight: 30),
      ],
    ),
    Workout(
      id: 'pernas',
      name: 'Pernas',
      category: 'Musculação',
      estimatedMinutes: 55,
      exercises: [
        WorkoutExercise(name: 'Agachamento', sets: 4, reps: 8, weight: 80),
        WorkoutExercise(name: 'Leg press', sets: 4, reps: 10, weight: 160),
        WorkoutExercise(name: 'Cadeira extensora', sets: 3, reps: 12, weight: 50),
        WorkoutExercise(name: 'Mesa flexora', sets: 3, reps: 12, weight: 45),
      ],
    ),
    Workout(
      id: 'full-body',
      name: 'Full Body',
      category: 'Musculação',
      estimatedMinutes: 45,
      exercises: [
        WorkoutExercise(name: 'Agachamento', sets: 3, reps: 10, weight: 60),
        WorkoutExercise(name: 'Supino reto', sets: 3, reps: 10, weight: 60),
        WorkoutExercise(name: 'Puxada frontal', sets: 3, reps: 10, weight: 50),
        WorkoutExercise(name: 'Desenvolvimento', sets: 3, reps: 10, weight: 24),
      ],
    ),
    Workout(
      id: 'corrida',
      name: 'Corrida',
      category: 'Cardio',
      estimatedMinutes: 30,
      exercises: [
        WorkoutExercise(name: 'Aquecimento', sets: 1, reps: 5),
        WorkoutExercise(name: 'Corrida moderada', sets: 1, reps: 20),
        WorkoutExercise(name: 'Desaceleração', sets: 1, reps: 5),
      ],
    ),
    Workout(
      id: 'spinning',
      name: 'Spinning',
      category: 'Cardio',
      estimatedMinutes: 40,
      exercises: [
        WorkoutExercise(name: 'Aquecimento', sets: 1, reps: 5),
        WorkoutExercise(name: 'Ritmo forte', sets: 1, reps: 30),
        WorkoutExercise(name: 'Desaceleração', sets: 1, reps: 5),
      ],
    ),
  ];

  static const progress = <double>[60, 62, 65, 64, 68, 70];

  static const recentWorkouts = <Map<String, String>>[
    {'name': 'Costas + Bíceps', 'date': '26/08/2026', 'duration': '48 min'},
    {'name': 'Peito + Tríceps', 'date': '24/08/2026', 'duration': '51 min'},
    {'name': 'Pernas', 'date': '22/08/2026', 'duration': '55 min'},
  ];
}

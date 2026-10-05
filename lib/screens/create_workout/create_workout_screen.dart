import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../models/workout.dart';

class CreateWorkoutScreen extends StatefulWidget {
  final WeightUnit weightUnit;

  const CreateWorkoutScreen({super.key, required this.weightUnit});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final nameController = TextEditingController();
  final minutesController = TextEditingController(text: '45');
  final exercises = <WorkoutExercise>[];
  final exerciseController = TextEditingController();
  final repsController = TextEditingController(text: '10');
  final setsController = TextEditingController(text: '3');
  final weightController = TextEditingController(text: '0');

  @override
  void dispose() {
    nameController.dispose();
    minutesController.dispose();
    exerciseController.dispose();
    repsController.dispose();
    setsController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void addExercise() {
    final name = exerciseController.text.trim();
    final weightInput = double.tryParse(weightController.text.replaceAll(',', '.')) ?? 0;
    final sets = int.tryParse(setsController.text) ?? 3;
    final reps = int.tryParse(repsController.text) ?? 10;

    if (name.isEmpty) return;
    if (sets <= 0 || reps <= 0 || weightInput < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confira séries, repetições e carga.')));
      return;
    }

    setState(() {
      exercises.add(
        WorkoutExercise(
          name: name,
          sets: sets,
          reps: reps,
          weight: widget.weightUnit.toKg(weightInput),
        ),
      );
      exerciseController.clear();
      weightController.text = '0';
    });
  }

  void save() {
    final name = nameController.text.trim();
    final minutes = int.tryParse(minutesController.text) ?? 45;
    if (name.isEmpty || exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe o nome e adicione pelo menos um exercício.')));
      return;
    }
    if (minutes <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe uma duração válida.')));
      return;
    }

    Navigator.pop(
      context,
      Workout(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: 'Personalizado',
        estimatedMinutes: minutes,
        exercises: List.unmodifiable(exercises),
        isCustom: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    final unit = widget.weightUnit.symbol;

    return Scaffold(
      appBar: AppBar(title: const Text('Criar treino')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nome do treino', prefixIcon: Icon(Icons.edit)),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: minutesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Duração estimada (min)', prefixIcon: Icon(Icons.timer_outlined)),
          ),
          const SizedBox(height: 25),
          Text('ADICIONAR EXERCÍCIOS', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 12),
          TextField(
            controller: exerciseController,
            decoration: const InputDecoration(labelText: 'Exercício', prefixIcon: Icon(Icons.fitness_center_outlined)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: setsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Séries'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: repsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Reps/min'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Carga ($unit)',
              hintText: '0 para exercícios sem carga',
              prefixIcon: const Icon(Icons.monitor_weight_outlined),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: addExercise,
            icon: const Icon(Icons.add),
            label: const Text('ADICIONAR EXERCÍCIO'),
          ),
          const SizedBox(height: 10),
          ...exercises.asMap().entries.map(
                (entry) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors.primary.withValues(alpha: .15),
                      child: Text('${entry.key + 1}'),
                    ),
                    title: Text(entry.value.name),
                    subtitle: Text(
                      entry.value.weight > 0
                          ? '${entry.value.sets} séries × ${entry.value.reps} • ${widget.weightUnit.format(entry.value.weight)}'
                          : '${entry.value.sets} séries × ${entry.value.reps}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => setState(() => exercises.removeAt(entry.key)),
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: save,
            icon: const Icon(Icons.save),
            label: const Text('SALVAR TREINO'),
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

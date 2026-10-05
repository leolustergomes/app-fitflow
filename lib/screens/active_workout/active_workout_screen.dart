import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../models/workout.dart';
import '../../models/workout_session.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final Workout workout;
  final bool previewOnly;
  final WeightUnit weightUnit;
  final ValueChanged<WorkoutSession>? onWorkoutCompleted;

  const ActiveWorkoutScreen({
    super.key,
    required this.workout,
    this.previewOnly = false,
    this.weightUnit = WeightUnit.kg,
    this.onWorkoutCompleted,
  });

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  late List<bool> completed;
  Timer? timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    completed = List<bool>.filled(widget.workout.exercises.length, false);
    if (!widget.previewOnly) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => seconds++);
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> finish() async {
    timer?.cancel();
    final done = completed.where((e) => e).length;
    final session = WorkoutSession(
      workout: widget.workout,
      completedAt: DateTime.now(),
      durationSeconds: seconds,
    );

    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Treino finalizado!'),
        content: Text('$done de ${completed.length} exercícios concluídos.\nTempo: ${formatTimer(seconds)}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );

    if (!mounted) return;
    widget.onWorkoutCompleted?.call(session);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    final done = completed.where((e) => e).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.previewOnly ? 'Resumo do treino' : 'Treino em andamento'),
        actions: [
          if (!widget.previewOnly)
            IconButton(onPressed: finish, icon: const Icon(Icons.check), tooltip: 'Finalizar'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.workout.name, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 5),
                        Text('$done/${completed.length} concluídos'),
                      ],
                    ),
                  ),
                  if (!widget.previewOnly)
                    Text(
                      formatTimer(seconds),
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: colors.primary),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(widget.workout.exercises.length, (i) {
            final exercise = widget.workout.exercises[i];
            return Card(
              child: CheckboxListTile(
                value: completed[i],
                onChanged: widget.previewOnly ? null : (value) => setState(() => completed[i] = value ?? false),
                activeColor: colors.primary,
                title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  exercise.weight > 0
                      ? '${exercise.sets} séries × ${exercise.reps} reps • ${widget.weightUnit.format(exercise.weight)}'
                      : '${exercise.reps} min',
                ),
              ),
            );
          }),
          if (!widget.previewOnly) ...[
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: finish,
              icon: const Icon(Icons.stop),
              label: const Text('TERMINAR TREINO'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

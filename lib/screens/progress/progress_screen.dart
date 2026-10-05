import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../data/mock_data.dart';
import '../../models/workout_session.dart';

class ProgressScreen extends StatelessWidget {
  final List<WorkoutSession> sessions;
  final WeightUnit weightUnit;

  const ProgressScreen({super.key, required this.sessions, required this.weightUnit});

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    final convertedProgress = MockData.progress.map(weightUnit.fromKg).toList();
    final maxLoad = MockData.progress.reduce(math.max);
    final minLoad = MockData.progress.reduce(math.min);
    final evolution = minLoad == 0 ? 0 : ((maxLoad - minLoad) / minLoad) * 100;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Minha evolução', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8),
          const Text('Acompanhe seu progresso ao longo do tempo.'),
          const SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SUPINO RETO', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Evolução da carga', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: CustomPaint(
                      painter: _ProgressPainter(convertedProgress, colors.primary),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Mai'), Text('Jun'), Text('Jul'), Text('Ago'), Text('Set'), Text('Out')],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _StatCard(value: weightUnit.format(maxLoad), label: 'Maior carga')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(value: '+${evolution.toStringAsFixed(1).replaceAll('.', ',')}%', label: 'Evolução')),
            ],
          ),
          const SizedBox(height: 25),
          Text('ÚLTIMOS TREINOS', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          ...sessions.map(
            (session) => Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: colors.primary),
                title: Text(session.workout.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${_formatDate(session.completedAt)} • ${formatDuration(session.durationSeconds)}'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: colors.tertiary)),
          ],
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final List<double> values;
  final Color color;

  _ProgressPainter(this.values, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.width <= 0 || size.height <= 0) return;

    final line = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final dot = Paint()..color = color;
    final maxValue = (values.reduce(math.max) + 2.0).toDouble();
    final minValue = math.max(0.0, values.reduce(math.min) - 2.0).toDouble();
    final path = Path();

    for (var i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final range = maxValue - minValue == 0 ? 1 : maxValue - minValue;
      final normalized = (values[i] - minValue) / range;
      final y = size.height - (normalized.clamp(0.0, 1.0) * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 5, dot);
    }

    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) => oldDelegate.values != values || oldDelegate.color != color;
}

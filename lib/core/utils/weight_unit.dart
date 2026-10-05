import 'dart:math' as math;

enum WeightUnit { kg, lb }

extension WeightUnitX on WeightUnit {
  String get label => this == WeightUnit.kg ? 'Quilogramas (kg)' : 'Libras (lb)';
  String get symbol => this == WeightUnit.kg ? 'kg' : 'lb';

  double fromKg(double kg) => this == WeightUnit.kg ? kg : kg * 2.2046226218;

  double toKg(double value) => this == WeightUnit.kg ? value : value / 2.2046226218;

  String format(double kg) {
    final value = fromKg(kg);
    final decimals = (value - value.roundToDouble()).abs() < 0.01 ? 0 : 1;
    return '${value.toStringAsFixed(decimals)} $symbol';
  }
}

String formatDuration(int totalSeconds) {
  final safeSeconds = math.max(0, totalSeconds);
  final hours = safeSeconds ~/ 3600;
  final minutes = (safeSeconds % 3600) ~/ 60;

  // Treinos curtos (ex.: demonstração) apareceriam como "0 min".
  if (safeSeconds < 60) {
    return '$safeSeconds s';
  }
  if (hours > 0) {
    return '${hours}h ${minutes.toString().padLeft(2, '0')}min';
  }
  return '$minutes min';
}

String formatTimer(int totalSeconds) {
  final safeSeconds = math.max(0, totalSeconds);
  final minutes = safeSeconds ~/ 60;
  final seconds = safeSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

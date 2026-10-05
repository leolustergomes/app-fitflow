enum TrainingLevel { iniciante, intermediario, avancado }

enum TrainingGoal {
  emagrecimentoComposicao,
  hipertrofiaForca,
  condicionamentoSaude,
  funcionalPerformance,
}

class UserProfile {
  final String name;
  final TrainingGoal goal;
  final TrainingLevel level;

  const UserProfile({
    required this.name,
    required this.goal,
    required this.level,
  });

  UserProfile copyWith({
    String? name,
    TrainingGoal? goal,
    TrainingLevel? level,
  }) {
    return UserProfile(
      name: name ?? this.name,
      goal: goal ?? this.goal,
      level: level ?? this.level,
    );
  }
}

extension TrainingGoalX on TrainingGoal {
  String get label {
    switch (this) {
      case TrainingGoal.emagrecimentoComposicao:
        return 'Emagrecimento e Composição Corporal';
      case TrainingGoal.hipertrofiaForca:
        return 'Hipertrofia e Força';
      case TrainingGoal.condicionamentoSaude:
        return 'Condicionamento Físico e Saúde';
      case TrainingGoal.funcionalPerformance:
        return 'Funcional e Performance';
    }
  }
}

extension TrainingLevelX on TrainingLevel {
  String get label {
    switch (this) {
      case TrainingLevel.iniciante:
        return 'Iniciante';
      case TrainingLevel.intermediario:
        return 'Intermediário';
      case TrainingLevel.avancado:
        return 'Avançado';
    }
  }
}

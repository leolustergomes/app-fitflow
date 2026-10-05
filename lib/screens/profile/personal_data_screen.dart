import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../models/user_profile.dart';

class PersonalDataScreen extends StatefulWidget {
  final UserProfile profile;

  const PersonalDataScreen({super.key, required this.profile});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  late final TextEditingController nameController;
  late TrainingGoal goal;
  late TrainingLevel level;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    goal = widget.profile.goal;
    level = widget.profile.level;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void save() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe seu nome.')));
      return;
    }

    Navigator.pop(
      context,
      widget.profile.copyWith(name: name, goal: goal, level: level),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados pessoais'),
        actions: [TextButton(onPressed: save, child: const Text('SALVAR'))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('IDENTIFICAÇÃO', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text('OBJETIVO', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 4),
              child: DropdownButtonFormField<TrainingGoal>(
                initialValue: goal,
                // Os rótulos de objetivo são longos; sem isExpanded o campo
                // estoura a largura em telas de celular.
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Objetivo de treino',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: TrainingGoal.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.label, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => goal = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text('NÍVEL', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              child: SegmentedButton<TrainingLevel>(
                // Sem o ícone de check e com padding menor, "Intermediário" e
                // "Avançado" cabem numa linha mesmo em telas de 360dp; a cor
                // de fundo já indica o nível selecionado.
                showSelectedIcon: false,
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 4)),
                ),
                segments: TrainingLevel.values
                    .map(
                      (item) => ButtonSegment<TrainingLevel>(
                        value: item,
                        label: Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                selected: {level},
                onSelectionChanged: (values) => setState(() => level = values.first),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

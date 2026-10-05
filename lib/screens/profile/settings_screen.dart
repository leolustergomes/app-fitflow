import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';

class SettingsResult {
  final bool isLightMode;
  final WeightUnit weightUnit;
  final bool notificationsEnabled;

  const SettingsResult({
    required this.isLightMode,
    required this.weightUnit,
    required this.notificationsEnabled,
  });
}

class SettingsScreen extends StatefulWidget {
  final bool isLightMode;
  final WeightUnit weightUnit;
  final bool notificationsEnabled;

  const SettingsScreen({
    super.key,
    required this.isLightMode,
    required this.weightUnit,
    required this.notificationsEnabled,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isLightMode;
  late WeightUnit weightUnit;
  late bool notificationsEnabled;

  @override
  void initState() {
    super.initState();
    isLightMode = widget.isLightMode;
    weightUnit = widget.weightUnit;
    notificationsEnabled = widget.notificationsEnabled;
  }

  void save() {
    Navigator.pop(
      context,
      SettingsResult(
        isLightMode: isLightMode,
        weightUnit: weightUnit,
        notificationsEnabled: notificationsEnabled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        actions: [
          TextButton(onPressed: save, child: const Text('SALVAR')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('APARÊNCIA', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: SwitchListTile(
              value: isLightMode,
              onChanged: (value) => setState(() => isLightMode = value),
              title: const Text('Modo claro', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(isLightMode ? 'Fundo branco e detalhes roxos' : 'Tema escuro do FitFlow'),
              secondary: Icon(isLightMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: colors.primary),
            ),
          ),
          const SizedBox(height: 25),
          Text('TREINO', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 4),
              child: DropdownButtonFormField<WeightUnit>(
                initialValue: weightUnit,
                decoration: const InputDecoration(
                  labelText: 'Unidade de peso',
                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                ),
                items: WeightUnit.values
                    .map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => weightUnit = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text('NOTIFICAÇÕES', style: TextStyle(color: colors.tertiary, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 10),
          Card(
            child: SwitchListTile(
              value: notificationsEnabled,
              onChanged: (value) => setState(() => notificationsEnabled = value),
              title: const Text('Notificações', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                notificationsEnabled
                    ? 'Lembretes do FitFlow estão ativados'
                    : 'Lembretes do FitFlow estão desativados',
              ),
              secondary: Icon(Icons.notifications_outlined, color: colors.primary),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'A preferência de notificações controla o estado dos lembretes do aplicativo. O envio de notificações push/agendadas depende da integração de notificações do dispositivo.',
            style: TextStyle(color: colors.tertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

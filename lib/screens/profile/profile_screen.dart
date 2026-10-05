import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/utils/weight_unit.dart';
import '../../models/user_profile.dart';
import 'about_screen.dart';
import 'personal_data_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile profile;
  final WeightUnit weightUnit;
  final bool notificationsEnabled;
  final bool isLightMode;
  final ValueChanged<UserProfile> onProfileChanged;
  final ValueChanged<WeightUnit> onWeightUnitChanged;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onLightModeChanged;

  const ProfileScreen({
    super.key,
    required this.profile,
    required this.weightUnit,
    required this.notificationsEnabled,
    required this.isLightMode,
    required this.onProfileChanged,
    required this.onWeightUnitChanged,
    required this.onNotificationsChanged,
    required this.onLightModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FitFlowColors.of(context);
    final initials = profile.name.trim().isEmpty
        ? 'FF'
        : profile.name.trim().substring(0, 1).toUpperCase();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Perfil', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colors.primary,
                    child: Text(
                      initials,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 5),
                        Text(
                          '${profile.goal.label} • ${profile.level.label}',
                          style: TextStyle(color: colors.tertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person_outline, color: colors.primary),
                  title: const Text('Dados pessoais'),
                  subtitle: Text('${profile.name} • ${profile.level.label}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final updated = await Navigator.push<UserProfile>(
                      context,
                      MaterialPageRoute(builder: (_) => PersonalDataScreen(profile: profile)),
                    );
                    if (updated != null) onProfileChanged(updated);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.settings_outlined, color: colors.primary),
                  title: const Text('Configurações'),
                  subtitle: Text('${isLightMode ? 'Modo claro' : 'Modo escuro'} • ${weightUnit.symbol}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final settings = await Navigator.push<SettingsResult>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsScreen(
                          isLightMode: isLightMode,
                          weightUnit: weightUnit,
                          notificationsEnabled: notificationsEnabled,
                        ),
                      ),
                    );
                    if (settings != null) {
                      onWeightUnitChanged(settings.weightUnit);
                      onNotificationsChanged(settings.notificationsEnabled);
                      onLightModeChanged(settings.isLightMode);
                    }
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.info_outline, color: colors.primary),
                  title: const Text('Sobre o FitFlow'),
                  subtitle: const Text('Conheça o aplicativo'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

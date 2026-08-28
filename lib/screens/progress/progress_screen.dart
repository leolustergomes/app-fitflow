import 'package:flutter/material.dart';

import '../../app/theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          Text(
            'Minha evolução',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 8),

          const Text(
            'Acompanhe seu progresso ao longo do tempo.',
            style: TextStyle(color: FitFlowColors.secondaryText),
          ),

          const SizedBox(height: 25),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'SUPINO RETO',
                    style: TextStyle(
                      color: FitFlowColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Evolução da carga',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    height: 180,

                    decoration: BoxDecoration(
                      color: FitFlowColors.background,

                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.show_chart,
                        color: FitFlowColors.primary,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: const [
              Expanded(
                child: _StatCard(value: '70 kg', label: 'Maior carga'),
              ),

              SizedBox(width: 12),

              Expanded(
                child: _StatCard(value: '+16,7%', label: 'Evolução'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: const TextStyle(color: FitFlowColors.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Rótulo de seção em caixa alta, com ação opcional à direita.
///
/// Centraliza o estilo dos cabeçalhos de bloco usados nas telas para manter a
/// consistência tipográfica da marca.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.toUpperCase(), style: FitFlowTextStyles.sectionLabel),

        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(color: FitFlowColors.primary),
            ),
          ),
      ],
    );
  }
}

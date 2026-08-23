import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/l10n/app_localizations.dart';

class EmptySuggestionsWidget extends StatelessWidget {
  final VoidCallback onGenerateDemo;

  const EmptySuggestionsWidget({
    super.key,
    required this.onGenerateDemo,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🐻',
              style: const TextStyle(fontSize: 100),
            ),
            SizedBox(height: AppDimensions.space4),
            Text(
              l10n.suggestions_noSuggestions,
              style: AppTextStyles.headlineMedium(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.space2),
            Text(
              'Tinker ainda está observando seus hábitos.\nVolte mais tarde!',
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.space6),
            ElevatedButton.icon(
              onPressed: onGenerateDemo,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Gerar Sugestão Demo'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

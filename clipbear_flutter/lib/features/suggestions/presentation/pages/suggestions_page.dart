import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../controllers/suggestions_controller.dart';
import '../widgets/suggestion_card.dart';
import '../widgets/empty_suggestions_widget.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(SuggestionsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.suggestions_title,
          style: AppTextStyles.headlineMedium(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined),
            onPressed: () {
              // TODO: Show history
            },
            tooltip: l10n.history_title,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Stats Header
            Obx(() => Container(
              margin: EdgeInsets.all(AppDimensions.paddingMedium),
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                gradient: AppColors.tinkerGradient,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    '${controller.totalSuggestions}',
                    l10n.history_suggestionsReceived,
                    Icons.lightbulb_outline,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  _buildStatItem(
                    '${(controller.acceptanceRate * 100).toInt()}%',
                    l10n.history_acceptanceRate,
                    Icons.trending_up,
                  ),
                ],
              ),
            )),

            // Current Suggestion
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final suggestion = controller.currentSuggestion.value;
                if (suggestion == null) {
                  return EmptySuggestionsWidget(
                    onGenerateDemo: controller.generateDemoSuggestion,
                  );
                }

                return SuggestionCard(
                  suggestion: suggestion,
                  onAccept: controller.acceptSuggestion,
                  onReject: controller.rejectSuggestion,
                  onPostpone: (duration) => controller.postponeSuggestion(duration),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => controller.isLoading.value
          ? const SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: controller.generateDemoSuggestion,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Gerar Demo'),
            )),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: AppDimensions.space1),
        Text(
          value,
          style: AppTextStyles.headlineLarge(color: Colors.white),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall(
            color: Colors.white.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

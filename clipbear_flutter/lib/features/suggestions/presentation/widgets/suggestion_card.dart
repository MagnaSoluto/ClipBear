import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../domain/models/suggestion_model.dart';

class SuggestionCard extends StatefulWidget {
  final SuggestionModel suggestion;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final Function(Duration) onPostpone;

  const SuggestionCard({
    super.key,
    required this.suggestion,
    required this.onAccept,
    required this.onReject,
    required this.onPostpone,
  });

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _showReason = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Setup timeago locale
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emoji
                Text(
                  widget.suggestion.emoji ?? '💡',
                  style: const TextStyle(fontSize: 80),
                ),

                SizedBox(height: AppDimensions.space4),

                // Title
                Text(
                  widget.suggestion.title,
                  style: AppTextStyles.headlineLarge(),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: AppDimensions.space3),

                // Description
                Container(
                  padding: EdgeInsets.all(AppDimensions.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                  child: Text(
                    widget.suggestion.description,
                    style: AppTextStyles.bodyLarge(),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: AppDimensions.space3),

                // Reason toggle
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showReason = !_showReason;
                    });
                  },
                  icon: Icon(
                    _showReason ? Icons.expand_less : Icons.expand_more,
                  ),
                  label: Text(l10n.suggestions_whyThis),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _showReason
                      ? Container(
                          margin: EdgeInsets.symmetric(
                            vertical: AppDimensions.space2,
                          ),
                          padding: EdgeInsets.all(AppDimensions.paddingMedium),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: AppDimensions.space2),
                              Expanded(
                                child: Text(
                                  widget.suggestion.reason,
                                  style: AppTextStyles.bodySmall(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                SizedBox(height: AppDimensions.space4),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onReject,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingMedium,
                          ),
                        ),
                        child: Text(l10n.suggestions_reject),
                      ),
                    ),
                    SizedBox(width: AppDimensions.space2),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: widget.onAccept,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingMedium,
                          ),
                        ),
                        child: Text(l10n.suggestions_accept),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimensions.space2),

                // Postpone Button
                OutlinedButton.icon(
                  onPressed: () => _showPostponeOptions(context, l10n),
                  icon: const Icon(Icons.schedule),
                  label: Text(l10n.suggestions_postpone),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),

                SizedBox(height: AppDimensions.space4),

                // Time ago
                Text(
                  timeago.format(
                    widget.suggestion.createdAt,
                    locale: 'pt_BR',
                  ),
                  style: AppTextStyles.bodySmall(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPostponeOptions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.suggestions_postpone,
              style: AppTextStyles.headlineSmall(),
            ),
            SizedBox(height: AppDimensions.space3),
            _buildPostponeOption(
              context,
              l10n.suggestions_postpone_30min,
              const Duration(minutes: 30),
            ),
            _buildPostponeOption(
              context,
              l10n.suggestions_postpone_1hour,
              const Duration(hours: 1),
            ),
            _buildPostponeOption(
              context,
              l10n.suggestions_postpone_3hours,
              const Duration(hours: 3),
            ),
            SizedBox(height: AppDimensions.space2),
          ],
        ),
      ),
    );
  }

  Widget _buildPostponeOption(
    BuildContext context,
    String label,
    Duration duration,
  ) {
    return ListTile(
      leading: const Icon(Icons.schedule),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        widget.onPostpone(duration);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/localization/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = Get.find<LocaleController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.home_title,
          style: AppTextStyles.headlineMedium(),
        ),
        actions: [
          // Language toggle button
          IconButton(
            icon: Icon(
              localeController.isPortuguese
                  ? Icons.language
                  : Icons.translate,
            ),
            tooltip: localeController.isPortuguese
                ? 'Switch to English'
                : 'Mudar para Português',
            onPressed: () {
              localeController.toggleLanguage();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                _getGreeting(l10n),
                style: AppTextStyles.displayMedium(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              SizedBox(height: AppDimensions.space2),
              Text(
                l10n.home_welcomeMessage,
                style: AppTextStyles.bodyLarge(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              
              SizedBox(height: AppDimensions.space6),

              // Avatar Placeholder
              Center(
                child: Container(
                  width: AppDimensions.avatarHero,
                  height: AppDimensions.avatarHero,
                  decoration: BoxDecoration(
                    gradient: AppColors.tinkerGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '🤖',
                      style: TextStyle(fontSize: AppDimensions.space7),
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.space5),

              // Status Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: AppColors.primary,
                            size: AppDimensions.iconLarge,
                          ),
                          SizedBox(width: AppDimensions.space3),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.home_yourActivityToday,
                                  style: AppTextStyles.titleLarge(),
                                ),
                                SizedBox(height: AppDimensions.space1),
                                Text(
                                  l10n.home_noSuggestionsYet,
                                  style: AppTextStyles.bodyMedium(
                                    color: AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.space4),
                      Divider(color: AppColors.dividerLight),
                      SizedBox(height: AppDimensions.space4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            icon: Icons.check_circle_outline,
                            label: l10n.home_statsAccepted,
                            value: '0',
                            color: AppColors.success,
                          ),
                          _buildStatItem(
                            icon: Icons.cancel_outlined,
                            label: l10n.home_statsRejected,
                            value: '0',
                            color: AppColors.error,
                          ),
                          _buildStatItem(
                            icon: Icons.schedule,
                            label: l10n.home_statsPostponed,
                            value: '0',
                            color: AppColors.warning,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.space5),

              // Welcome Message Card
              Card(
                color: AppColors.primary,
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    children: [
                      Text(
                        l10n.home_launchMessage,
                        style: AppTextStyles.headlineSmall(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.space3),
                      Text(
                        l10n.home_launchDescription,
                        style: AppTextStyles.bodyMedium(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.space5),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Start onboarding
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: Text(l10n.home_buttonStartTour),
                    ),
                  ),
                  SizedBox(width: AppDimensions.space3),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Show about
                      },
                      icon: const Icon(Icons.info_outline),
                      label: Text(l10n.home_buttonAbout),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: AppDimensions.iconLarge),
        SizedBox(height: AppDimensions.space2),
        Text(
          value,
          style: AppTextStyles.headlineMedium(color: color),
        ),
        SizedBox(height: AppDimensions.space1),
        Text(
          label,
          style: AppTextStyles.labelSmall(
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return l10n.greeting_morning;
    } else if (hour < 18) {
      return l10n.greeting_afternoon;
    } else if (hour < 22) {
      return l10n.greeting_evening;
    } else {
      return l10n.greeting_night;
    }
  }
}

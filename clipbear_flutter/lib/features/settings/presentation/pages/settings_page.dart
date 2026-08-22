import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/localization/locale_controller.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(SettingsController());
    final localeController = Get.find<LocaleController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings_title,
          style: AppTextStyles.headlineMedium(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppDimensions.paddingMedium),
          children: [
            // Appearance Section
            SettingsSection(
              title: l10n.settings_appearance,
              icon: Icons.palette_outlined,
              children: [
                SettingsTile(
                  title: l10n.settings_theme,
                  subtitle: _getThemeLabel(controller.selectedTheme.value, l10n),
                  leading: const Icon(Icons.brightness_6_outlined),
                  onTap: () => _showThemeDialog(context, controller, l10n),
                ),
                SettingsTile(
                  title: l10n.settings_language,
                  subtitle: localeController.getLocaleDisplayName(
                    localeController.locale,
                  ),
                  leading: const Icon(Icons.language_outlined),
                  onTap: () => _showLanguageDialog(context, localeController, l10n),
                ),
              ],
            ),

            SizedBox(height: AppDimensions.space4),

            // Notifications Section
            SettingsSection(
              title: l10n.settings_notifications,
              icon: Icons.notifications_outlined,
              children: [
                Obx(() => SwitchListTile(
                  title: Text(
                    l10n.settings_notifications_enabled,
                    style: AppTextStyles.titleMedium(),
                  ),
                  subtitle: Text(
                    'Receber sugestões do Tinker',
                    style: AppTextStyles.bodySmall(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  value: controller.notificationsEnabled.value,
                  onChanged: controller.toggleNotifications,
                  activeTrackColor: AppColors.primary,
                )),
                
                Obx(() => AnimatedOpacity(
                  opacity: controller.notificationsEnabled.value ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppDimensions.paddingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.settings_notifications_intensity,
                                  style: AppTextStyles.titleSmall(),
                                ),
                                Text(
                                  controller.getIntensityLabel(),
                                  style: AppTextStyles.bodySmall(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.space2),
                            Slider(
                              value: controller.notificationIntensity.value,
                              onChanged: controller.notificationsEnabled.value
                                  ? controller.updateIntensity
                                  : null,
                              activeColor: AppColors.primary,
                              divisions: 2,
                              label: controller.getIntensityLabel(),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => SwitchListTile(
                        title: Text(
                          l10n.settings_notifications_quietHours,
                          style: AppTextStyles.titleMedium(),
                        ),
                        subtitle: Text(
                          controller.quietHoursEnabled.value
                              ? '${controller.quietHoursStart.value} - ${controller.quietHoursEnd.value}'
                              : 'Desativado',
                          style: AppTextStyles.bodySmall(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                        value: controller.quietHoursEnabled.value,
                        onChanged: controller.notificationsEnabled.value
                            ? controller.toggleQuietHours
                            : null,
                        activeTrackColor: AppColors.primary,
                      )),
                    ],
                  ),
                )),
              ],
            ),

            SizedBox(height: AppDimensions.space4),

            // Privacy & Data Section
            SettingsSection(
              title: l10n.settings_privacy,
              icon: Icons.privacy_tip_outlined,
              children: [
                SettingsTile(
                  title: l10n.settings_privacy_dataExport,
                  subtitle: 'Exportar todos os dados em JSON',
                  leading: const Icon(Icons.upload_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => controller.exportData(context),
                ),
                SettingsTile(
                  title: l10n.settings_privacy_dataDelete,
                  subtitle: 'Apagar permanentemente todos os dados',
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => controller.deleteAllData(context),
                  titleColor: Colors.red,
                ),
                Divider(height: 1, color: AppColors.dividerLight),
                SettingsTile(
                  title: l10n.settings_privacy_policy,
                  leading: const Icon(Icons.description_outlined),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () {
                    // TODO: Open privacy policy
                  },
                ),
                SettingsTile(
                  title: l10n.settings_privacy_terms,
                  leading: const Icon(Icons.article_outlined),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () {
                    // TODO: Open terms
                  },
                ),
              ],
            ),

            SizedBox(height: AppDimensions.space4),

            // About Section
            SettingsSection(
              title: l10n.settings_about,
              icon: Icons.info_outlined,
              children: [
                SettingsTile(
                  title: l10n.settings_about_version,
                  subtitle: '2.0.0 (Flutter)',
                  leading: const Icon(Icons.info_outlined),
                ),
                SettingsTile(
                  title: l10n.settings_about_openSource,
                  subtitle: 'MIT License',
                  leading: const Icon(Icons.code_outlined),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () {
                    // TODO: Open GitHub
                  },
                ),
              ],
            ),

            SizedBox(height: AppDimensions.space6),
          ],
        ),
      ),
    );
  }

  String _getThemeLabel(String theme, AppLocalizations l10n) {
    switch (theme) {
      case 'light':
        return l10n.settings_theme_light;
      case 'dark':
        return l10n.settings_theme_dark;
      case 'system':
      default:
        return l10n.settings_theme_auto;
    }
  }

  void _showThemeDialog(
    BuildContext context,
    SettingsController controller,
    AppLocalizations l10n,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(l10n.settings_theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => RadioListTile<String>(
              title: Row(
                children: [
                  const Icon(Icons.light_mode, size: 20),
                  SizedBox(width: AppDimensions.space2),
                  Text(l10n.settings_theme_light),
                ],
              ),
              value: 'light',
              groupValue: controller.selectedTheme.value,
              onChanged: (value) {
                if (value != null) {
                  controller.changeTheme(value);
                  Get.back();
                }
              },
              activeColor: AppColors.primary,
            )),
            Obx(() => RadioListTile<String>(
              title: Row(
                children: [
                  const Icon(Icons.dark_mode, size: 20),
                  SizedBox(width: AppDimensions.space2),
                  Text(l10n.settings_theme_dark),
                ],
              ),
              value: 'dark',
              groupValue: controller.selectedTheme.value,
              onChanged: (value) {
                if (value != null) {
                  controller.changeTheme(value);
                  Get.back();
                }
              },
              activeColor: AppColors.primary,
            )),
            Obx(() => RadioListTile<String>(
              title: Row(
                children: [
                  const Icon(Icons.brightness_auto, size: 20),
                  SizedBox(width: AppDimensions.space2),
                  Text(l10n.settings_theme_auto),
                ],
              ),
              value: 'system',
              groupValue: controller.selectedTheme.value,
              onChanged: (value) {
                if (value != null) {
                  controller.changeTheme(value);
                  Get.back();
                }
              },
              activeColor: AppColors.primary,
            )),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    LocaleController controller,
    AppLocalizations l10n,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(l10n.settings_language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇧🇷', style: TextStyle(fontSize: 24)),
              title: Text(l10n.settings_language_pt),
              onTap: () {
                controller.changeLocale(const Locale('pt', 'BR'));
                Get.back();
              },
            ),
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: Text(l10n.settings_language_en),
              onTap: () {
                controller.changeLocale(const Locale('en'));
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

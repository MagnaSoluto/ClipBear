import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🐻 ClipBear',
          style: AppTextStyles.headlineMedium(),
        ),
        actions: [
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
                'Olá! 👋',
                style: AppTextStyles.displayMedium(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              SizedBox(height: AppDimensions.space2),
              Text(
                'Bem-vindo ao ClipBear Flutter!',
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
                                  'Sua Atividade Hoje',
                                  style: AppTextStyles.titleLarge(),
                                ),
                                SizedBox(height: AppDimensions.space1),
                                Text(
                                  '0 sugestões recebidas',
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
                            label: 'Aceitas',
                            value: '0',
                            color: AppColors.success,
                          ),
                          _buildStatItem(
                            icon: Icons.cancel_outlined,
                            label: 'Rejeitadas',
                            value: '0',
                            color: AppColors.error,
                          ),
                          _buildStatItem(
                            icon: Icons.schedule,
                            label: 'Adiadas',
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
                        '🎉 Projeto Flutter Iniciado!',
                        style: AppTextStyles.headlineSmall(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.space3),
                      Text(
                        'O ClipBear foi modernizado com Flutter! Agora com design Material 3, animações fluidas e suporte cross-platform.',
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
                      label: const Text('Começar Tour'),
                    ),
                  ),
                  SizedBox(width: AppDimensions.space3),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Show about
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Sobre'),
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
}

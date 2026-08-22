import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/models/onboarding_page_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageModel page;
  final Animation<double> animation;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Emoji Hero
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: AppDimensions.avatarHero,
                      height: AppDimensions.avatarHero,
                      decoration: BoxDecoration(
                        gradient: _getGradient(),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _getGradient()
                                .colors
                                .first
                                .withValues(alpha: 0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          page.emoji,
                          style: TextStyle(
                            fontSize: AppDimensions.space7,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: AppDimensions.space6),

              // Title
              Text(
                page.title,
                style: AppTextStyles.displayMedium(),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppDimensions.space2),

              // Subtitle
              Text(
                page.subtitle,
                style: AppTextStyles.titleMedium(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppDimensions.space5),

              // Description
              Text(
                page.description,
                style: AppTextStyles.bodyLarge(),
                textAlign: TextAlign.center,
              ),

              // Bullet Points
              if (page.bulletPoints.isNotEmpty) ...[
                SizedBox(height: AppDimensions.space5),
                ...page.bulletPoints.asMap().entries.map((entry) {
                  final index = entry.key;
                  final point = entry.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 600 + (index * 100)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.space2,
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: AppDimensions.space4),
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: AppDimensions.iconMedium,
                                ),
                                SizedBox(width: AppDimensions.space3),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: AppTextStyles.bodyMedium(),
                                  ),
                                ),
                                SizedBox(width: AppDimensions.space4),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    switch (page.type) {
      case OnboardingPageType.welcome:
        return AppColors.primaryGradient;
      case OnboardingPageType.info:
        return AppColors.secondaryGradient;
      case OnboardingPageType.permissions:
        return AppColors.tinkerGradient;
      case OnboardingPageType.completion:
        return AppColors.successGradient;
    }
  }
}

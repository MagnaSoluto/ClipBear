import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_widget.dart';
import '../widgets/onboarding_progress_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => controller.currentPage.value > 0
                      ? TextButton.icon(
                          onPressed: controller.previousPage,
                          icon: const Icon(Icons.arrow_back),
                          label: Text(l10n.common_back),
                        )
                      : const SizedBox()),
                  TextButton(
                    onPressed: controller.skipOnboarding,
                    child: Text(
                      l10n.onboarding_skipAll,
                      style: AppTextStyles.labelLarge(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress Indicator
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
              ),
              child: Obx(() => OnboardingProgressIndicator(
                    currentPage: controller.currentPage.value,
                    totalPages: controller.pages.length,
                  )),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    page: controller.pages[index],
                    animation: _animation,
                  );
                },
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                children: [
                  // Linear Progress Bar
                  Obx(() {
                    final progress = controller.getProgress();
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: progress),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: AppDimensions.space1,
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  SizedBox(height: AppDimensions.space4),

                  // Next/Get Started Button
                  Obx(() {
                    final isLast = controller.isLastPage.value;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.nextPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLast
                                  ? l10n.onboarding_getStarted
                                  : l10n.common_next,
                            ),
                            SizedBox(width: AppDimensions.space2),
                            Icon(
                              isLast ? Icons.check : Icons.arrow_forward,
                              size: AppDimensions.iconMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

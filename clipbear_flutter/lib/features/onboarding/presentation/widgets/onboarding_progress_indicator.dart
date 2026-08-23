import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class OnboardingProgressIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingProgressIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.space1,
          ),
          width: currentPage == index
              ? AppDimensions.space5
              : AppDimensions.space2,
          height: AppDimensions.space2,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
      ),
    );
  }
}

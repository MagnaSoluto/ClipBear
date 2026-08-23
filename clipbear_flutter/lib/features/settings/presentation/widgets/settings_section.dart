import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.space2,
            bottom: AppDimensions.space2,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AppDimensions.iconSmall,
                color: AppColors.primary,
              ),
              SizedBox(width: AppDimensions.space2),
              Text(
                title,
                style: AppTextStyles.labelLarge(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

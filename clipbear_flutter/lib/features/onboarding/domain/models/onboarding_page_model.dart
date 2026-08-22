import 'package:equatable/equatable.dart';

/// Model for onboarding pages
class OnboardingPageModel extends Equatable {
  final String title;
  final String subtitle;
  final String description;
  final List<String> bulletPoints;
  final String emoji;
  final OnboardingPageType type;

  const OnboardingPageModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.emoji,
    this.bulletPoints = const [],
    this.type = OnboardingPageType.info,
  });

  @override
  List<Object?> get props => [
        title,
        subtitle,
        description,
        bulletPoints,
        emoji,
        type,
      ];
}

enum OnboardingPageType {
  welcome,
  info,
  permissions,
  completion,
}

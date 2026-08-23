import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/onboarding_page_model.dart';
import '../../../../core/localization/l10n/app_localizations.dart';

class OnboardingController extends GetxController {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final RxBool isLastPage = false.obs;

  List<OnboardingPageModel> pages = [];

  @override
  void onInit() {
    super.onInit();
    _loadPages();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void _loadPages() {
    final context = Get.context!;
    final l10n = AppLocalizations.of(context)!;

    pages = [
      OnboardingPageModel(
        title: l10n.onboarding_welcome_title,
        subtitle: l10n.onboarding_welcome_subtitle,
        description: l10n.onboarding_welcome_description,
        emoji: '🐻',
        type: OnboardingPageType.welcome,
      ),
      OnboardingPageModel(
        title: l10n.onboarding_privacy_title,
        subtitle: l10n.onboarding_privacy_subtitle,
        description: l10n.onboarding_privacy_description,
        emoji: '🔒',
        bulletPoints: [
          l10n.onboarding_privacy_point1,
          l10n.onboarding_privacy_point2,
          l10n.onboarding_privacy_point3,
          l10n.onboarding_privacy_point4,
        ],
        type: OnboardingPageType.info,
      ),
      OnboardingPageModel(
        title: l10n.onboarding_features_title,
        subtitle: l10n.onboarding_features_subtitle,
        description: l10n.onboarding_features_description,
        emoji: '🤖',
        bulletPoints: [
          l10n.onboarding_features_point1,
          l10n.onboarding_features_point2,
          l10n.onboarding_features_point3,
          l10n.onboarding_features_point4,
        ],
        type: OnboardingPageType.info,
      ),
      OnboardingPageModel(
        title: l10n.onboarding_permissions_title,
        subtitle: l10n.onboarding_permissions_subtitle,
        description: l10n.onboarding_permissions_description,
        emoji: '🔔',
        type: OnboardingPageType.permissions,
      ),
    ];
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    isLastPage.value = index == pages.length - 1;
  }

  void nextPage() {
    if (isLastPage.value) {
      completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompletedKey, true);
      
      // Navigate to home
      Get.offAllNamed('/home');
    } catch (e) {
      debugPrint('Error completing onboarding: $e');
    }
  }

  static Future<bool> hasCompletedOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      return false;
    }
  }

  double getProgress() {
    return (currentPage.value + 1) / pages.length;
  }
}

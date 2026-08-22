import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/locale_controller.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'services/storage_service.dart';
import 'core/localization/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Storage Service (Hive)
  await StorageService.instance.init();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize LocaleController
  Get.put(LocaleController());

  // Check onboarding status
  final hasCompletedOnboarding = 
      await OnboardingController.hasCompletedOnboarding();

  runApp(ClipBearApp(showOnboarding: !hasCompletedOnboarding));
}

class ClipBearApp extends StatelessWidget {
  final bool showOnboarding;

  const ClipBearApp({
    super.key,
    this.showOnboarding = true,
  });

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    
    return Obx(() => GetMaterialApp(
      title: 'ClipBear',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Localization
      locale: localeController.locale,
      fallbackLocale: const Locale('pt', 'BR'),
      supportedLocales: LocaleController.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Initial route based on onboarding status
      initialRoute: showOnboarding ? '/onboarding' : '/home',
      
      // Routes
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingPage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          transition: Transition.fadeIn,
        ),
      ],
      
      // GetX configuration
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for managing app locale
class LocaleController extends GetxController {
  static const String _localeKey = 'app_locale';
  
  final Rx<Locale> _locale = const Locale('pt', 'BR').obs;
  
  Locale get locale => _locale.value;
  
  /// Supported locales
  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('pt'),
    Locale('en'),
  ];
  
  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }
  
  /// Load saved locale from SharedPreferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocale = prefs.getString(_localeKey);
      
      if (savedLocale != null) {
        final parts = savedLocale.split('_');
        if (parts.length == 2) {
          _locale.value = Locale(parts[0], parts[1]);
        } else {
          _locale.value = Locale(parts[0]);
        }
        Get.updateLocale(_locale.value);
      } else {
        // Use device locale if available
        final deviceLocale = Get.deviceLocale;
        if (deviceLocale != null && _isSupportedLocale(deviceLocale)) {
          _locale.value = deviceLocale;
        }
      }
    } catch (e) {
      debugPrint('Error loading saved locale: $e');
    }
  }
  
  /// Change app locale
  Future<void> changeLocale(Locale newLocale) async {
    if (!_isSupportedLocale(newLocale)) {
      debugPrint('Locale $newLocale is not supported');
      return;
    }
    
    _locale.value = newLocale;
    Get.updateLocale(newLocale);
    
    await _saveLocale(newLocale);
  }
  
  /// Save locale to SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeString = locale.countryCode != null
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      await prefs.setString(_localeKey, localeString);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }
  
  /// Check if locale is supported
  bool _isSupportedLocale(Locale locale) {
    return supportedLocales.any(
      (l) => l.languageCode == locale.languageCode &&
             (l.countryCode == locale.countryCode || l.countryCode == null),
    );
  }
  
  /// Get locale display name
  String getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'pt':
        return '🇧🇷 Português';
      case 'en':
        return '🇺🇸 English';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
  
  /// Toggle between Portuguese and English
  Future<void> toggleLanguage() async {
    if (_locale.value.languageCode == 'pt') {
      await changeLocale(const Locale('en'));
    } else {
      await changeLocale(const Locale('pt', 'BR'));
    }
  }
  
  /// Check if current locale is Portuguese
  bool get isPortuguese => _locale.value.languageCode == 'pt';
  
  /// Check if current locale is English
  bool get isEnglish => _locale.value.languageCode == 'en';
}

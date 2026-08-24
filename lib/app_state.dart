import 'package:flutter/foundation.dart';

/// Estado global do app. Será substituído/estendido pelo export do FlutterFlow.
class ClipBearAppState extends ChangeNotifier {
  String currentLanguage = 'en';
  bool hasCompletedOnboarding = false;
  bool overlayEnabled = false;
  String tinkerState = 'idle';
  String intensity = 'basic';
  int dailySuggestionCount = 0;
  DateTime? snoozeUntil;

  bool get isSnoozed =>
      snoozeUntil != null && DateTime.now().isBefore(snoozeUntil!);

  int get maxSuggestionsPerDay {
    const hardCap = 5;
    final modeLimit = intensity == 'proactive' ? 4 : 2;
    return modeLimit < hardCap ? modeLimit : hardCap;
  }

  void setLanguage(String lang) {
    currentLanguage = lang;
    notifyListeners();
  }

  void setOverlayEnabled(bool enabled) {
    overlayEnabled = enabled;
    notifyListeners();
  }

  void setIntensity(String value) {
    intensity = value;
    notifyListeners();
  }

  void setSnoozeUntil(DateTime? until) {
    snoozeUntil = until;
    notifyListeners();
  }
}

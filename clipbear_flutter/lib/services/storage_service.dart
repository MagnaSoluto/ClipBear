import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _settingsBox = 'settings';
  static const String _suggestionsBox = 'suggestions';
  static const String _feedbackBox = 'feedback';
  static const String _statsBox = 'stats';

  static StorageService? _instance;
  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  StorageService._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();
      _initialized = true;
      debugPrint('✅ StorageService initialized');
    } catch (e) {
      debugPrint('❌ Error initializing StorageService: $e');
      rethrow;
    }
  }

  Future<Box<T>> _getBox<T>(String boxName) async {
    if (!_initialized) {
      await init();
    }
    
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  // Settings Box
  Future<Box> get settingsBox => _getBox(_settingsBox);

  Future<void> saveSetting(String key, dynamic value) async {
    final box = await settingsBox;
    await box.put(key, value);
    debugPrint('✅ Saved setting: $key = $value');
  }

  Future<T?> getSetting<T>(String key, {T? defaultValue}) async {
    try {
      final box = await settingsBox;
      return box.get(key, defaultValue: defaultValue) as T?;
    } catch (e) {
      debugPrint('❌ Error getting setting $key: $e');
      return defaultValue;
    }
  }

  Future<void> deleteSetting(String key) async {
    final box = await settingsBox;
    await box.delete(key);
    debugPrint('🗑️ Deleted setting: $key');
  }

  // Suggestions Box
  Future<Box<Map>> get suggestionsBox => _getBox(_suggestionsBox);

  Future<void> saveSuggestion(Map<String, dynamic> suggestion) async {
    final box = await suggestionsBox;
    final id = suggestion['id'] ?? DateTime.now().millisecondsSinceEpoch;
    await box.put(id.toString(), suggestion);
    debugPrint('✅ Saved suggestion: $id');
  }

  Future<List<Map<String, dynamic>>> getAllSuggestions() async {
    try {
      final box = await suggestionsBox;
      return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      debugPrint('❌ Error getting suggestions: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getSuggestion(String id) async {
    try {
      final box = await suggestionsBox;
      final suggestion = box.get(id);
      return suggestion != null ? Map<String, dynamic>.from(suggestion) : null;
    } catch (e) {
      debugPrint('❌ Error getting suggestion $id: $e');
      return null;
    }
  }

  Future<void> deleteSuggestion(String id) async {
    final box = await suggestionsBox;
    await box.delete(id);
    debugPrint('🗑️ Deleted suggestion: $id');
  }

  Future<List<Map<String, dynamic>>> getTodaySuggestions() async {
    final allSuggestions = await getAllSuggestions();
    final today = DateTime.now();
    
    return allSuggestions.where((suggestion) {
      final timestamp = suggestion['timestamp'] as int?;
      if (timestamp == null) return false;
      
      final suggestionDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return suggestionDate.year == today.year &&
             suggestionDate.month == today.month &&
             suggestionDate.day == today.day;
    }).toList();
  }

  // Feedback Box
  Future<Box<Map>> get feedbackBox => _getBox(_feedbackBox);

  Future<void> saveFeedback(Map<String, dynamic> feedback) async {
    final box = await feedbackBox;
    final id = feedback['id'] ?? DateTime.now().millisecondsSinceEpoch;
    await box.put(id.toString(), feedback);
    debugPrint('✅ Saved feedback: $id');
  }

  Future<List<Map<String, dynamic>>> getAllFeedback() async {
    try {
      final box = await feedbackBox;
      return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      debugPrint('❌ Error getting feedback: $e');
      return [];
    }
  }

  // Stats Box
  Future<Box> get statsBox => _getBox(_statsBox);

  Future<void> incrementStat(String key, {int by = 1}) async {
    final box = await statsBox;
    final current = box.get(key, defaultValue: 0) as int;
    await box.put(key, current + by);
    debugPrint('📊 Incremented stat: $key = ${current + by}');
  }

  Future<int> getStat(String key) async {
    try {
      final box = await statsBox;
      return box.get(key, defaultValue: 0) as int;
    } catch (e) {
      debugPrint('❌ Error getting stat $key: $e');
      return 0;
    }
  }

  Future<void> resetStat(String key) async {
    final box = await statsBox;
    await box.put(key, 0);
    debugPrint('🔄 Reset stat: $key');
  }

  Future<Map<String, int>> getTodayStats() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return {
      'accepted': await getStat('${today}_accepted'),
      'rejected': await getStat('${today}_rejected'),
      'postponed': await getStat('${today}_postponed'),
      'total': await getStat('${today}_total'),
    };
  }

  // Clear All Data
  Future<void> clearAll() async {
    try {
      if (Hive.isBoxOpen(_settingsBox)) {
        await Hive.box(_settingsBox).clear();
      }
      if (Hive.isBoxOpen(_suggestionsBox)) {
        await Hive.box(_suggestionsBox).clear();
      }
      if (Hive.isBoxOpen(_feedbackBox)) {
        await Hive.box(_feedbackBox).clear();
      }
      if (Hive.isBoxOpen(_statsBox)) {
        await Hive.box(_statsBox).clear();
      }
      debugPrint('🗑️ All data cleared');
    } catch (e) {
      debugPrint('❌ Error clearing data: $e');
      rethrow;
    }
  }

  // Export All Data
  Future<Map<String, dynamic>> exportAll() async {
    try {
      return {
        'settings': (await settingsBox).toMap(),
        'suggestions': (await suggestionsBox).toMap(),
        'feedback': (await feedbackBox).toMap(),
        'stats': (await statsBox).toMap(),
        'exportedAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('❌ Error exporting data: $e');
      rethrow;
    }
  }

  // Close all boxes
  Future<void> close() async {
    await Hive.close();
    _initialized = false;
    debugPrint('🔒 StorageService closed');
  }
}

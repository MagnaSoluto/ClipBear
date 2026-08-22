import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/tinker_avatar.dart';
import '../../../../services/storage_service.dart';

class HomeController extends GetxController {
  final Rx<TinkerState> avatarState = TinkerState.idle.obs;
  final RxInt suggestionsToday = 0.obs;
  final RxInt acceptedCount = 0.obs;
  final RxInt rejectedCount = 0.obs;
  final RxInt postponedCount = 0.obs;

  final _storage = StorageService.instance;

  @override
  void onInit() {
    super.onInit();
    _loadStats();
    _scheduleRandomExpressions();
  }

  Future<void> _loadStats() async {
    try {
      final stats = await _storage.getTodayStats();
      acceptedCount.value = stats['accepted'] ?? 0;
      rejectedCount.value = stats['rejected'] ?? 0;
      postponedCount.value = stats['postponed'] ?? 0;
      suggestionsToday.value = stats['total'] ?? 0;
    } catch (e) {
      debugPrint('Error loading stats: $e');
    }
  }

  void _scheduleRandomExpressions() {
    // Change avatar expression randomly for demo
    Future.delayed(const Duration(seconds: 5), () {
      if (!isClosed) {
        avatarState.value = TinkerState.waving;
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed) {
            avatarState.value = TinkerState.idle;
            _scheduleRandomExpressions();
          }
        });
      }
    });
  }

  Future<void> onSuggestionAccepted() async {
    acceptedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.happy;
    
    // Save to storage
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _storage.incrementStat('${today}_accepted');
    await _storage.incrementStat('${today}_total');
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }

  Future<void> onSuggestionRejected() async {
    rejectedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.thinking;
    
    // Save to storage
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _storage.incrementStat('${today}_rejected');
    await _storage.incrementStat('${today}_total');
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }

  Future<void> onSuggestionPostponed() async {
    postponedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.sleeping;
    
    // Save to storage
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _storage.incrementStat('${today}_postponed');
    await _storage.incrementStat('${today}_total');
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }

  void celebrateAchievement() {
    avatarState.value = TinkerState.celebrating;
    
    Future.delayed(const Duration(seconds: 3), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }
}

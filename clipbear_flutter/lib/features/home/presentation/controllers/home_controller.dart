import 'package:get/get.dart';
import '../../../../core/widgets/tinker_avatar.dart';

class HomeController extends GetxController {
  final Rx<TinkerState> avatarState = TinkerState.idle.obs;
  final RxInt suggestionsToday = 0.obs;
  final RxInt acceptedCount = 0.obs;
  final RxInt rejectedCount = 0.obs;
  final RxInt postponedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStats();
    _scheduleRandomExpressions();
  }

  Future<void> _loadStats() async {
    // TODO: Load from persistence
    suggestionsToday.value = 0;
    acceptedCount.value = 0;
    rejectedCount.value = 0;
    postponedCount.value = 0;
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

  void onSuggestionAccepted() {
    acceptedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.happy;
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }

  void onSuggestionRejected() {
    rejectedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.thinking;
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        avatarState.value = TinkerState.idle;
      }
    });
  }

  void onSuggestionPostponed() {
    postponedCount.value++;
    suggestionsToday.value++;
    avatarState.value = TinkerState.sleeping;
    
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

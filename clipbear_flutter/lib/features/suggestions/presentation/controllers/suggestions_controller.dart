import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/storage_service.dart';
import '../../../../services/notification_service.dart';
import '../../domain/models/suggestion_model.dart';
import '../../../home/presentation/controllers/home_controller.dart';

class SuggestionsController extends GetxController {
  final _storage = StorageService.instance;
  final _notifications = NotificationService.instance;

  final Rx<SuggestionModel?> currentSuggestion = Rx<SuggestionModel?>(null);
  final RxList<SuggestionModel> allSuggestions = <SuggestionModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    try {
      final suggestions = await _storage.getAllSuggestions();
      allSuggestions.value = suggestions
          .map((json) => SuggestionModel.fromJson(json))
          .toList();

      // Find the first pending suggestion
      final pending = allSuggestions.firstWhereOrNull(
        (s) => s.status == SuggestionStatus.pending,
      );
      currentSuggestion.value = pending;

      debugPrint('Loaded ${allSuggestions.length} suggestions');
    } catch (e) {
      debugPrint('Error loading suggestions: $e');
    }
  }

  Future<void> generateDemoSuggestion() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 800));

    final demoSuggestions = _getDemoSuggestions();
    final randomSuggestion = demoSuggestions[Random().nextInt(demoSuggestions.length)];

    final suggestion = SuggestionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: randomSuggestion['type'] as SuggestionType,
      title: randomSuggestion['title'] as String,
      description: randomSuggestion['description'] as String,
      emoji: randomSuggestion['emoji'] as String,
      reason: randomSuggestion['reason'] as String,
      createdAt: DateTime.now(),
      status: SuggestionStatus.pending,
    );

    await _storage.saveSuggestion(suggestion.toJson());
    allSuggestions.insert(0, suggestion);
    currentSuggestion.value = suggestion;

    // Show notification
    await _notifications.showSuggestionNotification(suggestion);

    isLoading.value = false;

    _showSnackbar(
      '✨ Nova sugestão',
      'Tinker tem uma ideia para você!',
      Colors.blue,
    );
  }

  Future<void> acceptSuggestion() async {
    final suggestion = currentSuggestion.value;
    if (suggestion == null) return;

    final updatedSuggestion = suggestion.copyWith(
      status: SuggestionStatus.accepted,
      respondedAt: DateTime.now(),
    );

    await _updateSuggestion(updatedSuggestion);

    // Update home stats
    try {
      final homeController = Get.find<HomeController>();
      homeController.onSuggestionAccepted();
    } catch (e) {
      debugPrint('HomeController not found: $e');
    }

    _showSnackbar(
      '✅ Aceita!',
      'Tinker está feliz que você gostou!',
      Colors.green,
    );

    _moveToNextSuggestion();
  }

  Future<void> rejectSuggestion() async {
    final suggestion = currentSuggestion.value;
    if (suggestion == null) return;

    final updatedSuggestion = suggestion.copyWith(
      status: SuggestionStatus.rejected,
      respondedAt: DateTime.now(),
    );

    await _updateSuggestion(updatedSuggestion);

    // Update home stats
    try {
      final homeController = Get.find<HomeController>();
      homeController.onSuggestionRejected();
    } catch (e) {
      debugPrint('HomeController not found: $e');
    }

    _showSnackbar(
      '👍 Tudo bem',
      'Tinker vai aprender com suas preferências',
      Colors.orange,
    );

    _moveToNextSuggestion();
  }

  Future<void> postponeSuggestion(Duration duration) async {
    final suggestion = currentSuggestion.value;
    if (suggestion == null) return;

    final postponedUntil = DateTime.now().add(duration);
    final updatedSuggestion = suggestion.copyWith(
      status: SuggestionStatus.postponed,
      postponedUntil: postponedUntil,
    );

    await _updateSuggestion(updatedSuggestion);

    // Update home stats
    try {
      final homeController = Get.find<HomeController>();
      homeController.onSuggestionPostponed();
    } catch (e) {
      debugPrint('HomeController not found: $e');
    }

    final minutes = duration.inMinutes;
    _showSnackbar(
      '⏰ Lembrete agendado',
      'Tinker vai te lembrar em $minutes minutos',
      Colors.purple,
    );

    _moveToNextSuggestion();
  }

  Future<void> _updateSuggestion(SuggestionModel updated) async {
    await _storage.saveSuggestion(updated.toJson());

    final index = allSuggestions.indexWhere((s) => s.id == updated.id);
    if (index != -1) {
      allSuggestions[index] = updated;
    }
  }

  void _moveToNextSuggestion() {
    final nextPending = allSuggestions.firstWhereOrNull(
      (s) => s.status == SuggestionStatus.pending,
    );
    currentSuggestion.value = nextPending;
  }

  void _showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  List<Map<String, dynamic>> _getDemoSuggestions() {
    return [
      {
        'type': SuggestionType.productivity,
        'emoji': '☕',
        'title': 'Hora de uma pausa',
        'description': 'Você está trabalhando há 2 horas. Que tal levantar e tomar um café?',
        'reason': 'Pausas regulares melhoram o foco e a produtividade',
      },
      {
        'type': SuggestionType.wellness,
        'emoji': '🧘',
        'title': 'Momento mindfulness',
        'description': '5 minutos de respiração consciente para recarregar as energias',
        'reason': 'Você não fez uma pausa nos últimos 90 minutos',
      },
      {
        'type': SuggestionType.learning,
        'emoji': '📚',
        'title': 'Leitura do dia',
        'description': 'Que tal ler aquele artigo que você salvou ontem?',
        'reason': 'Você tem 3 artigos salvos para ler',
      },
      {
        'type': SuggestionType.social,
        'emoji': '👋',
        'title': 'Mantenha contato',
        'description': 'Faz tempo que você não conversa com um amigo. Mande uma mensagem!',
        'reason': 'Relacionamentos precisam de atenção regular',
      },
      {
        'type': SuggestionType.creative,
        'emoji': '🎨',
        'title': 'Hora de criar',
        'description': 'Que tal dedicar 15 minutos para um hobby criativo?',
        'reason': 'Criatividade melhora o bem-estar mental',
      },
      {
        'type': SuggestionType.productivity,
        'emoji': '📝',
        'title': 'Revisar tarefas',
        'description': 'Dê uma olhada nas suas tarefas e priorize as 3 mais importantes',
        'reason': 'É hora de organizar seu dia',
      },
      {
        'type': SuggestionType.wellness,
        'emoji': '💧',
        'title': 'Hidrate-se',
        'description': 'Lembre-se de beber água regularmente!',
        'reason': 'Você não bebeu água na última hora',
      },
      {
        'type': SuggestionType.reminder,
        'emoji': '🌙',
        'title': 'Prepare-se para dormir',
        'description': 'Desligue as telas 30 minutos antes de dormir para melhorar o sono',
        'reason': 'Está ficando tarde e você tem compromissos amanhã',
      },
    ];
  }

  int get totalSuggestions => allSuggestions.length;
  int get acceptedCount =>
      allSuggestions.where((s) => s.status == SuggestionStatus.accepted).length;
  int get rejectedCount =>
      allSuggestions.where((s) => s.status == SuggestionStatus.rejected).length;
  int get postponedCount =>
      allSuggestions.where((s) => s.status == SuggestionStatus.postponed).length;
  double get acceptanceRate =>
      totalSuggestions > 0 ? acceptedCount / totalSuggestions : 0.0;
}

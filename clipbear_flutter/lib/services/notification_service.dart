import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../features/suggestions/domain/models/suggestion_model.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<bool> init() async {
    if (_isInitialized) return true;

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    try {
      final result = await _notifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _isInitialized = result ?? false;
      debugPrint('NotificationService initialized: $_isInitialized');
      return _isInitialized;
    } catch (e) {
      debugPrint('Failed to initialize NotificationService: $e');
      return false;
    }
  }

  Future<bool> requestPermissions() async {
    if (!_isInitialized) {
      await init();
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      
      final granted = await androidImplementation?.requestNotificationsPermission();
      debugPrint('Android notification permission: $granted');
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      
      final granted = await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('iOS notification permission: $granted');
      return granted ?? false;
    }

    return false;
  }

  Future<void> showSuggestionNotification(SuggestionModel suggestion) async {
    if (!_isInitialized) {
      debugPrint('NotificationService not initialized, cannot show notification');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'suggestions_channel',
      'Sugestões do Tinker',
      channelDescription: 'Notificações de sugestões do Tinker',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _notifications.show(
        suggestion.id.hashCode,
        '${suggestion.emoji ?? '💡'} ${suggestion.title}',
        suggestion.description,
        details,
        payload: suggestion.id,
      );
      debugPrint('Notification shown for suggestion: ${suggestion.id}');
    } catch (e) {
      debugPrint('Failed to show notification: $e');
    }
  }

  Future<void> cancelNotification(String suggestionId) async {
    await _notifications.cancel(suggestionId.hashCode);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // TODO: Navigate to suggestion detail
  }
}

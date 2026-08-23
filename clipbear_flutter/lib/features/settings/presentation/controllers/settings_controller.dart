import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import '../../../../services/storage_service.dart';

class SettingsController extends GetxController {
  final _storage = StorageService.instance;

  // Observables
  final RxBool notificationsEnabled = true.obs;
  final RxDouble notificationIntensity = 0.5.obs; // 0.0 = Basic, 1.0 = Proactive
  final RxString selectedTheme = 'system'.obs; // system, light, dark
  final RxBool quietHoursEnabled = false.obs;
  final RxString quietHoursStart = '22:00'.obs;
  final RxString quietHoursEnd = '08:00'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      notificationsEnabled.value = 
          await _storage.getSetting<bool>('notifications_enabled', defaultValue: true) ?? true;
      notificationIntensity.value = 
          await _storage.getSetting<double>('notification_intensity', defaultValue: 0.5) ?? 0.5;
      selectedTheme.value = 
          await _storage.getSetting<String>('theme', defaultValue: 'system') ?? 'system';
      quietHoursEnabled.value = 
          await _storage.getSetting<bool>('quiet_hours_enabled', defaultValue: false) ?? false;
      quietHoursStart.value = 
          await _storage.getSetting<String>('quiet_hours_start', defaultValue: '22:00') ?? '22:00';
      quietHoursEnd.value = 
          await _storage.getSetting<String>('quiet_hours_end', defaultValue: '08:00') ?? '08:00';
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> toggleNotifications(bool value) async {
    notificationsEnabled.value = value;
    await _storage.saveSetting('notifications_enabled', value);
  }

  Future<void> updateIntensity(double value) async {
    notificationIntensity.value = value;
    await _storage.saveSetting('notification_intensity', value);
  }

  Future<void> changeTheme(String theme) async {
    selectedTheme.value = theme;
    await _storage.saveSetting('theme', theme);
    
    // Update theme mode
    switch (theme) {
      case 'light':
        Get.changeThemeMode(ThemeMode.light);
        break;
      case 'dark':
        Get.changeThemeMode(ThemeMode.dark);
        break;
      case 'system':
      default:
        Get.changeThemeMode(ThemeMode.system);
        break;
    }
  }

  Future<void> toggleQuietHours(bool value) async {
    quietHoursEnabled.value = value;
    await _storage.saveSetting('quiet_hours_enabled', value);
  }

  Future<void> updateQuietHours(String start, String end) async {
    quietHoursStart.value = start;
    quietHoursEnd.value = end;
    await _storage.saveSetting('quiet_hours_start', start);
    await _storage.saveSetting('quiet_hours_end', end);
  }

  Future<void> exportData(BuildContext context) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final data = await _storage.exportAll();
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);
      
      Get.back(); // Close loading

      await Share.shareXFiles(
        [
          XFile.fromData(
            utf8.encode(jsonString),
            mimeType: 'application/json',
            name: 'clipbear_export_${DateTime.now().millisecondsSinceEpoch}.json',
          ),
        ],
        text: 'ClipBear Data Export',
      );

      _showSuccessSnackbar('Dados exportados com sucesso!');
    } catch (e) {
      Get.back(); // Close loading
      _showErrorSnackbar('Erro ao exportar dados: $e');
    }
  }

  Future<void> deleteAllData(BuildContext context) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirmar'),
        content: const Text(
          'Tem certeza que deseja apagar todos os dados? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Apagar Tudo'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        await _storage.clearAll();
        
        Get.back(); // Close loading
        _showSuccessSnackbar('Todos os dados foram apagados');
        
        // Reset settings to defaults
        await _loadSettings();
      } catch (e) {
        Get.back(); // Close loading
        _showErrorSnackbar('Erro ao apagar dados: $e');
      }
    }
  }

  String getIntensityLabel() {
    if (notificationIntensity.value < 0.33) {
      return 'Básico (1-2 por dia)';
    } else if (notificationIntensity.value < 0.67) {
      return 'Moderado (3-4 por dia)';
    } else {
      return 'Proativo (até 5 por dia)';
    }
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Sucesso',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Erro',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

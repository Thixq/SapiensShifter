import 'dart:async';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

class ZoneManager {
  static final CustomLogger _logger = CustomLogger('ZoneManager');

  static Future<void> runAppInZone(Future<void> Function() appMain) async {
    await runZonedGuarded<Future<void>>(
      appMain,
      (error, stackTrace) {
        _logger.error('Global hata yakalandı!', error, stackTrace);
      },
    );
  }
}

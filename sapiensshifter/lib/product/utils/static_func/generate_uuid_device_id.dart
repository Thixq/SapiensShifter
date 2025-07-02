import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

class GenerateUuidDeviceId {
  static Future<String> generateDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    String rawId;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      rawId =
          '${androidInfo.id}${androidInfo.model}${androidInfo.manufacturer}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      rawId = '${iosInfo.identifierForVendor}${iosInfo.name}${iosInfo.model}';
    } else {
      rawId = 'unknown_device';
    }

    return sha256.convert(utf8.encode(rawId)).toString();
  }
}

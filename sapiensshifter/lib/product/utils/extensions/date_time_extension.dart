// ignore_for_file: lines_longer_than_80_chars

extension SapiDateTimeExtension on DateTime {
  String? get ggmm {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }

  String? get hhmm {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

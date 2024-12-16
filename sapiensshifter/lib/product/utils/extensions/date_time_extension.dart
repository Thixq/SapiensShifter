extension SapiDateTimeExtension on DateTime {
  String get ggmm {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }
}

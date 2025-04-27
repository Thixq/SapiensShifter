// ignore_for_file: lines_longer_than_80_chars, library_private_types_in_public_api
import 'package:intl/intl.dart';

extension SapiDefaultDateTimeExtension on DateTime {
  _SapiDatetTimeExtension get sapiTimeExt => _SapiDatetTimeExtension(this);
}

extension SapiDateTimeExtension on DateTime? {
  _SapiDatetTimeExtension get sapiTimeExt => _SapiDatetTimeExtension(this);
}

final class _SapiDatetTimeExtension {
  _SapiDatetTimeExtension(DateTime? value) : _value = value;
  final DateTime? _value;

  String? get lastMessageTime {
    if (_value == null) return null;
    final now = DateTime.now();
    if (now.difference(_value).inDays == 0) {
      return DateFormat.Hm().format(_value);
    } else if (now.difference(_value).inDays == 1) {
      return 'Yesterday';
    } else if (now.difference(_value).inDays > 1 &&
        now.difference(_value).inDays < 7) {
      return DateFormat.EEEE().format(_value);
    } else if (now.difference(_value).inDays >= 7) {
      return DateFormat('dd MMMM yyyy').format(_value);
    }
    return null;
  }

  String? get ddmm {
    if (_value == null) return null;
    return DateFormat('dM').format(_value);
  }

  String? get hhmm {
    if (_value == null) return null;
    return DateFormat.Hm().format(_value);
  }
}

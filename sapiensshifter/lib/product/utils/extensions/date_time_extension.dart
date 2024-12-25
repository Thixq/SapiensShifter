// ignore_for_file: lines_longer_than_80_chars, library_private_types_in_public_api

extension SapiDefaultDateTimeExtension on DateTime {
  _SapiDatetTimeExtension get sapiTimeExt => _SapiDatetTimeExtension(this);
}

extension SapiDateTimeExtension on DateTime? {
  _SapiDatetTimeExtension get sapiTimeExt => _SapiDatetTimeExtension(this);
}

final class _SapiDatetTimeExtension {
  _SapiDatetTimeExtension(DateTime? value) : _value = value;
  final DateTime? _value;

  String? get ggmm {
    if (_value == null) return null;
    return '${_value.day.toString().padLeft(2, '0')}/${_value.month.toString().padLeft(2, '0')}';
  }

  String? get hhmm {
    if (_value == null) return null;
    return '${_value.hour.toString().padLeft(2, '0')}:${_value.minute.toString().padLeft(2, '0')}';
  }
}

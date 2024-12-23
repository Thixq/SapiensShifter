// ignore_for_file: camel_case_types, library_private_types_in_public_api

extension SapiStringExtension on String? {
  _sapiStringExtension get sapiExt => _sapiStringExtension(this);
}

extension SapiDefaultStringExtension on String {
  _sapiStringExtension get sapiExt => _sapiStringExtension(this);
}

final class _sapiStringExtension {
  _sapiStringExtension(String? value) : _value = value;
  final String? _value;

  String? maxCharacter(int maxChachter) {
    if (_value == null) return null;
    if (_value.length >= maxChachter) {
      return '${_value.substring(0, maxChachter)}...';
    }
    return _value;
  }
}

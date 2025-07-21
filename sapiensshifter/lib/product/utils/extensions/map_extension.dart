// ignore_for_file: library_private_types_in_public_api

import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/extensions/list_extension.dart';

extension SapiMapExtension<K, V> on Map<K, V> {
  _MapExtension<K, V> get sapiMapExt => _MapExtension<K, V>(this);
}

class _MapExtension<K, V> {
  _MapExtension(this._value);

  final Map<K, V> _value;

  Map<K, V> mapKeyTranslate({required LocalizationPathEnum path}) {
    final localizedMap = <K, V>{};
    final localizedKey =
        _value.keys.toList().sapListExt.listItemTranslate(basePath: path);
    for (var i = 0; i < _value.length; i++) {
      localizedMap[localizedKey[i]] = _value.values.toList()[i];
    }
    return localizedMap;
  }
}

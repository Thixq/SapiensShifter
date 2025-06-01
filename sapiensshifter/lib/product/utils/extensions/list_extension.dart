// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:sapiensshifter/product/utils/enums/localization_path_enum.dart';

extension ListExtension<T> on List<T> {
  _ListExtension<T> get sapListExt => _ListExtension(this);
}

extension NullableListExtension<T> on List<T>? {
  _ListExtension<T> get sapListExt => _ListExtension(this);
}

final class _ListExtension<T> {
  _ListExtension(this._value);

  final List<T>? _value;

  List<String> listItemTranslate({required LocalizationPathEnum basePath}) {
    if (_value is List<String>) {
      if (_value != null && _value.isNotEmpty) {
        return _value
            .map(
              (e) => '${basePath.basePath}.${e as String}'.tr(),
            )
            .toList();
      }
      return [];
    }
    throw ArgumentError(
      'The value of ${_value.runtimeType} is not a list of strings.',
    );
  }
}

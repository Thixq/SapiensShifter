// ignore_for_file: library_private_types_in_public_api

import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

extension SapiStringExtension on String? {
  _SapiStringExtension get sapiExt => _SapiStringExtension(this);
}

extension SapiDefaultStringExtension on String {
  _SapiStringExtension get sapiExt => _SapiStringExtension(this);
}

final class _SapiStringExtension {
  _SapiStringExtension(String? value) : _value = value;
  final String? _value;

  String orDefault(String defaultValue) => _value ?? defaultValue;

  String? maxCharacter(int maxChachter) {
    if (_value == null) return null;
    if (_value.length >= maxChachter) {
      return '${_value.substring(0, maxChachter)}...';
    }
    return _value;
  }

  String get priceSymbol => '$_value${LocaleKeys.price_symbol.tr()}';

  ///With the given [LocalizationPathEnum] you can use the localized text in
  ///[EasyLocalization] that is located in this file path.
  String textLocale(LocalizationPathEnum basePath) {
    if (_value != null) {
      return '${basePath.basePath}.$_value'.tr();
    }
    return LocaleKeys.null_value_null_name.tr();
  }

  String? textCut({required int chunkSize}) {
    if (_value == null || _value.isEmpty) {
      return _value;
    }
    return _value.replaceAllMapped(
      RegExp('.{$chunkSize}'),
      (match) => '${match.group(0)}\n',
    );
  }
}

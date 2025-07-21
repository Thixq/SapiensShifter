import 'package:easy_localization/easy_localization.dart';
import 'package:sapiensshifter/core/localization/localization_codegen/locale_keys.g.dart';

class GenericValidator {
  static String? emptyValidator(
    String? value,
  ) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validate_generic_null_or_empty.tr();
    }
    return null;
  }
}

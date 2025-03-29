import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart'
    show LocaleKeys, StringExtension, StringTranslateExtension;

final class FormValidator {
  static String? emailValidator(String? text) {
    if (text == null || text.isEmpty) {
      return LocaleKeys.validate_email_empty_email.tr();
    }
    if (!text.ext.isValidEmail) {
      return LocaleKeys.validate_email_wrong_email_syntax.tr();
    }
    return null;
  }

  static String? passwordValidator(String? text) {
    if (text == null || text.isEmpty) {
      return LocaleKeys.validate_password_empty_passwrod.tr();
    }
    if (text.length < 8) {
      return LocaleKeys.validate_password_min_length.tr();
    }
    return null;
  }
}

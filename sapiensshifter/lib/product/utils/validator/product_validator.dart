import 'package:sapiensshifter/product/utils/enums/localization/product_validate_localization_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class ProductValidator {
  static String? emptyValidator(
    String? product, {
    required ProductValidationLocalizationKey localizationKey,
  }) {
    if (product == null || product.trim().isEmpty) {
      return localizationKey.validateKey.tr();
    }
    return null;
  }
}

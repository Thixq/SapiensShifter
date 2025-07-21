// ignore_for_file: sort_constructors_first

import 'package:sapiensshifter/core/localization/localization_codegen/locale_keys.g.dart';

enum ProductValidationLocalizationKey {
  emptyProduct(LocaleKeys.validate_product_form_empty_product),
  emptyProductDesc(LocaleKeys.validate_product_form_empty_product_desc),
  emptyProductPrice(LocaleKeys.validate_product_form_empty_product_price),
  emptyProductCategory(LocaleKeys.validate_product_form_empty_product_category);

  final String validateKey;
  const ProductValidationLocalizationKey(this.validateKey);
}

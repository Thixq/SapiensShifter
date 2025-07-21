import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart'
    show LocaleKeys;

enum LocalizationPathEnum {
  category(LocaleKeys.category),

  options(LocaleKeys.options),

  priceRation(LocaleKeys.price_operations),

  branch(LocaleKeys.branchs);

  const LocalizationPathEnum(this.basePath);

  final String basePath;
}

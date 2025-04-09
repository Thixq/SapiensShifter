import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart'
    show LocaleKeys;

enum LocalizationPathEnum {
  category(LocaleKeys.category),

  options(LocaleKeys.options);

  const LocalizationPathEnum(this.basePath);

  final String basePath;
}

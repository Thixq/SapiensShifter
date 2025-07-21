import 'package:sapiensshifter/product/component/sapi_custom_drop_down/model/sapi_drop_down_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class SapiDropDownValidator {
  static String? emptyValidator<T>(SapiDropDownModel<T>? item) {
    if (item?.displayName == null || item!.displayName!.trim().isEmpty) {
      return LocaleKeys.validate_generic_null_or_empty.tr();
    }
    return null;
  }
}

import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class UnSupportedValueTypeException extends CustomException {
  UnSupportedValueTypeException(String valueType)
      : super(
          LocaleKeys.all_exception_local_cache_exception_un_supported_value
              .tr(namedArgs: {'valueType': valueType}),
        );
}

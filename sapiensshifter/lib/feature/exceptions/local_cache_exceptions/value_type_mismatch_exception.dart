import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class ValueTypeMismatchException extends CustomException {
  ValueTypeMismatchException(String key, String expectedType, String actualType)
      : super(
          LocaleKeys.all_exception_local_cache_exception_expected_type.tr(
            namedArgs: {
              'key': key,
              'expectedType': expectedType,
              'actualType': actualType,
            },
          ),
        );
}

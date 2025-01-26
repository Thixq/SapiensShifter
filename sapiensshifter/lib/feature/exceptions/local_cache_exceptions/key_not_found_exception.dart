import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class KeyNotFoundException extends CustomException {
  KeyNotFoundException(String key)
      : super(
          LocaleKeys.all_exception_local_cache_exception_not_found_key
              .tr(namedArgs: {'key': key}),
        );
}

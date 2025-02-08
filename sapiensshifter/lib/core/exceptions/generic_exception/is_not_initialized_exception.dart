import 'package:sapiensshifter/core/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class IsNotInitializedException extends CustomException {
  IsNotInitializedException({required String instanceName})
      : super(
          LocaleKeys.all_exception_generic_exception_is_not_initialized
              .tr(namedArgs: {'instance': instanceName}),
        );
}

import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class CanceledUserException extends CustomException {
  CanceledUserException()
      : super(
          LocaleKeys.all_exception_social_credential_exception_canceled_user
              .tr(),
        );
}

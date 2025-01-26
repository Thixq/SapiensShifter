import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class FailedCredentialException extends CustomException {
  FailedCredentialException({
    required String social,
    required String error,
  }) : super(
          LocaleKeys.all_exception_social_credential_exception_failed_credential
              .tr(namedArgs: {'social': social, 'error': error}),
        );
}

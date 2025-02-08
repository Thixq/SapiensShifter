import 'package:sapiensshifter/core/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class InvalidPathException extends CustomException {
  InvalidPathException()
      : super(
          LocaleKeys
              .all_exception_firebase_firestore_exception_invalid_path_exception
              .tr(),
        );
}

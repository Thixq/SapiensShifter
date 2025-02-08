import 'package:sapiensshifter/core/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class DocumentDataException extends CustomException {
  DocumentDataException({required String path})
      : super(
          LocaleKeys
              .all_exception_firebase_firestore_exception_document_data_exception
              .tr(namedArgs: {'path': path}),
        );
}

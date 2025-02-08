import 'package:sapiensshifter/core/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class BatchCommitException extends CustomException {
  BatchCommitException({required List<dynamic> docs})
      : super(
          LocaleKeys
              .all_exception_firebase_firestore_exception_batch_commit_exception
              .tr(namedArgs: {'failedDocs': docs.toString()}),
        );
}

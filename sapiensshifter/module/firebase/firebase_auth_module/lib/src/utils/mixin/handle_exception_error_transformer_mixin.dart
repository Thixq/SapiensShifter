import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../exception/exception.dart';

mixin HandleExceptionErrorTransformerMixin {
  BaseExceptionInterface handleFirebaseAuthException(
      FirebaseAuthException exception,
      [StackTrace? stackTrace]) {
    return ModuleFirebaseAuthException(
        code: exception.code, stackTrace: stackTrace);
  }
}

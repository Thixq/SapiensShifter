// utils/mixin/handle_exception_error_transformer_mixin.dart

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../exception/exception.dart';

part of '../firebase_auth_manager.dart';

mixin HandleExceptionErrorTransformerMixin {
  BaseExceptionInterface handleFirebaseAuthException(
    FirebaseAuthException exception, [
    StackTrace? stackTrace,
  ]) {
    return ModuleFirebaseAuthException(
      code: exception.code,
      stackTrace: stackTrace,
    );
  }
}

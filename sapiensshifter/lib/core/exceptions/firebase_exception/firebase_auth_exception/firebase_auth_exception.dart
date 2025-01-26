// ignore_for_file: prefer_constructors_over_static_methods

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/feature/exceptions/custom_exception_interface.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class FirebaseAuthCustomException extends CustomException {
  FirebaseAuthCustomException(super.message, [super.stackTrace]);

  /// Firebase hatalarını yönetmek için bir yardımcı metot
  static FirebaseAuthCustomException fromFirebaseAuthException(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'invalid-email':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_invalid_email.tr(),
        );
      case 'user-disabled':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_user_disabled.tr(),
        );
      case 'user-not-found':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_user_not_found.tr(),
        );
      case 'wrong-password':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_wrong_password.tr(),
        );
      case 'email-already-in-use':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_email_already_use
              .tr(),
        );
      case 'weak-password':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_weak_password.tr(),
        );
      case 'operation-not-allowed':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_operation_not_allowed
              .tr(),
        );
      case 'too-many-requests':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_too_many_requests
              .tr(),
        );
      case 'requires-recent-login':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_requires_recent_login
              .tr(),
        );
      case 'network-request-failed':
        return FirebaseAuthCustomException(
          LocaleKeys
              .all_exception_firebase_auth_exception_network_request_failed
              .tr(),
        );
      case 'user-token-expired':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_user_token_expired
              .tr(),
        );

      case 'invalid-photo-url':
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_firebase_auth_exception_invalid_photo_url
              .tr(),
        );

      default:
        return FirebaseAuthCustomException(
          LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': '${e.message}'}),
        );
    }
  }
}

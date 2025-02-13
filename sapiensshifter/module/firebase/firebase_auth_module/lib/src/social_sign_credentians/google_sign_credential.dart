import 'package:core/core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../exception/module_custom_credential_exception.dart';

final class GoogleSignCredential implements CredentialStrategyInterface {
  @override
  Future<CustomCredential> call() async {
    return handleAsyncOperation<CustomCredential, Exception>(
      () async {
        final googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          throw ModuleCustomCredentialException(code: 'canceled_user');
        }

        final googleAuth = await googleUser.authentication;

        return CustomCredential(
          providerId: 'google',
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      },
      errorTransformer: (error, [stackTrace]) =>
          ModuleCustomCredentialException(
        code: 'failed_credential',
        optionArgs: {'social': 'Google', 'error': error.toString()},
      ),
    );
  }
}

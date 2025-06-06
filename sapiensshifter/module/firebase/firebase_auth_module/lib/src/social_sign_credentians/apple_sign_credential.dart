import 'package:core/core.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../exception/module_custom_credential_exception.dart';

final class AppleSignCredential implements CredentialStrategyInterface {
  @override
  Future<CustomCredential> call() async {
    return handleAsyncOperation<CustomCredential, Exception>(
      () async {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        return CustomCredential(
          providerId: 'apple',
          accessToken: appleCredential.identityToken,
          idToken: appleCredential.authorizationCode,
        );
      },
      errorTransformer: (error, [stackTrace]) =>
          ModuleCustomCredentialException(
        code: 'failed_credential',
        optionArgs: {'social': 'Apple', 'error': error.toString()},
      ),
    );
  }
}

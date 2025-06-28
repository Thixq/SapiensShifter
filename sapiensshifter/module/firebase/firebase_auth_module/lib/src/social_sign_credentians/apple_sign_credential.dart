import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../exception/module_custom_credential_exception.dart';

final class AppleSignCredential implements CredentialStrategyInterface {
  String _generateNonce([int length = 32]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  @override
  Future<CustomCredential> call() async {
    final rawNonce = _generateNonce();

    final nonce = sha256.convert(utf8.encode(rawNonce)).toString();
    return handleAsyncOperation<CustomCredential, Exception>(
      () async {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );
        return CustomCredential(
          customField: {
            'appleFullPersonName': AppleFullPersonName(
              givenName: appleCredential.givenName,
              familyName: appleCredential.familyName,
            )
          },
          providerId: 'apple',
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode,
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

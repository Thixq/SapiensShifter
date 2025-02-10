import 'package:core/core.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AppleSignCredential implements CredentialStrategyInterface {
  @override
  Future<CustomCredential> call() async {
    try {
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
    } catch (e) {
      throw FailedCredentialException(social: 'Apple', error: e.toString());
    }
  }
}

import 'package:sapiensshifter/feature/exceptions/firebase_exception/firebase_auth_exception/social_credential_exception/index.dart';
import 'package:sapiensshifter/feature/interface/strategy_interface/credential_strategy_interface.dart';
import 'package:sapiensshifter/feature/model/custom_credential_model.dart';
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

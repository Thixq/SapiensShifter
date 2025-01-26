import 'package:google_sign_in/google_sign_in.dart';
import 'package:sapiensshifter/feature/exceptions/firebase_exception/firebase_auth_exception/social_credential_exception/index.dart';
import 'package:sapiensshifter/feature/interface/strategy_interface/credential_strategy_interface.dart';
import 'package:sapiensshifter/feature/model/custom_credential_model.dart';

final class GoogleSignCredential implements CredentialStrategyInterface {
  @override
  Future<CustomCredential> call() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw CanceledUserException();
      }

      final googleAuth = await googleUser.authentication;

      return CustomCredential(
        providerId: 'google',
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch (e) {
      throw FailedCredentialException(social: 'Google', error: e.toString());
    }
  }
}

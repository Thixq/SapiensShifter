import 'package:core/core.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

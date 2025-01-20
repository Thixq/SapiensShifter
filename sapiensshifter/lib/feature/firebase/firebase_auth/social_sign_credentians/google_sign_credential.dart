import 'package:google_sign_in/google_sign_in.dart';
import 'package:sapiensshifter/feature/interface/strategy_interface/credential_strategy_interface.dart';
import 'package:sapiensshifter/feature/model/custom_credential_model.dart';

final class GoogleSignCredential implements CredentialStrategyInterface {
  @override
  Future<CustomCredential> call() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled by the user.');
      }

      final googleAuth = await googleUser.authentication;

      return CustomCredential(
        providerId: 'google',
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch (e) {
      print('Google sign in failed: $e');
      throw Exception('Failed to sign in with Google: $e');
    }
  }
}

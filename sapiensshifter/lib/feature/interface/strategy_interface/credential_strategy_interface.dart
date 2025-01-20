import 'package:sapiensshifter/feature/model/custom_credential_model.dart';

abstract class CredentialStrategyInterface {
  Future<CustomCredential> call();
}

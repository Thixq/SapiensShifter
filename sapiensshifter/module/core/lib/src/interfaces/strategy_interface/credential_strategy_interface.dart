import 'package:core/src/models/custom_credential_model.dart';

abstract class CredentialStrategyInterface {
  Future<CustomCredential> call();
}

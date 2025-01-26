// ignore_for_file: one_member_abstracts

import 'package:sapiensshifter/core/model/custom_credential_model.dart';

abstract class CredentialStrategyInterface {
  Future<CustomCredential> call();
}

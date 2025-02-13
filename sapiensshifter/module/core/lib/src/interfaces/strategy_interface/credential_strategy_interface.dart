// ignore_for_file: one_member_abstracts

import 'package:core/src/models/custom_credential_model.dart';

/// An abstract interface for implementing credential retrieval strategies.
/// This interface defines a single method for fetching or generating
/// a [CustomCredential] using a specific strategy.
abstract class CredentialStrategyInterface {
  /// Executes the credential strategy to retrieve or generate a [CustomCredential].
  ///
  /// Returns:
  /// A [Future] that resolves to a [CustomCredential] object containing the
  /// required credentials (e.g., provider ID, access token, ID token).
  Future<CustomCredential> call();
}

/// Represents a custom credential used for signing in via third-party providers.
/// This class holds the provider ID, and optionally an access token and an ID token.
final class CustomCredential {
  /// Creates a [CustomCredential] instance with the specified parameters.
  ///
  /// Parameters:
  /// - [providerId]: The unique identifier of the authentication provider (e.g., 'google', 'facebook').
  /// - [accessToken]: An optional access token provided by the authentication provider.
  /// - [idToken]: An optional ID token provided by the authentication provider.
  const CustomCredential({
    required this.providerId,
    this.accessToken,
    this.idToken,
  });

  /// The unique identifier of the authentication provider.
  final String providerId;

  /// An optional access token provided by the authentication provider.
  final String? accessToken;

  /// An optional ID token provided by the authentication provider.
  final String? idToken;
}

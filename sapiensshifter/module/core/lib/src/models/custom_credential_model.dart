final class CustomCredential {
  const CustomCredential({
    required this.providerId,
    this.accessToken,
    this.customField,
    this.idToken,
    this.rawNonce,
  });
  final String providerId;
  final String? accessToken;
  final String? idToken;
  final String? rawNonce;
  final Map<String, dynamic>? customField;
}

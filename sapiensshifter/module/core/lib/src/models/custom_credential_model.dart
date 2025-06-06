final class CustomCredential {
  const CustomCredential({
    required this.providerId,
    this.accessToken,
    this.idToken,
  });

  final String providerId;

  final String? accessToken;

  final String? idToken;
}

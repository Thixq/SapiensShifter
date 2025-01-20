Future<T> handleAsyncOperation<T>(
  Future<T> Function() operation, {
  String? errorMessage,
}) async {
  try {
    return await operation();
  } catch (e) {
    throw Exception(errorMessage ?? 'Operation failed: $e');
  }
}

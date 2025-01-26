typedef ErrorTransformer = Exception Function(Object error);

Exception defaultErrorTransformer(Object error) {
  return Exception('An unexpected error occurred: $error');
}

Future<T> handleAsyncOperation<T>(
  Future<T> Function() operation, {
  Exception? predefinedException,
  ErrorTransformer? errorTransformer,
  void Function(Exception)? onError,
}) async {
  try {
    return await operation();
  } catch (error) {
    // Hata detaylarını loglamak için kullanılabilir
    final exception = predefinedException ??
        (errorTransformer != null
            ? errorTransformer(error)
            : defaultErrorTransformer(error));
    if (onError != null) {
      onError(exception);
    }
    throw exception;
  }
}

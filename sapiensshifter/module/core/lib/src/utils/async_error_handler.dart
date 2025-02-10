import '../interfaces/base_exception_interface.dart';

typedef ErrorTransformer<T> = BaseExceptionInterface Function(T error,
    [StackTrace? stackTrace]);

Future<T> handleAsyncOperation<T, E extends Exception>(
  Future<T> Function() operation, {
  ErrorTransformer<E>? errorTransformer,
}) async {
  try {
    return await operation();
  } catch (error, stackTrace) {
    if (errorTransformer != null) {
      throw errorTransformer(error as E, stackTrace);
    }
    // errorTransformer verilmemişse, gelen hatayı olduğu gibi yeniden fırlatıyoruz.
    rethrow;
  }
}

import '../interfaces/exception_interface/base_exception_interface.dart';

/// A function type that transforms an error of type [T] along with an optional
/// [StackTrace] into a [BaseExceptionInterface].
///
/// This allows you to convert a caught exception into a custom exception type
/// that implements [BaseExceptionInterface].
typedef ErrorTransformer<E extends Object?> = IBaseException Function(
  E error, [
  StackTrace? stackTrace,
]);

/// Executes an asynchronous [operation] and handles any exceptions that occur.
///
/// This function attempts to run the provided asynchronous [operation]. If an exception
/// is thrown during execution:
///
/// - If an [errorTransformer] is provided and the caught error is of type [E],
///   the error is transformed using the provided transformer function, and the transformed
///   exception is thrown.
/// - If no transformer is provided, or the error is not of the expected type [E],
///   the original exception is rethrown.
///
/// ### Type Parameters
/// - **T**: The type of the value returned by the [operation].
/// - **E**: The type of exception that is expected to be thrown by the [operation].
///
/// ### Parameters
/// - **operation**: A function that returns a [Future] of type [T]. This is the asynchronous
///   operation that will be executed.
/// - **errorTransformer**: An optional function that converts an error of type [E] (with an optional
///   [StackTrace]) into a [BaseExceptionInterface]. Use this to customize error handling and
///   exception transformation.
///
/// ### Returns
/// A [Future] that completes with the result of the [operation] if it executes successfully.
///
/// ### Throws
/// - A transformed exception, if [errorTransformer] is provided and the caught error is of type [E].
/// - The original exception, if [errorTransformer] is not provided or the error does not match [E].
Future<T> handleAsyncOperation<T, E extends Object>(
  Future<T> Function() operation, {
  ErrorTransformer<E>? errorTransformer,
}) async {
  try {
    return await operation();
  } catch (error, stackTrace) {
    // If an error transformer is provided and the caught error is of type [E],
    // transform the error before throwing it.
    if (errorTransformer != null && error is E) {
      throw errorTransformer(error, stackTrace);
    }
    // If no transformer is provided, rethrow the original error.
    rethrow;
  }
}

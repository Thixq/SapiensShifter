/// An abstract interface for performing operations on a local cache.
/// This interface provides methods to write, read, update, and delete cached data.
abstract class LocalCacheOperationInterface {
  /// Writes a value to the local cache using the provided key.
  ///
  /// Parameters:
  /// - [key]: A unique identifier for the value.
  /// - [value]: The value to be stored in the cache.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the write operation is successful, otherwise `false`.
  Future<bool> write<T>({required String key, required T value});

  /// Writes multiple key-value pairs to the local cache.
  ///
  /// Parameters:
  /// - [items]: A map containing key-value pairs to be stored in the cache.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the operation is successful, otherwise `false`.
  Future<bool> writeAll({required Map<String, dynamic> items});

  /// Retrieves a specific value from the local cache using the provided key.
  ///
  /// Parameters:
  /// - [key]: The key corresponding to the value to be retrieved.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [MapEntry] containing the key and its associated value of type [T].
  Future<MapEntry<String, T>> getValue<T>({required String key});

  /// Retrieves all key-value pairs stored in the local cache.
  ///
  /// Returns:
  /// - A [Future] that resolves to a map containing all entries in the cache.
  Future<Map<String, dynamic>> getAllValue();

  /// Deletes a value from the local cache using the specified key.
  ///
  /// Parameters:
  /// - [key]: The key corresponding to the value to be deleted.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the deletion was successful, otherwise `false`.
  Future<bool> delete({required String key});

  /// Updates an existing value in the local cache with a new value.
  ///
  /// Parameters:
  /// - [key]: The key corresponding to the value to be updated.
  /// - [newValue]: The new value to be set for the specified key.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the update was successful, otherwise `false`.
  Future<bool> updateValue({required String key, required dynamic newValue});
}

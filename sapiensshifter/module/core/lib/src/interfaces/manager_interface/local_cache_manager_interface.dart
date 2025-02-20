import 'package:core/src/interfaces/interface.dart';

/// An abstract interface for managing local cache operations.
/// Implementations of this interface are responsible for initializing and removing local cache data.
abstract class ILocalCacheManager {
  /// Creates a [LocalCacheManagerInterface] instance.
  ///
  /// The [path] parameter is optional and represents the file or storage path where the cache is located.
  const ILocalCacheManager({this.path, required this.cacheOperation});

  /// Initializes the local cache.
  ///
  /// This method should be implemented to handle any necessary setup or initialization
  /// required before the cache can be used.
  ///
  /// Returns a [Future] that completes when the initialization process is finished.
  Future<void> init();

  /// Removes the local cache.
  ///
  /// This method should be implemented to clear or delete the cache data.
  ///
  /// Returns a [Future] that resolves to `true` if the removal was successful, otherwise `false`.
  Future<bool> remove();

  /// The file or storage path where the local cache is stored.
  final String? path;
  final ILocalCacheOperation cacheOperation;
}

import 'package:core/src/interfaces/network_query_interface/network_query_interface.dart';
import 'package:core/src/models/base_model_interface.dart';

/// An abstract interface for performing operations on a network store for items of type [T].
/// The type [T] must extend [BaseModelInterface<T>], ensuring that it conforms to the required
/// model structure for network operations.
abstract class INetworkOperation {
  /// Retrieves a single item from the network store.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [key]: Optional. A unique identifier for the item to retrieve.
  ///
  /// Returns:
  /// A [Future] that resolves to an instance of [T] representing the retrieved item.
  Future<T> getItem<T extends IBaseModel<T>>(
      {required String path, String? key});

  /// Retrieves a list of items from the network store based on a query.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [key]: Optional. A key that might be used to narrow down the query.
  /// - [query]: Optional. An instance of [NetworkStoreQueryInterface] that provides
  ///   filtering, ordering, or limiting conditions for the query.
  ///
  /// Returns:
  /// A [Future] that resolves to a list of items of type [T] matching the query criteria.
  Future<List<T>> getItemsQuery<T extends IBaseModel<T>>({
    required String path,
    String? key,
    INetworkQuery? query,
  });

  /// Adds a new item to the network store.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [item]: The item of type [T] to be added.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the item was successfully added, otherwise `false`.
  Future<bool> addItem<T extends IBaseModel<T>>({
    required String path,
    required T item,
  });

  /// Adds multiple items to the network store.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [items]: A list of items of type [T] to be added.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if all items were successfully added, otherwise `false`.
  Future<bool> addAllItem<T extends IBaseModel<T>>(
      {required String path, required List<T> items});

  /// Updates specific fields of an existing item in the network store.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [value]: A map of key-value pairs representing the fields to update and their new values.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the update operation was successful, otherwise `false`.
  Future<bool> update({
    required String path,
    required Map<String, dynamic> value,
  });

  /// Replaces an existing item in the network store with a new item.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [item]: The new item of type [T] that will replace the existing item.
  /// - [key]: Optional. A unique identifier for the item to be replaced.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the replacement was successful, otherwise `false`.
  Future<bool> replaceItem<T extends IBaseModel<T>>({
    required String path,
    required T item,
    String? key,
  });

  /// Deletes an item from the network store.
  ///
  /// Parameters:
  /// - [path]: The location or collection path within the network store.
  /// - [key]: Optional. A unique identifier for the item to be deleted.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the deletion was successful, otherwise `false`.
  Future<bool> deleteItem({required String path, String? key});
}

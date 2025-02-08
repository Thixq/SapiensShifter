import 'package:sapiensshifter/core/interface/network_store_query/network_store_query_interface.dart';
import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';

abstract class NetworkStoreOperationInterface<
    T extends ProductBaseModelInterface<T>> {
  Future<T> getItem({required String path, String? key});
  Future<List<T>> getItemsQuery({
    required String path,
    String? key,
    NetworkStoreQueryInterface? query,
  });
  Future<bool> addItem({
    required String path,
    required T item,
  });
  Future<bool> addAllItem({required String path, required List<T> items});
  Future<bool> update({
    required String path,
    required Map<String, dynamic> value,
  });
  Future<bool> replaceItem({
    required String path,
    required T item,
    String? key,
  });
  Future<bool> deleteItem({required String path, String? key});
}

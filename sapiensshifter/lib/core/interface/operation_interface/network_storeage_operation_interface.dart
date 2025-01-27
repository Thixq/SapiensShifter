import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';

abstract class NetworkStoreageOperationInterface<
    T extends ProductBaseModelInterface<T>> {
  Future<T> getItem({required String path, required String queryKey});
  Future<T> getItemsQuery({required String key});
}

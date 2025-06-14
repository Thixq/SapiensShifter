import 'package:sapiensshifter/core/state/base/base_cubit.dart';

import 'package:sapiensshifter/product/models/product_model/product_model.dart';

mixin PriceIterableOperationMixin<T extends Object> on BaseCubit<T> {
  void syncListFromSet(
    Iterable<ProductModel> sourceList,
    Set<ProductModel> targetSet,
  ) {
    for (final user in sourceList) {
      if (targetSet.contains(user)) {
        final existingUser = targetSet.lookup(user);
        if (existingUser!.price != user.price) {
          targetSet
            ..remove(user)
            ..add(user);
        }
      } else {
        targetSet.add(user);
      }
    }
  }

  void syncListFromList(
    Iterable<ProductModel> sourceList,
    List<ProductModel> targetList,
  ) {
    for (final user in sourceList) {
      final itemIndex = targetList.indexOf(user);
      if (targetList.contains(user)) {
        final existingUser =
            targetList.firstWhere((element) => element == user);

        if (existingUser.price != user.price) {
          targetList[itemIndex] = user;
        }
      }
    }
  }
}

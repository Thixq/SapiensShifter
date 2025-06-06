import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';

mixin class PriceEditingMixin {
  ({List<ProductModel> mainChangeList, Set<ProductModel> selectedChangeList})
      findAndOperate({
    required double value,
    required PriceOperations operations,
    required List<ProductModel> mainList,
    required Set<ProductModel> selectedList,
  }) {
    final selecetedChangeList = <ProductModel>{};
    for (final item in mainList) {
      if (selectedList.contains(item)) {
        final itemIndex = mainList.indexOf(item);
        final changeItem = switch (operations) {
          PriceOperations.PLUS => item.copyWith(price: item.price! + value),
          PriceOperations.PERCENTAGE =>
            item.copyWith(price: item.price! + (item.price! * value))
        };
        selectedList.remove(item);
        selectedList.add(changeItem);
        mainList[itemIndex] = changeItem;
      }
    }
    return (mainChangeList: mainList, selectedChangeList: selecetedChangeList);
  }
}

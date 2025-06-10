import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';

class PriceEditing {
  static ({
    List<ProductModel> mainChangeList,
    Set<ProductModel> selectedChangeList
  }) findAndOperate({
    required double value,
    required PriceOperations operations,
    required List<ProductModel> mainList,
    required Set<ProductModel> selectedList,
  }) {
    final changeMainList = List<ProductModel>.from(mainList);
    final changeSelectedList = <ProductModel>{};
    for (final item in mainList) {
      if (selectedList.contains(item)) {
        final itemIndex = mainList.indexOf(item);
        final changeItem = switch (operations) {
          PriceOperations.PLUS => item.copyWith(price: item.price! + value),
          PriceOperations.PERCENTAGE =>
            item.copyWith(price: item.price! + (item.price! * value))
        };
        changeSelectedList.add(changeItem);
        changeMainList[itemIndex] = changeItem;
      }
    }
    return (
      mainChangeList: changeMainList,
      selectedChangeList: changeSelectedList
    );
  }
}

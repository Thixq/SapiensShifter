import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';

class PriceEditingFunc {
  static ChangePriceList findAndOperate({
    required double value,
    required Operations operations,
    required List<ProductModel> mainList,
    required List<ProductModel> selectedList,
  }) {
    final selecetedChangeList = <ProductModel>[];
    for (final item in mainList) {
      if (selectedList.contains(item)) {
        final itemIndex = mainList.indexOf(item);
        final changeItem = switch (operations) {
          Operations.PLUS => item.copyWith(price: item.price! + value),
          Operations.MULTIPLICATION => item.copyWith(price: item.price! * value)
        };
        selecetedChangeList.add(changeItem);
        mainList[itemIndex] = changeItem;
      }
    }
    return ChangePriceList(
      mainChangeList: mainList,
      selectedChangeList: selecetedChangeList,
    );
  }
}

class ChangePriceList {
  ChangePriceList({
    required this.mainChangeList,
    required this.selectedChangeList,
  });

  final List<ProductModel> mainChangeList;
  final List<ProductModel> selectedChangeList;
}

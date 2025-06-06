// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';
import 'package:sapiensshifter/product/utils/mixin/func/price_editing.dart';

void main() {
  final func = PriceEditingMixin();

  test(
    'find list item and apply math',
    () {
      final mockList = List.generate(
        10,
        (index) => ProductModel(
          id: '$index',
          productName: 'name: $index',
          price: index.toDouble(),
        ),
      );

      final selectItems = {
        mockList[0],
        mockList[3],
        mockList[4],
        mockList[6],
      };
      final result = func.findAndOperate(
        mainList: mockList,
        selectedList: selectItems,
        operations: PriceOperations.PERCENTAGE,
        value: .10,
      );
      expect(result.selectedChangeList.length, 4);
    },
  );
}

// ignore: constant_identifier_names

// ignore: one_member_abstracts

import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';

void main() {
  test(
    'allOptionsMapEntry Function',
    () {
      final milkOptions = ExtrasModel(
        id: '1',
        name: 'Milk Options',
        optionsList: {
          0.00: const ['Regular Milk', 'Lactose Free'],
          17.99: const ['Oat Milk', 'Almond Milk', 'Coconut Milk'],
        },
      );
      final result = milkOptions.allOptionsMapEntry;
      // ignore: avoid_print
      print(result);
    },
  );
}

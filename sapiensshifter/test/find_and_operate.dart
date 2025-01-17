// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'find list item and apply math',
    () {
      final mockList = List.generate(
        10,
        (index) =>
            Model(id: '$index', name: 'name: $index', price: index.toDouble()),
      );

      final selectItems = [
        mockList[0],
        mockList[3],
        mockList[4],
        mockList[6],
      ];
      final result = findAndOperate(
        mainList: mockList,
        selectedList: selectItems,
        operations: Operations.PLUS,
        value: 40,
      );
      log(result.toString());
    },
  );
}

List<Model> findAndOperate({
  required double value,
  required Operations operations,
  required List<Model> mainList,
  required List<Model> selectedList,
}) {
  final selecetedChangeList = <Model>[];
  for (final item in mainList) {
    if (selectedList.contains(item)) {
      final itemIndex = mainList.indexOf(item);
      final changeItem = switch (operations) {
        Operations.PLUS => item.copyWith(price: item.price + value),
        Operations.MULTIPLICATION => item.copyWith(price: item.price * value)
      };
      selecetedChangeList.add(changeItem);
      mainList[itemIndex] = changeItem;
    }
  }

  return selecetedChangeList;
}

// ignore: constant_identifier_names
enum Operations { PLUS, MULTIPLICATION }

// ignore: one_member_abstracts

@immutable
final class Model {
  const Model({required this.id, required this.name, required this.price});

  final String id;
  final String name;
  final double price;

  Model copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return Model(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  String toString() => 'MockModel(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/choice_chip_list.dart';

import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOptionsList extends StatelessWidget {
  const ShimmerOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SeparatorListWidget(
        separator: context.sized.emptySizedHeightBoxLow,
        children: [_item(context), _item(context), _item(context)],
      ),
    );
  }

  Widget _item(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [Colors.grey.shade400, Colors.white]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16.sp,
            width: 48.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.sized.mediumValue),
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
          ChoiceChipList(
            isWrap: true,
            options: const {
              'coffee': 'blabla',
              'coffeecoffeecoffee': 'blabla',
              'cortada': 'blabla',
              'su': 'blabla',
              'coffeecoffeecoffeecoffee': 'blabla',
            },
          ),
        ],
      ),
    );
  }
}

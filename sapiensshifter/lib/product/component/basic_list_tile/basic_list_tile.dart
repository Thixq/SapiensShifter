import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/model/basic_list_tile_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class BasicListTile extends StatelessWidget {
  const BasicListTile({required this.model, super.key});

  final BasicListTileModel model;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(context.sized.lowValue),
      color: context.general.colorScheme.tertiaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(context.sized.lowValue),
        onTap: model.onTap,
        child: Padding(
          padding: EdgeInsetsGeometry.all(context.sized.lowValue),
          child: Row(
            children: [
              Icon(model.icon),
              context.sized.emptySizedWidthBoxLow3x,
              Expanded(child: Text(model.title)),
            ],
          ),
        ),
      ),
    );
  }
}

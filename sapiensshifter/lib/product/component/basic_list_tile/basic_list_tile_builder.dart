// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/basic_list_tile.dart';

import 'package:sapiensshifter/product/component/basic_list_tile/model/basic_list_tile_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class BasicListTileBuilder extends StatelessWidget {
  const BasicListTileBuilder({
    required this.listTiles,
    super.key,
  });

  final List<BasicListTileModel> listTiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      addRepaintBoundaries: false,
      itemCount: listTiles.length,
      separatorBuilder: (context, index) =>
          context.sized.emptySizedHeightBoxLow,
      itemBuilder: (context, index) {
        return BasicListTile(
          model: listTiles[index],
        );
      },
    );
  }
}

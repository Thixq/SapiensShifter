import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key});

  String get logoPath => 'assets/logo/coffee_sapiens_logo.svg';

  @override
  Widget build(BuildContext context) {
    return SvgAssetBuilder(
      svgPath: logoPath,
      builderSize: Size(50.w, 50.h),
    );
  }
}

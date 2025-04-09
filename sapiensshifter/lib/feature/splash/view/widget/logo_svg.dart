import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/constant/image_path_constant.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgAssetBuilder(
      svgPath: ImagePathConstant.sapiensLogo,
      builderSize: Size(50.w, 50.h),
    );
  }
}

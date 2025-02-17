import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgAssetBuilder(
          svgPath: 'assets/logo/coffee_sapiens_logo.svg',
          builderSize: Size(50.w, 50.h),
        ),
      ),
    );
  }
}

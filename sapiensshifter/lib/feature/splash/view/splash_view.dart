import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception_handler/async_exception_handler.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final _logger = CustomLogger('Splash View');
  late final String a;

  @override
  Widget build(BuildContext context) {
    _logger.info('Splash start');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await asyncHandler(
            context: context,
            () async {
              await Future.delayed(
                const Duration(seconds: 2),
                () {
                  print(a);
                },
              );
            },
            onError: (error, [stackTrace]) {
              _logger.error(
                error.toString(),
                stackTrace: stackTrace,
              );
            },
          );
        },
      ),
      body: Center(
        child: SvgAssetBuilder(
          svgPath: 'assets/logo/coffee_sapiens_logo.svg',
          builderSize: Size(50.w, 50.h),
        ),
      ),
    );
  }
}

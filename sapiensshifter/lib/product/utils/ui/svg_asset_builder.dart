import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiensshifter/product/interface/utils_interface/i_svg_builder.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class SvgAssetBuilder extends SvgBuilder {
  const SvgAssetBuilder({
    super.key,
    super.svgPath,
    super.errorSvgPath,
    Size? builderSize,
  }) : super(
          builderSize: builderSize ?? const Size(24, 24),
        );

  Future<String> _loadSvg(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      // TODO(kaan): Custom exception ekle.
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildSvg;
  }

  Widget get _buildSvg {
    if (svgPath.ext.isNotNullOrNoEmpty) {
      return _buildSvgFuture(_loadSvg(svgPath!));
    }
    if (errorSvgPath.ext.isNotNullOrNoEmpty) {
      return _buildSvgFuture(_loadSvg(errorSvgPath!));
    }
    return _buildSizedBox(child: const Icon(Icons.error));
  }

  Widget _buildSvgFuture(Future<String> path) {
    return FutureBuilder<String>(
      future: path,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _buildSizedBox(child: const Icon(Icons.error));
            case ConnectionState.waiting:
              return _buildSizedBox(
                child: const CircularProgressIndicator.adaptive(),
              );
            case ConnectionState.active:
              return _buildSizedBox(
                child: const CircularProgressIndicator.adaptive(),
              );
            case ConnectionState.done:
              return _buildSizedBox(child: SvgPicture.string(snapshot.data!));
          }
        }
        return const Icon(Icons.error);
      },
    );
  }

  SizedBox _buildSizedBox({required Widget child}) {
    return SizedBox(
      height: builderSize.height,
      width: builderSize.width,
      child: child,
    );
  }
}

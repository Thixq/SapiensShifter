// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:sapiensshifter/feature/splash/view/splash_view.dart' as _i1;

/// generated route for
/// [_i1.SplashView]
class SplashRoute extends _i2.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({_i3.Key? key, List<_i2.PageRouteInfo>? children})
    : super(
        SplashRoute.name,
        args: SplashRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SplashRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i1.SplashView(key: args.key);
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key}';
  }
}

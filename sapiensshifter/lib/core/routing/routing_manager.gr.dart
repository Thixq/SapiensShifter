// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart' as _i1;
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart'
    as _i2;
import 'package:sapiensshifter/feature/splash/view/splash_view.dart' as _i3;

/// generated route for
/// [_i1.OnboardView]
class OnboardRoute extends _i4.PageRouteInfo<void> {
  const OnboardRoute({List<_i4.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.OnboardView();
    },
  );
}

/// generated route for
/// [_i2.SignInView]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute({List<_i4.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignInView();
    },
  );
}

/// generated route for
/// [_i3.SplashView]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashView();
    },
  );
}

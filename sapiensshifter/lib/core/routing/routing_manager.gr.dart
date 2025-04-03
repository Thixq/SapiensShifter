// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:sapiensshifter/feature/home/view/home_view.dart' as _i1;
import 'package:sapiensshifter/feature/menu/view/menu_view.dart' as _i2;
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart' as _i3;
import 'package:sapiensshifter/feature/sign/register/view/register_view.dart'
    as _i4;
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart'
    as _i5;
import 'package:sapiensshifter/feature/splash/view/splash_view.dart' as _i6;
import 'package:sapiensshifter/product/models/table_model.dart' as _i9;

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i7.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required int pageIndex,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(pageIndex: pageIndex, key: key),
         rawPathParams: {'pageIndex': pageIndex},
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => HomeRouteArgs(pageIndex: pathParams.getInt('pageIndex')),
      );
      return _i1.HomeView(pageIndex: args.pageIndex, key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.pageIndex, this.key});

  final int pageIndex;

  final _i8.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{pageIndex: $pageIndex, key: $key}';
  }
}

/// generated route for
/// [_i2.MenuView]
class MenuRoute extends _i7.PageRouteInfo<MenuRouteArgs> {
  MenuRoute({
    required _i9.TableModel table,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         MenuRoute.name,
         args: MenuRouteArgs(table: table, key: key),
         initialChildren: children,
       );

  static const String name = 'MenuRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MenuRouteArgs>();
      return _i2.MenuView(table: args.table, key: args.key);
    },
  );
}

class MenuRouteArgs {
  const MenuRouteArgs({required this.table, this.key});

  final _i9.TableModel table;

  final _i8.Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{table: $table, key: $key}';
  }
}

/// generated route for
/// [_i3.OnboardView]
class OnboardRoute extends _i7.PageRouteInfo<void> {
  const OnboardRoute({List<_i7.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.OnboardView();
    },
  );
}

/// generated route for
/// [_i4.RegisterView]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.RegisterView();
    },
  );
}

/// generated route for
/// [_i5.SignInView]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute({List<_i7.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignInView();
    },
  );
}

/// generated route for
/// [_i6.SplashView]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashView();
    },
  );
}

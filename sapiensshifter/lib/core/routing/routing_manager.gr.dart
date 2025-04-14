// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i13;
import 'package:sapiensshifter/feature/chat/view/chat_view.dart' as _i1;
import 'package:sapiensshifter/feature/home/view/home_view.dart' as _i2;
import 'package:sapiensshifter/feature/menu/view/menu_view.dart' as _i3;
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart' as _i4;
import 'package:sapiensshifter/feature/order_detail/view/order_detail_view.dart'
    as _i5;
import 'package:sapiensshifter/feature/shift/view/shift_view.dart' as _i7;
import 'package:sapiensshifter/feature/sign/register/view/register_view.dart'
    as _i6;
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart'
    as _i8;
import 'package:sapiensshifter/feature/splash/view/splash_view.dart' as _i9;
import 'package:sapiensshifter/feature/tables/view/tables_view.dart' as _i10;
import 'package:sapiensshifter/product/models/product_model.dart' as _i14;
import 'package:sapiensshifter/product/models/table_model.dart' as _i12;

/// generated route for
/// [_i1.ChatView]
class ChatRoute extends _i11.PageRouteInfo<void> {
  const ChatRoute({List<_i11.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatView();
    },
  );
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeView();
    },
  );
}

/// generated route for
/// [_i3.MenuView]
class MenuRoute extends _i11.PageRouteInfo<MenuRouteArgs> {
  MenuRoute({
    required _i12.TableModel table,
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         MenuRoute.name,
         args: MenuRouteArgs(table: table, key: key),
         initialChildren: children,
       );

  static const String name = 'MenuRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MenuRouteArgs>();
      return _i3.MenuView(table: args.table, key: args.key);
    },
  );
}

class MenuRouteArgs {
  const MenuRouteArgs({required this.table, this.key});

  final _i12.TableModel table;

  final _i13.Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{table: $table, key: $key}';
  }
}

/// generated route for
/// [_i4.OnboardView]
class OnboardRoute extends _i11.PageRouteInfo<void> {
  const OnboardRoute({List<_i11.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardView();
    },
  );
}

/// generated route for
/// [_i5.OrderDetailView]
class OrderDetailRoute extends _i11.PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    required _i14.ProductModel product,
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         OrderDetailRoute.name,
         args: OrderDetailRouteArgs(product: product, key: key),
         initialChildren: children,
       );

  static const String name = 'OrderDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>();
      return _i5.OrderDetailView(product: args.product, key: args.key);
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({required this.product, this.key});

  final _i14.ProductModel product;

  final _i13.Key? key;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i6.RegisterView]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterView();
    },
  );
}

/// generated route for
/// [_i7.ShiftView]
class ShiftRoute extends _i11.PageRouteInfo<void> {
  const ShiftRoute({List<_i11.PageRouteInfo>? children})
    : super(ShiftRoute.name, initialChildren: children);

  static const String name = 'ShiftRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.ShiftView();
    },
  );
}

/// generated route for
/// [_i8.SignInView]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute({List<_i11.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignInView();
    },
  );
}

/// generated route for
/// [_i9.SplashView]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashView();
    },
  );
}

/// generated route for
/// [_i10.TablesView]
class TablesRoute extends _i11.PageRouteInfo<void> {
  const TablesRoute({List<_i11.PageRouteInfo>? children})
    : super(TablesRoute.name, initialChildren: children);

  static const String name = 'TablesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.TablesView();
    },
  );
}

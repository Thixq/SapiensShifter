// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:sapiensshifter/feature/chat_preview/view/chat_preview_view.dart'
    as _i1;
import 'package:sapiensshifter/feature/chat_room/view/chat_room_view.dart'
    as _i2;
import 'package:sapiensshifter/feature/home/view/home_view.dart' as _i3;
import 'package:sapiensshifter/feature/menu/view/menu_view.dart' as _i4;
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart' as _i5;
import 'package:sapiensshifter/feature/order_detail/view/order_detail_view.dart'
    as _i6;
import 'package:sapiensshifter/feature/shift/view/shift_view.dart' as _i8;
import 'package:sapiensshifter/feature/sign/register/view/register_view.dart'
    as _i7;
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart'
    as _i9;
import 'package:sapiensshifter/feature/splash/view/splash_view.dart' as _i10;
import 'package:sapiensshifter/feature/tables/view/tables_view.dart' as _i11;
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart'
    as _i14;
import 'package:sapiensshifter/product/models/product_model/product_model.dart'
    as _i17;
import 'package:sapiensshifter/product/models/table_model/table_model.dart'
    as _i15;
import 'package:sapiensshifter/product/profile/profile.dart' as _i16;

/// generated route for
/// [_i1.ChatPreviewView]
class ChatPreviewRoute extends _i12.PageRouteInfo<void> {
  const ChatPreviewRoute({List<_i12.PageRouteInfo>? children})
    : super(ChatPreviewRoute.name, initialChildren: children);

  static const String name = 'ChatPreviewRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatPreviewView();
    },
  );
}

/// generated route for
/// [_i2.ChatRoomView]
class ChatRoomRoute extends _i12.PageRouteInfo<ChatRoomRouteArgs> {
  ChatRoomRoute({
    _i13.Key? key,
    String? chatId,
    _i14.ChatModel? chatModel,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ChatRoomRoute.name,
         args: ChatRoomRouteArgs(
           key: key,
           chatId: chatId,
           chatModel: chatModel,
         ),
         initialChildren: children,
       );

  static const String name = 'ChatRoomRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRoomRouteArgs>(
        orElse: () => const ChatRoomRouteArgs(),
      );
      return _i2.ChatRoomView(
        key: args.key,
        chatId: args.chatId,
        chatModel: args.chatModel,
      );
    },
  );
}

class ChatRoomRouteArgs {
  const ChatRoomRouteArgs({this.key, this.chatId, this.chatModel});

  final _i13.Key? key;

  final String? chatId;

  final _i14.ChatModel? chatModel;

  @override
  String toString() {
    return 'ChatRoomRouteArgs{key: $key, chatId: $chatId, chatModel: $chatModel}';
  }
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeView();
    },
  );
}

/// generated route for
/// [_i4.MenuView]
class MenuRoute extends _i12.PageRouteInfo<MenuRouteArgs> {
  MenuRoute({
    required _i15.TableModel table,
    required _i16.Profile currentUser,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         MenuRoute.name,
         args: MenuRouteArgs(table: table, currentUser: currentUser, key: key),
         initialChildren: children,
       );

  static const String name = 'MenuRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MenuRouteArgs>();
      return _i4.MenuView(
        table: args.table,
        currentUser: args.currentUser,
        key: args.key,
      );
    },
  );
}

class MenuRouteArgs {
  const MenuRouteArgs({
    required this.table,
    required this.currentUser,
    this.key,
  });

  final _i15.TableModel table;

  final _i16.Profile currentUser;

  final _i13.Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{table: $table, currentUser: $currentUser, key: $key}';
  }
}

/// generated route for
/// [_i5.OnboardView]
class OnboardRoute extends _i12.PageRouteInfo<void> {
  const OnboardRoute({List<_i12.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnboardView();
    },
  );
}

/// generated route for
/// [_i6.OrderDetailView]
class OrderDetailRoute extends _i12.PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    required _i17.ProductModel product,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         OrderDetailRoute.name,
         args: OrderDetailRouteArgs(product: product, key: key),
         initialChildren: children,
       );

  static const String name = 'OrderDetailRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>();
      return _i6.OrderDetailView(product: args.product, key: args.key);
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({required this.product, this.key});

  final _i17.ProductModel product;

  final _i13.Key? key;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i7.RegisterView]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute({List<_i12.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.RegisterView();
    },
  );
}

/// generated route for
/// [_i8.ShiftView]
class ShiftRoute extends _i12.PageRouteInfo<void> {
  const ShiftRoute({List<_i12.PageRouteInfo>? children})
    : super(ShiftRoute.name, initialChildren: children);

  static const String name = 'ShiftRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.ShiftView();
    },
  );
}

/// generated route for
/// [_i9.SignInView]
class SignInRoute extends _i12.PageRouteInfo<void> {
  const SignInRoute({List<_i12.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignInView();
    },
  );
}

/// generated route for
/// [_i10.SplashView]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashView();
    },
  );
}

/// generated route for
/// [_i11.TablesView]
class TablesRoute extends _i12.PageRouteInfo<void> {
  const TablesRoute({List<_i12.PageRouteInfo>? children})
    : super(TablesRoute.name, initialChildren: children);

  static const String name = 'TablesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.TablesView();
    },
  );
}

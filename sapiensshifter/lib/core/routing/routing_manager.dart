// ignore_for_file: strict_raw_type

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/product/constant/page_path_constant.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

@AutoRouterConfig(replaceInRouteName: RoutingManager._replaceRouteName)
class RoutingManager extends RootStackRouter {
  static const _replaceRouteName = 'View,Route';

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: PagePathConstant.root,
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(path: PagePathConstant.onboard, page: OnboardRoute.page),
        AutoRoute(path: PagePathConstant.signIn, page: SignInRoute.page),
        AutoRoute(path: PagePathConstant.register, page: RegisterRoute.page),
        AutoRoute(
          path: PagePathConstant.home,
          page: HomeRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: PagePathConstant.table,
              page: TablesRoute.page,
            ),
            AutoRoute(
              path: PagePathConstant.chat,
              page: ChatPreviewRoute.page,
            ),
            AutoRoute(path: PagePathConstant.shift, page: ShiftRoute.page),
          ],
        ),
        AutoRoute(
          path: PagePathConstant.chatRoom,
          page: ChatRoomRoute.page,
        ),
        AutoRoute(path: PagePathConstant.menu, page: MenuRoute.page),
        AutoRoute(
          path: PagePathConstant.orderDetail,
          page: OrderDetailRoute.page,
        ),
        AutoRoute(path: PagePathConstant.settings, page: SettingsRoute.page),
        AutoRoute(
          path: PagePathConstant.orderHistory,
          page: OrderHistoryRoute.page,
        ),
      ];
}

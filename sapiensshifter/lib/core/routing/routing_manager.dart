import 'package:auto_route/auto_route.dart';
import 'package:sapiensshifter/core/constant/page_path_constant.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';

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
      ];
}

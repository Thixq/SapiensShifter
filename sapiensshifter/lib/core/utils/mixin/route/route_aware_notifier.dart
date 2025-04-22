// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception/exceptions/general_exception.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/routing/model/route_aware_action_performer.dart';
import 'package:sapiensshifter/core/routing/routing_manager.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/core/utils/modal_route_dependency/model_route_dependency.dart';

mixin RouteAwareNotifierStateMixin<T extends StatefulWidget> on BaseState<T>
    implements RouteAware {
  bool _isRouteAwareSubscribed = false;
  PageRoute? _subscribedRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (this is! RouteAwareActionPerformer) {
      ErrorUtil.runWithErrorHandling(
        action: () {
          throw GeneralException(
            'is_not_initialized',
            optionArgs: {
              'instance': runtimeType.toString(),
            },
          );
        },
        errorHandler: ServiceErrorHandler(),
        fallbackValue: null,
      );
    }
    if (!_isRouteAwareSubscribed && this is RouteAwareActionPerformer) {
      final route = MyModalRoute.of(context);
      if (route is PageRoute) {
        _subscribedRoute = route; // Abone olunan rotayı sakla
        routeObserver.subscribe(this, _subscribedRoute!); // Abone ol
        _isRouteAwareSubscribed = true; // Bayrağı true yap
        print('RouteAwareNotifierMixin: $runtimeType Abone olundu.');
      }
    }
  }

  @override
  void dispose() {
    if (_isRouteAwareSubscribed && _subscribedRoute != null) {
      routeObserver.unsubscribe(this);
      print('RouteAwareNotifierMixin: $runtimeType Abonelikten çıkıldı.');
      _isRouteAwareSubscribed = false;
      _subscribedRoute = null;
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    if (this is RouteAwareActionPerformer) {
      (this as RouteAwareActionPerformer).onRoutePoppedNext();
    }
  }

  @override
  void didPush() {}
  @override
  void didPop() {}
  @override
  void didPushNext() {}
}

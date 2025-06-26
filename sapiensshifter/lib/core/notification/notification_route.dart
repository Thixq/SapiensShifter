import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/notification/notification_service.dart';
import 'package:sapiensshifter/core/routing/routing_manager.dart';

final RoutingManager _routing = RoutingManager();

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({required this.child, super.key});
  final Widget child;

  @override
  State<NotificationRoute> createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  @override
  void initState() {
    _setupNotificationRouter();

    super.initState();
  }

  void _setupNotificationRouter() {
    selectNotificationStream.stream.listen((String? routePath) {
      if (routePath != null && routePath.isNotEmpty) {
        _routing.pushPath(routePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

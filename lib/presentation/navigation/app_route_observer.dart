import 'package:flutter/material.dart';

class AppRouteObserver extends NavigatorObserver {
  static String? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    _setCurrentRoute(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _setCurrentRoute(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _setCurrentRoute(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _setCurrentRoute(Route? route) {
    if (route is PageRoute) {
      currentRoute = route.settings.name;
    }
  }
}

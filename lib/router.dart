import 'package:afet_takip/view/screens/login_screen.dart';
import 'package:afet_takip/view/screens/map_screen.dart';
import 'package:afet_takip/view/screens/undefined_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String landingRoute = "/landing";
  static const String mapRoute = "/map";
  static const String helpCenterDetailsRoute = "/help-center-details";
}

class RouteGenerator {
  Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // TODO
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // TODO
      case Routes.landingRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.mapRoute:
        return MaterialPageRoute(builder: (_) => MapScreen());
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

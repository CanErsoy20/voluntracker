import 'package:afet_takip/views/login_screen.dart';
import 'package:afet_takip/views/undefined_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginRoute = "/login";

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
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

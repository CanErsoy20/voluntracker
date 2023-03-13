import 'package:afet_takip/view/screens/create_help_center_screen.dart';
import 'package:afet_takip/view/screens/help_center_detail_screen.dart';
import 'package:afet_takip/view/screens/help_center_list_screen.dart';
import 'package:afet_takip/view/screens/login_screen.dart';
import 'package:afet_takip/view/screens/map_screen.dart';
import 'package:afet_takip/view/screens/undefined_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String landingRoute = "/landing";
  static const String mapRoute = "/map";
  static const String helpCenterList = "/help-center-list";
  static const String helpCenterDetail = "/help-center-details";
  static const String createHelpCenter = "/create-help-center";
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
      case Routes.helpCenterList:
        return MaterialPageRoute(builder: (_) => HelpCenterListScreen());
      case Routes.helpCenterDetail:
        return MaterialPageRoute(builder: (_) => HelpCenterDetailScreen());
      case Routes.createHelpCenter:
        return MaterialPageRoute(builder: (_) => CreateHelpCenterScreen());
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

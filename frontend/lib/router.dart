import 'package:afet_takip/view/screens/add_team_screen.dart';
import 'package:afet_takip/view/screens/create_help_center_screen.dart';
import 'package:afet_takip/view/screens/help_center_detail_screen.dart';
import 'package:afet_takip/view/screens/help_center_list_screen.dart';
import 'package:afet_takip/view/screens/landing_screen.dart';
import 'package:afet_takip/view/screens/login_screen.dart';
import 'package:afet_takip/view/screens/map_screen.dart';
import 'package:afet_takip/view/screens/sign_up_screen.dart';
import 'package:afet_takip/view/screens/undefined_screen.dart';
import 'package:afet_takip/view/screens/update_help_center_screen.dart';
import 'package:afet_takip/view/screens/help_center_volunteers_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String landingRoute = "/landing";
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String mapRoute = "/map";
  static const String helpCenterList = "/help-center-list";
  static const String helpCenterDetail = "/help-center-details";
  static const String helpCenterVolunteers = "/help-center-volunteers";
  static const String createHelpCenter = "/create-help-center";
  static const String updateHelpCenter = "/update-help-center";
  static const String addTeam = "/add-team";
}

class RouteGenerator {
  Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.landingRoute:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case Routes.mapRoute:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case Routes.helpCenterList:
        return MaterialPageRoute(builder: (_) => HelpCenterListScreen());
      case Routes.helpCenterDetail:
        return MaterialPageRoute(builder: (_) => HelpCenterDetailScreen());
      case Routes.createHelpCenter:
        return MaterialPageRoute(builder: (_) => CreateHelpCenterScreen());
      case Routes.updateHelpCenter:
        return MaterialPageRoute(builder: (_) => UpdateHelpCenterScreen());
      case Routes.addTeam:
        return MaterialPageRoute(builder: (_) => AddToTeamScreen());
      case Routes.helpCenterVolunteers:
        return MaterialPageRoute(builder: (_) => HelpCenterVolunteersScreen());
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

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
import 'package:afet_takip/view/screens/landing_page.dart';
import 'package:afet_takip/view/screens/profile_screen.dart';
import 'package:afet_takip/view/screens/contact_us_screen.dart';
import 'package:afet_takip/view/screens/email_verification_screen.dart';
import 'package:afet_takip/view/screens/about_us_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String landingRoute = "/landing";
  static const String landingPageRoute = "/landing-page";
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String mapRoute = "/map";
  static const String helpCenterList = "/help-center-list";
  static const String helpCenterDetail = "/help-center-details";
  static const String helpCenterVolunteers = "/help-center-volunteers";
  static const String createHelpCenter = "/create-help-center";
  static const String updateHelpCenter = "/update-help-center";
  static const String addTeam = "/add-team";
  static const String profile = "/profile";
  static const String contactUs = "/contact-us";
  static const String emailVerification = "/email-verification";
  static const String aboutUs = "/about-us";
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
      case Routes.landingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case Routes.emailVerification:
        return MaterialPageRoute(builder: (_) => EmailVerificationScreen());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUsScreen());
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

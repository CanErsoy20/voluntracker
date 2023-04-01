import 'package:voluntracker/view/screens/add_to_team_screen.dart';
import 'package:voluntracker/view/screens/create_help_center_screen.dart';
import 'package:voluntracker/view/screens/help_center_detail_screen.dart';
import 'package:voluntracker/view/screens/help_center_list_screen.dart';
import 'package:voluntracker/view/screens/login_screen.dart';
import 'package:voluntracker/view/screens/map_screen.dart';
import 'package:voluntracker/view/screens/my_team_screen.dart';
import 'package:voluntracker/view/screens/sign_up_screen.dart';
import 'package:voluntracker/view/screens/undefined_screen.dart';
import 'package:voluntracker/view/screens/update_help_center_screen.dart';
import 'package:voluntracker/view/screens/landing_page.dart';
import 'package:voluntracker/view/screens/profile_screen.dart';
import 'package:voluntracker/view/screens/contact_us_screen.dart';
import 'package:voluntracker/view/screens/email_verification_screen.dart';
import 'package:voluntracker/view/screens/about_us_screen.dart';
import 'package:voluntracker/view/screens/volunteer_teams_screen.dart';
import 'package:voluntracker/view/screens/welcome_screen.dart';
import 'package:voluntracker/view/screens/image_picker_screen.dart';
import 'package:voluntracker/view/screens/edit_profile_screen.dart';
import 'package:voluntracker/view/screens/change_password_screen.dart';
import 'package:voluntracker/view/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String landingRoute = "/landing";
  static const String welcomeScreenRoute = "/welcome-screen";
  static const String landingPageRoute = "/landing-page";
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String mapRoute = "/map";
  static const String helpCenterList = "/help-center-list";
  static const String helpCenterDetail = "/help-center-details";
  static const String volunteerTeams = "/help-center-volunteers";
  static const String createHelpCenter = "/create-help-center";
  static const String updateHelpCenter = "/update-help-center";
  static const String addToTeam = "/add-team";
  static const String profile = "/profile";
  static const String editProfile = "/edit-profile";
  static const String contactUs = "/contact-us";
  static const String emailVerification = "/email-verification";
  static const String aboutUs = "/about-us";
  static const String myTeam = "/my-team";
  static const String forgotPassword = "/forgot-password";
  static const String changePassword = "/change-password";
}

class RouteGenerator {
  Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.landingRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
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
      case Routes.addToTeam:
        return MaterialPageRoute(builder: (_) => AddToTeamScreen());
      case Routes.volunteerTeams:
        return MaterialPageRoute(builder: (_) => VolunteerTeamsScreen());
      case Routes.landingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case Routes.emailVerification:
        return MaterialPageRoute(builder: (_) => EmailVerificationScreen());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUsScreen());
        // return MaterialPageRoute(builder: (_) => ImagePickerScreen());
      case Routes.myTeam:
        return MaterialPageRoute(builder: (_) => MyTeamScreen());
      case Routes.welcomeScreenRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      default:
        return MaterialPageRoute(builder: (_) => UndefinedScreen());
    }
  }
}

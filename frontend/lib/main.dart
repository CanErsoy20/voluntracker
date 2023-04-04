import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:voluntracker/cubit/login/login_cubit.dart';
import 'package:voluntracker/cubit/sign_up/sign_up_cubit.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/services/auth_service.dart';
import 'package:voluntracker/services/help_center_service.dart';
import 'package:voluntracker/services/profile_service.dart';
import 'package:voluntracker/services/team_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/help_centers/help_center_cubit.dart';
import 'cubit/map/map_cubit.dart';
import 'cubit/profile/profile_cubit.dart';
import 'cubit/team/team_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RouteGenerator routeGenerator = RouteGenerator();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubit(),
        ),
        BlocProvider(
          create: (context) => HelpCenterCubit(HelpCenterService()),
        ),
        BlocProvider(create: (context) => SignUpCubit(AuthService())),
        BlocProvider(
            create: (context) => LoginCubit(AuthService())..checkPrefs()),
        BlocProvider(create: (context) => TeamCubit(TeamService())),
        BlocProvider(create: (context) => ProfileCubit(ProfileService()))
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
              scaffoldBackgroundColor: const Color.fromARGB(255, 16, 24, 33),
              tabBarTheme: TabBarTheme(
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(225, 75, 142, 178)),
              ),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 27, 40, 55))),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routeGenerator.getRoute,
          initialRoute: Routes.welcomeScreenRoute),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'firebase_options.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setupEnv();
  // setupNotifications();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}

Future setupEnv() async{
  await dotenv.load(fileName: ".env");
}

Future<void> setupNotifications() async {
  await Firebase.initializeApp(  
    options: DefaultFirebaseOptions.currentPlatform,
  );
   
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print('User granted permission: ${settings.authorizationStatus}'); 

  String? token = await messaging.getToken();
  
  print("Token: $token");

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was publi shed!');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
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

import 'package:afet_takip/cubit/login/login_cubit.dart';
import 'package:afet_takip/cubit/sign_up/sign_up_cubit.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/services/auth_service.dart';
import 'package:afet_takip/services/help_center_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/help_centers/help_center_cubit.dart';
import 'cubit/map/map_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
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
        BlocProvider(create: (context) => LoginCubit(AuthService()))
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
              scaffoldBackgroundColor: const Color.fromARGB(225, 16, 24, 33),
              tabBarTheme: TabBarTheme(
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(225, 75, 142, 178)),
              ),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(225, 27, 40, 55))),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routeGenerator.getRoute,
          initialRoute: Routes.loginRoute),
    );
  }
}

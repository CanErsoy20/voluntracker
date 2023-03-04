import 'package:afet_takip/router.dart';
import 'package:flutter/material.dart';

import 'views/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  RouteGenerator routeGenerator = RouteGenerator();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routeGenerator.getRoute,
        initialRoute: Routes.loginRoute);
  }
}

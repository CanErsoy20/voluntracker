import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<HelpCenterCubit>().getHelpCenters();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voluntracker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<HelpCenterCubit>().getHelpCenters().then(
                      (value) => Navigator.of(context)
                          .pushNamed(Routes.helpCenterList));
                },
                child: const Text("Go Help Center List")),
            ElevatedButton(
                onPressed: () {
                  context.read<HelpCenterCubit>().getHelpCenters().then(
                      (value) => Navigator.of(context)
                          .pushNamed(Routes.createHelpCenter));
                },
                child: const Text("Create Help Center Screen")),
            ElevatedButton(
                onPressed: () {
                  context.read<HelpCenterCubit>().getHelpCenters().then(
                      (value) => Navigator.of(context)
                          .pushNamed(Routes.updateHelpCenter));
                },
                child: const Text("Update Help Center Screen"))
          ],
        ),
      ),
    );
  }
}

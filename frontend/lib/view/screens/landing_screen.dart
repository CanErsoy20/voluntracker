import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_info.dart';
import '../../router.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<HelpCenterCubit>().getHelpCenters();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voluntracker"),
        centerTitle: true,
      ),
      endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
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
                  Navigator.of(context).pushNamed(Routes.createHelpCenter);
                },
                child: const Text("Create Help Center Screen")),
            ElevatedButton(
                onPressed: () {
                  context.read<HelpCenterCubit>().getMyCenter().then((value) =>
                      Navigator.of(context).pushNamed(Routes.updateHelpCenter));
                },
                child: const Text("Update Help Center Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.registerRoute);
                },
                child: const Text("Sign Up Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.loginRoute);
                },
                child: const Text("Login Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.helpCenterDetail);
                },
                child: const Text("Help Center Detail Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.helpCenterVolunteers);
                },
                child: const Text("Help Center Volunteers Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.addTeam);
                },
                child: const Text("Add Team Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.landingPageRoute);
                },
                child: const Text("Landing Page Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.profile);
                },
                child: const Text("Profile Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.contactUs);
                },
                child: const Text("Contact Us Screen")),
          ],
        ),
      ),
    );
  }
}

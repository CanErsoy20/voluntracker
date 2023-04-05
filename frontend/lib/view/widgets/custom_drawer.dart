import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../models/user/user_info.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    required this.loggedIn,
    super.key,
  });
  bool loggedIn;
  @override
  Widget build(BuildContext context) {
    String nameField = "Not Logged In";

    if (UserInfo.loggedUser != null) {
      nameField =
          "${UserInfo.loggedUser!.firstname} ${UserInfo.loggedUser!.surname}";
    }

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 41, 70, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileAvatar(
            url: UserInfo.loggedUser!.profileImageUrl,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(nameField),
          loggedIn
              ? const Divider(
                  thickness: 1,
                  color: Colors.white,
                  endIndent: 100,
                  indent: 100,
                )
              : const SizedBox.shrink(),
          loggedIn
              ? Text(UserInfo.loggedUser!.getHighestRole())
              : const SizedBox.shrink(),
          const SizedBox(
            height: 44,
          ),
          loggedIn
              ? DrawerComponent(
                  title: "My Profile",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profile);
                  },
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
          loggedIn
              ? const SizedBox.shrink()
              : DrawerComponent(
                  title: "Sign Up",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.registerRoute, (route) => false);
                  },
                  prefixIcon: const Icon(
                    Icons.app_registration_rounded,
                    color: Colors.white,
                  )),
          loggedIn
              ? const SizedBox.shrink()
              : DrawerComponent(
                  title: "Login",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginRoute, (route) => false);
                  },
                  prefixIcon: const Icon(
                    Icons.lock_open_sharp,
                    color: Colors.white,
                  )),
          DrawerComponent(
            title: "About Us",
            onTap: () {
              Navigator.of(context).pushNamed(Routes.aboutUs);
            },
            prefixIcon: const Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
          ),
          DrawerComponent(
            title: "Contact Us",
            onTap: () {
              Navigator.of(context).pushNamed(Routes.contactUs);
            },
            prefixIcon: const Icon(
              Icons.contact_support_outlined,
              color: Colors.white,
            ),
          ),
          loggedIn
              ? DrawerComponent(
                  title: "Exit",
                  onTap: () {
                    UserInfo.loggedUser = null;
                    UserInfo.tokens = null;
                    context.read<HelpCenterCubit>().myCenter = null;
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  prefixIcon: const Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class DrawerComponent extends StatelessWidget {
  DrawerComponent({
    required this.title,
    required this.onTap,
    required this.prefixIcon,
    super.key,
  });
  String title;
  void Function()? onTap;
  Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: const Border.symmetric(
                horizontal: BorderSide(color: Colors.black, width: 0.5)),
            color: Colors.grey[600]),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            prefixIcon,
            const SizedBox(
              width: 20,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

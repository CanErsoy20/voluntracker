import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

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
          ProfileAvatar(),
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
              ? Text("${UserInfo.loggedUser!.userRole![0].userRoleName}")
              : const SizedBox.shrink(),
          const SizedBox(
            height: 44,
          ),
          loggedIn
              ? DrawerComponent(
                  title: "My Profile",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profileRoute);
                  },
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
          DrawerComponent(
            title: "About Us",
            onTap: () {
              Navigator.of(context).pushNamed(Routes.aboutUsRoute);
            },
            prefixIcon: const Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
          ),
          DrawerComponent(
            title: "Contact Us",
            onTap: () {
              Navigator.of(context).pushNamed(Routes.contactUsRoute);
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

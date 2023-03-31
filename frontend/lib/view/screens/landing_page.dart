import 'package:afet_takip/models/user/user_info.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_menu_card.dart';
import 'package:afet_takip/view/widgets/user_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {

  final items = [
    {
      "title": "Help Center List",
      "icon": Icons.help,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.help,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": Routes.mapRoute,
    },
    {
      "title": "Create Help Center",
      "icon": Icons.help,
      "roles": ["Admin"],
      "route": Routes.createHelpCenter,
    },
    {
      "title": "Update Help Center",
      "icon": Icons.help,
      "roles": ["HelpCenterCoordinator", "Admin"],
      "route": Routes.updateHelpCenter,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": "/volunteer",
    },
    {
      "title": "My Help Center",
      "icon": Icons.help,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": Routes.helpCenterDetail,
    },
    {
      "title": "Contact Us",
      "icon": Icons.contact_mail,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": Routes.contactUs,
    },
    {
      "title": "About Us",
      "icon": Icons.info,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": Routes.aboutUs,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "roles": ["Volunteer", "VolunteerTeamLeader", "HelpCenterCoordinator", "Admin"],
      "route": "/settings",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voluntracker"),
        centerTitle: true,
      ),
      endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserBar(user: UserInfo.loggedUser!),
              // Put an input field here
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                children: List.generate(items.length, (index) {
                  return CustomMenuCard(
                      title: "${items[index]["title"]}",
                      icon: items[index]["icon"] as IconData,
                      route: "${items[index]["route"]}");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

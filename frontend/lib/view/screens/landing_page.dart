import 'package:afet_takip/models/user/user_info.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_menu_card.dart';
import 'package:afet_takip/view/widgets/user_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final adminCards = [
    {
      "title": "Help Center List",
      "icon": Icons.help,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.help,
      "route": Routes.mapRoute,
    },
    {
      "title": "Create Help Center",
      "icon": Icons.help,
      "route": Routes.createHelpCenter,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "route": "/volunteer",
    },
    {
      "title": "Contact Us",
      "icon": Icons.contact_mail,
      "route": Routes.contactUs,
    },
    {
      "title": "About Us",
      "icon": Icons.info,
      "route": Routes.aboutUs,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "route": "/settings",
    },
  ];

  final coordinatorCards = [
    {
      "title": "Help Center List",
      "icon": Icons.help,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.help,
      "route": Routes.mapRoute,
    },
    {
      "title": "My Teams",
      "icon": Icons.people,
      "route": Routes.helpCenterVolunteers,
    },
    {
      "title": "Update Help Center",
      "icon": Icons.help,
      "route": Routes.updateHelpCenter,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "route": "/volunteer",
    },
    {
      "title": "My Help Center",
      "icon": Icons.help,
      "route": Routes.helpCenterDetail,
    },
    {
      "title": "Contact Us",
      "icon": Icons.contact_mail,
      "route": Routes.contactUs,
    },
    {
      "title": "About Us",
      "icon": Icons.info,
      "route": Routes.aboutUs,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "route": "/settings",
    },
  ];

  final volunteerCards = [
    {
      "title": "Help Center List",
      "icon": Icons.help,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.help,
      "route": Routes.mapRoute,
    },
    {
      "title": "My Help Center",
      "icon": Icons.help,
      "route": Routes.helpCenterDetail,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "route": "/volunteer",
    },
    {
      "title": "Contact Us",
      "icon": Icons.contact_mail,
      "route": Routes.contactUs,
    },
    {
      "title": "About Us",
      "icon": Icons.info,
      "route": Routes.aboutUs,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "route": "/settings",
    }
  ];

  final teamLeaderCards = [];

  final items = [
    {
      "title": "Help Center List",
      "icon": Icons.help,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.help,
      "route": Routes.mapRoute,
    },
    {
      "title": "Create Help Center",
      "icon": Icons.help,
      "route": Routes.createHelpCenter,
    },
    {
      "title": "Update Help Center",
      "icon": Icons.help,
      "route": Routes.updateHelpCenter,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "route": "/volunteer",
    },
    {
      "title": "My Help Center",
      "icon": Icons.help,
      "route": Routes.helpCenterDetail,
    },
    {
      "title": "Contact Us",
      "icon": Icons.contact_mail,
      "route": Routes.contactUs,
    },
    {
      "title": "About Us",
      "icon": Icons.info,
      "route": Routes.aboutUs,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "route": "/settings",
    },
    {
      "title": "My Teams",
      "icon": Icons.people,
      "route": Routes.helpCenterVolunteers,
    }
  ];

  @override
  Widget build(BuildContext context) {
    var selectedCards = volunteerCards;

    if (UserInfo.loggedUser!.getHighestRole() == "Volunteer") {
    } else if (UserInfo.loggedUser!.getHighestRole() ==
        "HelpCenterCoordinator") {
      selectedCards = coordinatorCards;
    } else if (UserInfo.loggedUser!.getHighestRole() == "VolunteerTeamLeader") {
      selectedCards = volunteerCards;
    } else if (UserInfo.loggedUser!.getHighestRole() == "Admin") {
      selectedCards = adminCards;
    }
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
                children: List.generate(selectedCards.length, (index) {
                  return CustomMenuCard(
                      title: "${selectedCards[index]["title"]}",
                      icon: selectedCards[index]["icon"] as IconData,
                      route: "${selectedCards[index]["route"]}");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:voluntracker/models/user/user_info.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_menu_card.dart';
import 'package:voluntracker/view/widgets/user_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final adminCards = [
    {
      "title": "Help Center List",
      "icon": Icons.feed_outlined,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.location_on_outlined,
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
      "icon": Icons.feed_outlined,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.location_on_outlined,
      "route": Routes.mapRoute,
    },
    {
      "title": "My Teams",
      "icon": Icons.people,
      "route": Routes.volunteerTeams,
    },
    {
      "title": "Update Help Center",
      "icon": Icons.edit,
      "route": Routes.updateHelpCenter,
    },
    {
      "title": "Favorites",
      "icon": Icons.favorite,
      "route": "/volunteer",
    },
    {
      "title": "My Help Center",
      "icon": Icons.apartment_outlined,
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
      "icon": Icons.feed_outlined,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.location_on_outlined,
      "route": Routes.mapRoute,
    },
    {
      "title": "My Help Center",
      "icon": Icons.apartment_outlined,
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

  final teamLeaderCards = [
    {
      "title": "Help Center List",
      "icon": Icons.feed_outlined,
      "route": Routes.helpCenterList,
    },
    {
      "title": "Help Center Map",
      "icon": Icons.location_on_outlined,
      "route": Routes.mapRoute,
    },
    {
      "title": "My Help Center",
      "icon": Icons.apartment_outlined,
      "route": Routes.helpCenterDetail,
    },
    {
      "title": "My Team",
      "icon": Icons.help,
      "route": Routes.myTeam,
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

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedCards = volunteerCards;

    if (UserInfo.loggedUser!.getHighestRole() == "Volunteer") {
      selectedCards = volunteerCards;
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
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              UserBar(user: UserInfo.loggedUser!),
              // Put an input field here
              const SizedBox(
                height: 20,
              ),
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

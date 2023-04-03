import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
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
      "route": Routes.followed,
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
      "route": Routes.settings,
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
      "route": Routes.followed,
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
      "route": Routes.settings,
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
      "route": Routes.followed,
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
      "route": Routes.settings,
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
      "route": Routes.followed,
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
      "route": Routes.settings,
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
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
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Followed Help Centers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.followed);
                          },
                          child: const Text(
                            "See All (5)",
                          ))
                    ],
                  ),
                ),
                CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Flexible(
                                  child: Center(
                                    child: Text(
                                      "Help Center",
                                      style: TextStyle(color: Colors.black),
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Working Hours: 12:30 - 17:30",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Flexible(
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(text: "Currently: "),
                                        TextSpan(
                                            text: "Open",
                                            style:
                                                TextStyle(color: Colors.green))
                                      ],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          // TODO: seçilen center'la değiştir
                                          context
                                                  .read<HelpCenterCubit>()
                                                  .selectedCenter =
                                              context
                                                  .read<HelpCenterCubit>()
                                                  .helpCenterList![0];
                                          Navigator.pushNamed(
                                              context, Routes.helpCenterDetail);
                                        },
                                        child: const Text(
                                          "See Details",
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                    options: CarouselOptions(
                        aspectRatio: 5 / 2,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: 150)),
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
      ),
    );
  }
}

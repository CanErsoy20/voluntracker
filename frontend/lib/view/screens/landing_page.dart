import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/cubit/map/map_cubit.dart';
import 'package:voluntracker/models/user/user_info.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_menu_card.dart';
import 'package:voluntracker/view/widgets/user_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomMenuCard> allCards = [
      CustomMenuCard(
          title: "Help Center List",
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          icon: Icons.feed_outlined,
          onTap: () {
            context.read<HelpCenterCubit>().getHelpCenters();
            Navigator.pushNamed(context, Routes.helpCenterList);
          }),
      CustomMenuCard(
          title: "Help Center Map",
          icon: Icons.location_on_outlined,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          onTap: () {
            context.read<HelpCenterCubit>().getHelpCenters();
            context.read<MapCubit>().getCurrentLocation();
            Navigator.pushNamed(context, Routes.mapRoute);
          }),
      CustomMenuCard(
          title: "Create Help Center",
          icon: Icons.help,
          authList: const ["Admin"],
          onTap: () {
            Navigator.pushNamed(context, Routes.createHelpCenter);
          }),
      CustomMenuCard(
          title: "Followed Help Centers",
          icon: Icons.favorite,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          onTap: () {
            //context.read<HelpCenterCubit>().getHelpCenters();
            Navigator.pushNamed(context, Routes.followed);
          }),
      CustomMenuCard(
          title: "My Teams",
          icon: Icons.people,
          authList: const [
            "HelpCenterCoordinator",
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.volunteerTeams);
          }),
      CustomMenuCard(
          title: "My Help Center",
          icon: Icons.apartment_outlined,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
          ],
          onTap: () {
            context.read<HelpCenterCubit>().getMyCenter();
            Navigator.pushNamed(context, Routes.helpCenterDetail);
          }),
      CustomMenuCard(
          title: "Update My Help Center",
          icon: Icons.edit,
          authList: const [
            "HelpCenterCoordinator",
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.updateHelpCenter);
          }),
      CustomMenuCard(
          title: "My Team",
          icon: Icons.help,
          authList: const [
            "VolunteerTeamleader",
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.myTeam);
          }),
      CustomMenuCard(
          title: "Settings",
          icon: Icons.settings,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.settings);
          }),
      CustomMenuCard(
          title: "Contact Us",
          icon: Icons.contact_mail,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.contactUs);
          }),
      CustomMenuCard(
          title: "About Us",
          icon: Icons.info,
          authList: const [
            "Volunteer",
            "VolunteerTeamleader",
            "HelpCenterCoordinator",
            "Admin"
          ],
          onTap: () {
            Navigator.pushNamed(context, Routes.aboutUs);
          }),
    ];
    List<CustomMenuCard> adminCards = allCards
        .where((element) => element.authList.contains("Admin"))
        .toList();
    List<CustomMenuCard> volunteerCards = allCards
        .where((element) => element.authList.contains("Volunteer"))
        .toList();
    List<CustomMenuCard> volunteerTeamLeaderCards = allCards
        .where((element) => element.authList.contains("VolunteerTeamLeader"))
        .toList();
    List<CustomMenuCard> helpCenterCoordinatorCards = allCards
        .where((element) => element.authList.contains("HelpCenterCoordinator"))
        .toList();
    var selectedCards = volunteerCards;

    if (UserInfo.loggedUser!.getHighestRole() == "Volunteer") {
      selectedCards = volunteerCards;
    } else if (UserInfo.loggedUser!.getHighestRole() ==
        "HelpCenterCoordinator") {
      selectedCards = helpCenterCoordinatorCards;
    } else if (UserInfo.loggedUser!.getHighestRole() == "VolunteerTeamLeader") {
      selectedCards = volunteerTeamLeaderCards;
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
                                                  .allHelpCentersList![0];
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
                  children: selectedCards,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

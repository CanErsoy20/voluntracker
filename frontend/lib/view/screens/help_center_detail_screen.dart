import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/cubit/map/map_cubit.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../helper_functions.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_need_card.dart';
import '../widgets/custom_snackbars.dart';

class HelpCenterDetailScreen extends StatelessWidget {
  const HelpCenterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HelpCenterModel? myCenter;
    if (context.read<HelpCenterCubit>().selectedCenter != null) {
      myCenter = context.read<HelpCenterCubit>().selectedCenter;
    } else {
      myCenter = context.read<HelpCenterCubit>().myCenter;
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<HelpCenterCubit>().selectedCenter = null;
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Help Center Details"),
            ),
          ),
          endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
          body: myCenter == null
              ? Center(
                  child: NotFoundLottie(
                      title: "Help Center Not Found",
                      description:
                          "You are not assigned to a help center yet :("),
                )
              : BlocConsumer<HelpCenterCubit, HelpCenterState>(
                  listener: (context, state) {
                    if (state is HelpCenterSuccess) {
                      CustomSnackbars.successSnackbar(
                          context, state.title, state.description);
                    } else if (state is HelpCenterError) {
                      CustomSnackbars.errorSnackbar(
                          context, state.title, state.description);
                    }
                  },
                  builder: (context, state) {
                    return DefaultTabController(
                      length: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              myCenter!.name!,
                              style: const TextStyle(fontSize: 20),
                            ),
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${myCenter.contactInfo!.address}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  Text(
                                      "Last Updated At: ${HelperFunctions.formatDateToDate(myCenter.updatedAt!)} ${HelperFunctions.formatDateToTime(myCenter.updatedAt!)}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  Text(
                                      "Additional Info: ${myCenter.additionalInfo}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white))
                                ],
                              ),
                              trailing: UserInfo.loggedUser == null
                                  ? const SizedBox.shrink()
                                  : (UserInfo.loggedUser!.volunteer!
                                                  .followedCenters !=
                                              null &&
                                          UserInfo.loggedUser!.volunteer!
                                              .followedCenters!
                                              .any((element) =>
                                                  element.id! == myCenter!.id!))
                                      ? IconButton(
                                          onPressed: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .unfollowHelpCenter(
                                                    UserInfo.loggedUser!
                                                        .volunteer!.id!,
                                                    myCenter!.id!);
                                            context
                                                .read<HelpCenterCubit>()
                                                .getFollowedHelpCenters(UserInfo
                                                    .loggedUser!
                                                    .volunteer!
                                                    .id!);
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .followHelpCenter(
                                                    UserInfo.loggedUser!
                                                        .volunteer!.id!,
                                                    myCenter!.id!);
                                            context
                                                .read<HelpCenterCubit>()
                                                .getFollowedHelpCenters(UserInfo
                                                    .loggedUser!
                                                    .volunteer!
                                                    .id!);
                                          },
                                          icon: const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () {
                                      context
                                          .read<MapCubit>()
                                          .getCurrentLocation();
                                      context
                                              .read<MapCubit>()
                                              .initialCameraLocation =
                                          LatLng(myCenter!.location!.lat!,
                                              myCenter.location!.lon!);
                                      Navigator.pushNamed(
                                          context, Routes.mapRoute);
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.location_on,
                                              size: 18,
                                              color: Color.fromARGB(
                                                  225, 27, 40, 55),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "See On Map",
                                            style: TextStyle(
                                                fontSize: 15,
                                                // set text to bold
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    225, 27, 40, 55)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            ExpansionTile(
                                collapsedIconColor: Colors.white,
                                collapsedTextColor: Colors.white,
                                title: const Text("Time Details"),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Help Center Opens - Closes: ${HelperFunctions.formatDateToTime(myCenter.openCloseInfo!.start!)} - ${HelperFunctions.formatDateToTime(myCenter.openCloseInfo!.end!)}"),
                                  Text(
                                      "Busy Hours Start - End: ${HelperFunctions.formatDateToTime(myCenter.busiestHours!.start!)} - ${HelperFunctions.formatDateToTime(myCenter.busiestHours!.end!)}"),
                                ]),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SizedBox(
                                height: 50,
                                child: TabBar(
                                  indicatorPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                  tabs: [
                                    Tab(text: "Volunteer Needs"),
                                    Tab(text: "Supply Needs")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                myCenter.neededVolunteerList == null ||
                                        myCenter.neededVolunteerList!.isEmpty
                                    ? NotFoundLottie(
                                        title: "No Volunteer Needed",
                                        description:
                                            "Currently there is not any volunteer need at this help center")
                                    : _buildVolunteerNeeds(myCenter),
                                myCenter.neededSupplyList == null ||
                                        myCenter.neededSupplyList!.isEmpty
                                    ? NotFoundLottie(
                                        title: "No Supply Needed",
                                        description:
                                            "Currently there is not any supply need at this help center")
                                    : _buildSupplyNeeds(myCenter),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }

  Widget _buildVolunteerNeeds(HelpCenterModel currentCenter) {
    return currentCenter.neededVolunteerList!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: currentCenter.neededVolunteerList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
                child: CustomNeedCard(
                  backgroundColor:
                      currentCenter.neededVolunteerList![index].urgency == "Low"
                          ? Colors.green
                          : currentCenter.neededVolunteerList![index].urgency ==
                                  "Medium"
                              ? Colors.orange
                              : Colors.red,
                  needName: currentCenter
                      .neededVolunteerList![index].volunteerTypeName!,
                  needCategory: currentCenter
                      .neededVolunteerList![index].volunteerTypeCategory!,
                  quantity: currentCenter.neededVolunteerList![index].quantity!,
                  lastUpdatedAt:
                      currentCenter.neededVolunteerList![index].updatedAt!,
                  leading: Icon(
                    Icons.warning_amber_sharp,
                    color: currentCenter.neededVolunteerList![index].urgency ==
                            "Low"
                        ? Colors.green
                        : currentCenter.neededVolunteerList![index].urgency ==
                                "Medium"
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              );
            })
        : Text("No volunteer needed at the moment: ${currentCenter.updatedAt}");
  }

  Widget _buildSupplyNeeds(HelpCenterModel currentCenter) {
    return currentCenter.neededSupplyList!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: currentCenter.neededSupplyList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
                child: CustomNeedCard(
                    backgroundColor:
                        currentCenter.neededSupplyList![index].urgency == "Low"
                            ? Colors.green
                            : currentCenter.neededSupplyList![index].urgency ==
                                    "Medium"
                                ? Colors.orange
                                : Colors.red,
                    needName:
                        currentCenter.neededSupplyList![index].supplyTypeName!,
                    needCategory: currentCenter
                        .neededSupplyList![index].supplyTypeCategory!,
                    quantity: 8,
                    lastUpdatedAt:
                        currentCenter.neededSupplyList![index].updatedAt!),
              );
            })
        : Text("No supply needed at the moment: ${currentCenter.updatedAt}");
  }
}

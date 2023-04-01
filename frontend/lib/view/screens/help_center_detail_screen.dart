import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/cubit/map/map_cubit.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../helper_functions.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_need_card.dart';

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
              ? const Center(
                  child: Text("You are not assigned to a help center yet :("),
                )
              : DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Text(
                        myCenter.name!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${myCenter.contactInfo!.address}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            Text(
                                "Last Updated At: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(myCenter.updatedAt!))}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            Text("Additional Info: ${myCenter.additionalInfo}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white))
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                context.read<MapCubit>().getCurrentLocation();
                                context.read<MapCubit>().initialCameraLocation =
                                    LatLng(myCenter!.location!.lat!,
                                        myCenter.location!.lon!);
                                Navigator.pushNamed(context, Routes.mapRoute);
                              },
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 18,
                                        color: Color.fromARGB(225, 27, 40, 55),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "See On Map",
                                      style: TextStyle(
                                          fontSize: 15,
                                          // set text to bold
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(225, 27, 40, 55)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // TextButton(
                            //   style: TextButton.styleFrom(
                            //       backgroundColor: Colors.green),
                            //   onPressed: () {
                            //     // TODO: Send to help_center_volunteers_screen
                            //     // which is already defined in the routes
                            //     // but send the help center context.
                            //   },
                            //   child: RichText(
                            //     text: const TextSpan(
                            //       children: [
                            //         WidgetSpan(
                            //           child: Icon(
                            //             Icons.help,
                            //             size: 18,
                            //             color: Color.fromARGB(225, 27, 40, 55),
                            //           ),
                            //         ),
                            //         TextSpan(
                            //           text: "Show Volunteers and Teams",
                            //           style: TextStyle(
                            //               fontSize: 15,
                            //               // set text to bold
                            //               fontWeight: FontWeight.bold,
                            //               color: Color.fromARGB(225, 27, 40, 55)),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ]),
                      ExpansionTile(
                          collapsedTextColor: Colors.white,
                          title: const Text("Time Details"),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Help Center Opens - Closes: ${HelperFunctions.formatDateToTime(myCenter.openCloseInfo!.start!)} - ${HelperFunctions.formatDateToTime(myCenter.openCloseInfo!.end!)}"),
                            Text(
                                "Busy Hours Start - End: ${HelperFunctions.formatDateToTime(myCenter.busiestHours!.start!)} - ${HelperFunctions.formatDateToTime(myCenter.busiestHours!.end!)}"),
                          ]),
                      const SizedBox(
                        height: 50,
                        child: TabBar(
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                          tabs: [
                            Tab(text: "Volunteer Needs"),
                            Tab(text: "Supply Needs")
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          _buildVolunteerNeeds(myCenter),
                          _buildSupplyNeeds(myCenter)
                        ]),
                      ),
                    ],
                  ),
                )),
    );
  }

  Widget _buildVolunteerNeeds(HelpCenterModel currentCenter) {
    return currentCenter.neededVolunteerList!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: currentCenter.neededVolunteerList!.length,
            itemBuilder: (context, index) {
              return CustomNeedCard(
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
                // (currentCenter.volunteerCapacity! -
                //         currentCenter
                //             .neededVolunteerList![index].quantity!) /
                //     currentCenter.volunteerCapacity!,
                lastUpdatedAt:
                    currentCenter.neededVolunteerList![index].updatedAt!,
                leading: Icon(
                  Icons.warning_amber_sharp,
                  color:
                      currentCenter.neededVolunteerList![index].urgency == "Low"
                          ? Colors.green
                          : currentCenter.neededVolunteerList![index].urgency ==
                                  "Medium"
                              ? Colors.orange
                              : Colors.red,
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
              return CustomNeedCard(
                  backgroundColor:
                      currentCenter.neededSupplyList![index].urgency == "Low"
                          ? Colors.green
                          : currentCenter.neededSupplyList![index].urgency ==
                                  "Medium"
                              ? Colors.orange
                              : Colors.red,
                  needName: currentCenter
                      .neededSupplyList![index].supplyTypeCategory!,
                  needCategory: currentCenter
                      .neededSupplyList![index].supplyTypeCategory!,
                  quantity: 8,
                  lastUpdatedAt:
                      currentCenter.neededSupplyList![index].updatedAt!);
            })
        : Text("No supply needed at the moment: ${currentCenter.updatedAt}");
  }
}

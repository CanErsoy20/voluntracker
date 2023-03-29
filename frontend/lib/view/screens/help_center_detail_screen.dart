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
    HelpCenterModel currentCenter = context.read<HelpCenterCubit>().myCenter!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Help Center Details"),
          ),
        ),
        endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              // Image.asset(
              //   fit: BoxFit.fitWidth,
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height / 6,
              //   "assets/images/bilkent.jpg",
              // ),
              Text(
                currentCenter.name!,
                style: const TextStyle(fontSize: 20),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${currentCenter.contactInfo!.address}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white)),
                    Text(
                        "Last Updated At: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(currentCenter.updatedAt!))}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white)),
                    Text("Additional Info: ${currentCenter.additionalInfo}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    context.read<MapCubit>().getCurrentLocation();
                    context.read<MapCubit>().initialCameraLocation = LatLng(
                        currentCenter.location!.lat!,
                        currentCenter.location!.lon!);
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
                              color: Color.fromARGB(225, 27, 40, 55)),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    // TODO: Send to help_center_needs_screen
                    // which is already defined in the routes
                    // but send the help center context.
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.help,
                            size: 18,
                            color: Color.fromARGB(225, 27, 40, 55),
                          ),
                        ),
                        TextSpan(
                          text: "Show Needs",
                          style: TextStyle(
                              fontSize: 15,
                              // set text to bold
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(225, 27, 40, 55)),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              VolunteerList(
                volunteers: [
                  Volunteer(
                    id: 1,
                    userId: 123,
                    volunteerTypeName: 'Event Volunteer',
                    volunteerTypeCategory: 'Community Service',
                    image: 'https://example.com/images/volunteer.jpg',
                    volunteerTeamId: 456,
                    helpCenterId: null,
                    createdAt: '2022-01-01T10:00:00Z',
                    updatedAt: '2022-01-01T11:00:00Z',
                  ),
                  Volunteer(
                    id: 2,
                    userId: 456,
                    volunteerTypeName: 'Fundraising Volunteer',
                    volunteerTypeCategory: 'Fundraising',
                    image: 'https://example.com/images/volunteer2.jpg',
                    volunteerTeamId: 789,
                    helpCenterId: null,
                    createdAt: '2022-01-02T09:00:00Z',
                    updatedAt: '2022-01-02T10:30:00Z',
                  ),
                  Volunteer(
                    id: 3,
                    userId: 789,
                    volunteerTypeName: 'Help Center Volunteer',
                    volunteerTypeCategory: 'Community Service',
                    image: 'https://example.com/images/volunteer3.jpg',
                    volunteerTeamId: 123,
                    helpCenterId: 456,
                    createdAt: '2022-01-03T08:00:00Z',
                    updatedAt: '2022-01-03T09:45:00Z',
                  )
                ],
              ),
            ],
          ),
        ));
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

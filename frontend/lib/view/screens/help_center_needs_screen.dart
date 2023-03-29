import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/cubit/map/map_cubit.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../helper_functions.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_need_card.dart';

class HelpCenterNeedsScreen extends StatelessWidget {
  const HelpCenterNeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HelpCenterModel currentCenter = context.read<HelpCenterCubit>().myCenter!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Help Center Needs"),
          ),
        ),
        endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Text(
                currentCenter.name!,
                style: const TextStyle(fontSize: 20),
              ),
              ExpansionTile(
                  title: const Text("Time Details"),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Help Center Opens - Closes: ${HelperFunctions.formatDateToTime(currentCenter.openCloseInfo!.start!)} - ${HelperFunctions.formatDateToTime(currentCenter.openCloseInfo!.end!)}"),
                    Text(
                        "Busy Hours Start - End: ${HelperFunctions.formatDateToTime(currentCenter.busiestHours!.start!)} - ${HelperFunctions.formatDateToTime(currentCenter.busiestHours!.end!)}"),
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
                  _buildVolunteerNeeds(currentCenter),
                  _buildSupplyNeeds(currentCenter)
                ]),
              )
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

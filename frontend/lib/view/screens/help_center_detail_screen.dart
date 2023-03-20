import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/cubit/map/map_cubit.dart';
import 'package:afet_takip/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../helper_functions.dart';
import '../../models/help_center/help_center_model.dart';
import '../widgets/custom_need_card.dart';

class HelpCenterDetailScreen extends StatelessWidget {
  const HelpCenterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HelpCenterModel currentCenter =
        context.read<HelpCenterCubit>().selectedCenter!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(currentCenter.name!),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Image.asset(
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                "assets/images/bilkent.jpg",
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Adress: ${currentCenter.contactInfo!.address}"),
                    Text(
                        "Last Updated At: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(currentCenter.updatedAt!))}"),
                    Text("Additional Info: ${currentCenter.additionalInfo}")
                  ],
                ),
                subtitle: TextButton(
                    onPressed: () {
                      context.read<MapCubit>().getCurrentLocation();
                      context.read<MapCubit>().initialCameraLocation = LatLng(
                          currentCenter.location!.lat!,
                          currentCenter.location!.lon!);
                      Navigator.pushNamed(context, Routes.mapRoute);
                    },
                    child: const Text(
                      "See On Map",
                      style: TextStyle(color: Colors.green),
                    )),
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
              SizedBox(
                height: 50,
                child: TabBar(
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.blue,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue),
                  tabs: const [
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

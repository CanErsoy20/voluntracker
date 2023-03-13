import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/cubit/map/map_cubit.dart';
import 'package:afet_takip/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../models/help_center/help_center_model.dart';

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
                    child: const Text("See On Map")),
              ),
              ExpansionTile(
                  title: const Text("Time Details"),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Help Center Opens At: ${currentCenter.openCloseInfo!.start}"),
                    Text(
                        "Help Center Closes At: ${currentCenter.openCloseInfo!.end}"),
                    Text(
                        "Busy Hours Start: ${currentCenter.busiestHours!.start}"),
                    Text("Busy Hours End: ${currentCenter.busiestHours!.end}"),
                  ]),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                ),
                child: TabBar(
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue),
                  tabs: [
                    Row(
                      children: const [
                        Icon(Icons.person),
                        Text(
                          "Volunteer Needs",
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.archive_outlined),
                        Text("Supply Needs")
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade400,
                  child: TabBarView(children: [
                    _buildSupplyNeeds(context),
                    _buildSupplyNeeds(context)
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildSupplyNeeds(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.white,
              elevation: 10,
              child: ListTile(
                title: Text("Some example supply name"),
                subtitle: Padding(
                  padding: EdgeInsets.all(10),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2500,
                    percent: 0.8,
                    center: Text("80.0%"),
                    barRadius: Radius.circular(20),
                    progressColor: Colors.green,
                  ),
                ),
              ));
        });
  }
}

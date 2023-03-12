import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../cubit/map/map_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../../router.dart';

class HelpCenterListScreen extends StatelessWidget {
  const HelpCenterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center List"),
        centerTitle: true,
      ),
      body: BlocBuilder<HelpCenterCubit, HelpCenterState>(
        builder: (context, state) {
          if (state is HelpCenterDisplay) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<MapCubit>().getCurrentLocation();
                          Navigator.pushNamed(context, Routes.mapRoute);
                          context.read<MapCubit>().initialCameraLocation =
                              context.read<MapCubit>().currentLocation;
                        },
                        child: Text("Go To Map")),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: context
                              .read<HelpCenterCubit>()
                              .helpCenterList
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        HelpCenterModel currentCenter = context
                            .read<HelpCenterCubit>()
                            .helpCenterList![index];
                        return Card(
                          elevation: 5,
                          child: ExpansionTile(
                            title: Text(currentCenter.name!),
                            children: [
                              ListTile(
                                title: Text(
                                    "Adress: ${currentCenter.contactInfo!.address!}"),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .selectedCenter = currentCenter;
                                            Navigator.pushNamed(context,
                                                Routes.helpCenterDetail);
                                          },
                                          child: const Text("Show Details")),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                    .read<MapCubit>()
                                                    .initialCameraLocation =
                                                LatLng(
                                                    currentCenter
                                                        .location!.lat!,
                                                    currentCenter
                                                        .location!.lon!);
                                            context
                                                .read<MapCubit>()
                                                .getCurrentLocation();
                                            Navigator.of(context)
                                                .pushNamed(Routes.mapRoute);
                                          },
                                          child: const Text("See On Map"))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            );
          } else if (state is HelpCenterLoading) {
            return CircularProgressIndicator();
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}

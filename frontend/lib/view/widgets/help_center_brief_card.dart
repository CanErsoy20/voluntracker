import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/map/map_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../../router.dart';

class HelpCenterBriefCard extends StatelessWidget {
  const HelpCenterBriefCard({
    super.key,
    required this.currentCenter,
  });

  final HelpCenterModel currentCenter;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: ExpansionTile(
        title: Text(currentCenter.name!),
        children: [
          ListTile(
            title: Text("Adress: ${currentCenter.contactInfo!.address!}"),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<HelpCenterCubit>().selectedCenter =
                            currentCenter;
                        Navigator.pushNamed(context, Routes.helpCenterDetail);
                      },
                      child: const Text("Show Details")),
                  ElevatedButton(
                      onPressed: () {
                        context.read<MapCubit>().initialCameraLocation = LatLng(
                            currentCenter.location!.lat!,
                            currentCenter.location!.lon!);
                        context.read<MapCubit>().getCurrentLocation();
                        Navigator.of(context).pushNamed(Routes.mapRoute);
                      },
                      child: const Text("See On Map"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

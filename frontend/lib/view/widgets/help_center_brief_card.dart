import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/map/map_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(flex: 4, child: Text(currentCenter.name!)),
            SizedBox(
              width: 5,
            ),
            UserInfo.currentLatLng != null
                ? Flexible(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "${currentCenter.distance} KM",
                        maxLines: 1,
                      ),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
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
                        context.read<MapCubit>().getCurrentLocation();
                        context.read<HelpCenterCubit>().selectedCenter =
                            currentCenter;
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

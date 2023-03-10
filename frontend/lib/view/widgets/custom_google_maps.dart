import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_tags/simple_tags.dart';

import '../../cubit/map/map_cubit.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({
    super.key,
    required CameraPosition initialCameraPosition,
    required Completer<GoogleMapController> controller,
  })  : _initialCameraPosition = initialCameraPosition,
        _controller = controller;

  final CameraPosition _initialCameraPosition;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            Marker(
                markerId: const MarkerId("bilkent"),
                position: const LatLng(39.8753228063523, 32.74785369141424),
                draggable: false,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      builder: (BuildContext context) {
                        return buildBottomSheetBody(context);
                      });
                }),
            Marker(
                markerId: const MarkerId("current"),
                visible: context.read<MapCubit>().serviceEnabled == true
                    ? true
                    : false,
                position: LatLng(
                    context.read<MapCubit>().currentLocation.latitude,
                    context.read<MapCubit>().currentLocation.longitude),
                draggable: false,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure)),
          },
        ),
      ],
    );
  }

  Padding buildBottomSheetBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/bilkent.jpg",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                const Flexible(
                  child: Text(
                      "Bilkent Üniversitesi Daha Uzun Bir İsim Baya Uzun Hatta",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(100, 100, 100, 1))),
                )
              ],
            ),
          ),
          const Expanded(
            child: Text(
              "Benim mah. benim cd. benim sk. bilmem ne apt. 06800 Cankaya/Ankara",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(100, 100, 100, 1)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _buildBottomSheetNeedInfo(const Icon(Icons.person),
                    "Volunteer Need", const Icon(Icons.battery_2_bar_sharp)),
                const VerticalDivider(
                  thickness: 2,
                  endIndent: 40,
                ),
                _buildBottomSheetNeedInfo(const Icon(Icons.person),
                    "Supply Need", const Icon(Icons.battery_0_bar_sharp)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SimpleTags(
              content: [
                "Mont / Ceket",
                "İlaç",
                "Gıda",
                "Mont / Ceket",
                "İlaç",
                "Gıda",
                "Mont / Ceket",
                "İlaç",
                "Gıda"
              ],
              wrapSpacing: 4,
              wrapRunSpacing: 4,
              tagContainerPadding: const EdgeInsets.all(6),
              tagTextStyle: const TextStyle(color: Colors.white),
              tagContainerDecoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Show Details"))
        ],
      ),
    );
  }

  Expanded _buildBottomSheetNeedInfo(
      Icon iconTop, String need, Icon iconBottom) {
    return Expanded(
      child: Column(
        children: [iconTop, Text(need), iconBottom],
      ),
    );
  }
}

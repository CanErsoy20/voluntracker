import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({
    super.key,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
  })  : _kGooglePlex = kGooglePlex,
        _controller = controller;

  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            Marker(
                markerId: const MarkerId("bilket"),
                position: const LatLng(39.8753228063523, 32.74785369141424),
                draggable: false,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              color: Color.fromRGBO(
                                                  100, 100, 100, 1))),
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
                                child: Row(
                                  children: [
                                    _buildBottomSheetNeedInfo(
                                        Icon(Icons.person),
                                        "Workforce Need",
                                        Icon(Icons.battery_2_bar_sharp)),
                                    VerticalDivider(),
                                    _buildBottomSheetNeedInfo(
                                        Icon(Icons.person),
                                        "Workforce Need",
                                        Icon(Icons.battery_0_bar_sharp)),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Show Details"))
                            ],
                          ),
                        );
                      });
                })
          },
        ),
      ],
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

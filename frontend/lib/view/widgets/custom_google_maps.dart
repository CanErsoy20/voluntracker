import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({
    super.key,
    required CameraPosition initialCameraPosition,
    required Completer<GoogleMapController> controller,
    required Set<Marker> markers,
  })  : _initialCameraPosition = initialCameraPosition,
        _markers = markers,
        _controller = controller;

  final CameraPosition _initialCameraPosition;
  final Completer<GoogleMapController> _controller;
  final Set<Marker> _markers;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _markers,
        ),
      ],
    );
  }
}

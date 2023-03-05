import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  LatLng initialCameraPosition = LatLng(39.87474230379135, 32.747585469014844);
  Location location = Location();

  bool serviceEnabled = false; // locale storage
  PermissionStatus permissionGranted =
      PermissionStatus.denied; // locale storage

  Future<void> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Disabled");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Not Permitted");
        return;
      }
    }

    LocationData currentPosition = await location.getLocation();
    initialCameraPosition =
        LatLng(currentPosition.latitude!, currentPosition.longitude!);
  }
}

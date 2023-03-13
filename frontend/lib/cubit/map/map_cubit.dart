import 'package:afet_takip/models/help_center/help_center_model.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  LatLng currentLocation = LatLng(39.87474230379135, 32.747585469014844);
  LatLng initialCameraLocation = LatLng(39.87474230379135, 32.747585469014844);
  bool serviceEnabled = false;
  LocationPermission permissionGranted = LocationPermission.denied;

  // Get current location methods
  Future<void> getCurrentLocation() async {
    emit(MapLoading());
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(MapNoService());
      return;
    }

    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permissionGranted == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(position.latitude, position.longitude);
    emit(MapDisplay());
  }

  void continueWithoutGPS() {
    currentLocation = LatLng(39.93646920199857, 32.870560723133345);
    emit(MapDisplay());
  }
}

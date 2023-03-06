import 'dart:async';

import 'package:afet_takip/view/widgets/custom_google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../cubit/map_cubit.dart';
import '../widgets/custom_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Help Center Map"),
          centerTitle: true,
        ),
        body: BlocConsumer<MapCubit, MapState>(
          listener: (context, state) {
            if (state is MapNoService) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("GPS Service is disabled"),
                      content: Text(
                          "Please try again after you enable the location of your device."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<MapCubit>().continueWithoutGPS();
                            },
                            child: Text("Continue without my location")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<MapCubit>().getLocation();
                            },
                            child: Text("Try Again"))
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            print(state);
            if (state is MapDisplay) {
              return Stack(
                children: [
                  CustomGoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: context.read<MapCubit>().currentLocation,
                          zoom: 10),
                      controller: _controller),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CustomSearchBar(),
                    ),
                  ),
                ],
              );
            } else if (state is MapNoService) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("GPS Service is disabled"),
                  Text(
                      "Please try again after you enable the location of your device."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<MapCubit>().continueWithoutGPS();
                          },
                          child: Text("Continue without my location")),
                      ElevatedButton(
                          onPressed: () {
                            context.read<MapCubit>().getLocation();
                          },
                          child: Text("Try again")),
                    ],
                  )
                ],
              ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

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
        body: Stack(
          children: [
            CustomGoogleMap(
                initialCameraPosition: CameraPosition(
                    target: context.read<MapCubit>().initialCameraPosition,
                    zoom: 14),
                controller: _controller),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: CustomSearchBar(),
              ),
            ),
          ],
        ));
  }
}

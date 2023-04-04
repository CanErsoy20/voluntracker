import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/models/help_center/help_center_model.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_google_maps.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_tags/simple_tags.dart';
import '../../cubit/map/map_cubit.dart';
import '../widgets/custom_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  List<HelpCenterModel> items = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    setMarkers(context);
    setItems(context);
    super.initState();
  }

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
                      title: const Text("GPS Service is disabled"),
                      content: const Text(
                          "Please try again after you enable the location of your device."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<MapCubit>().continueWithoutGPS();
                            },
                            child: const Text("Continue without my location")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<MapCubit>().getCurrentLocation();
                            },
                            child: const Text("Try Again"))
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            debugPrint(state.toString());
            if (state is MapDisplay || state is MapInitial) {
              return Stack(
                children: [
                  CustomGoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: context.read<MapCubit>().initialCameraLocation,
                        zoom: 15),
                    controller: _controller,
                    markers: markers,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: DropdownSearch<HelpCenterModel>(
                            popupProps: const PopupProps.dialog(
                                fit: FlexFit.loose,
                                searchDelay: Duration.zero,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Search by name or city",
                                    enabled: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                                showSearchBox: true),
                            filterFn: (item, filter) {
                              return item.name!
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()) ||
                                  item.city!
                                      .toLowerCase()
                                      .contains(filter.toLowerCase());
                            },
                            items: items,
                            itemAsString: (item) {
                              return item.name!;
                            },
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    baseStyle: TextStyle(color: Colors.black),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Icons.search),
                                      border: InputBorder.none,
                                    )),
                            onChanged: (value) {
                              _goToPosition(value!);
                            },
                          ),
                        )),
                  ),
                ],
              );
            } else if (state is MapNoService) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("GPS Service is disabled"),
                  const Text(
                      "Please try again after you enable the location of your device."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<MapCubit>().continueWithoutGPS();
                          },
                          child: const Text("Continue without my location")),
                      ElevatedButton(
                          onPressed: () {
                            context.read<MapCubit>().getCurrentLocation();
                          },
                          child: const Text("Try again")),
                    ],
                  )
                ],
              ));
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        ));
  }

  Future<void> _goToPosition(HelpCenterModel selectedCenter) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            selectedCenter.location!.lat!, selectedCenter.location!.lon!),
        zoom: 15)));
  }

  void setItems(BuildContext context) {
    List<HelpCenterModel> centerList =
        context.read<HelpCenterCubit>().allHelpCentersList!;
    items.addAll(centerList);
    // for (var i = 0; i < centerList.length; i++) {
    //   if (!items.contains(centerList[i].city)) {
    //     items.add(centerList[i].city!);
    //   }
    //   items.add(centerList[i].name!);
    // }
  }

  void setMarkers(BuildContext context) {
    List<HelpCenterModel> centerList =
        context.read<HelpCenterCubit>().allHelpCentersList!;
    for (int i = 0; i < centerList.length; i++) {
      markers.add(Marker(
          markerId: MarkerId("${centerList[i].id}"),
          position: LatLng(
              centerList[i].location!.lat!, centerList[i].location!.lon!),
          draggable: false,
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                builder: (BuildContext context) {
                  return buildBottomSheetBody(centerList[i], context);
                });
          }));
    }
    markers.add(Marker(
        markerId: const MarkerId("current"),
        visible: context.read<MapCubit>().serviceEnabled,
        position: LatLng(context.read<MapCubit>().currentLocation.latitude,
            context.read<MapCubit>().currentLocation.longitude),
        draggable: false,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)));
  }

  Padding buildBottomSheetBody(HelpCenterModel center, BuildContext context) {
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
                Flexible(
                  child: Text(center.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(100, 100, 100, 1))),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              center.contactInfo!.address!,
              style: const TextStyle(
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
              content: const [
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
          ElevatedButton(
              onPressed: () {
                context.read<HelpCenterCubit>().selectedCenter = center;
                Navigator.pushNamed(context, Routes.helpCenterDetail);
              },
              child: const Text("Show Details"))
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

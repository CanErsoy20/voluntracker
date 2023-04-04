import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_search_bar.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voluntracker/view/widgets/not_found_widget.dart';

import '../../cubit/map/map_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
import '../../router.dart';
import '../widgets/help_center_brief_card.dart';

class HelpCenterListScreen extends StatelessWidget {
  HelpCenterListScreen({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        UserInfo.currentLatLng = null;

        controller.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Help Center List"),
          centerTitle: true,
        ),
        endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<MapCubit>().getCurrentLocation();
              Navigator.pushNamed(context, Routes.mapRoute);
              context.read<MapCubit>().initialCameraLocation =
                  context.read<MapCubit>().currentLocation;
            },
            child: const Icon(Icons.map)),
        body: BlocBuilder<HelpCenterCubit, HelpCenterState>(
          builder: (context, state) {
            print(state.toString());
            if (state is HelpCenterDisplay || state is HelpCenterNotFound) {
              return SingleChildScrollView(
                child: (context.read<HelpCenterCubit>().allHelpCentersList ==
                            null ||
                        context
                            .read<HelpCenterCubit>()
                            .allHelpCentersList!
                            .isEmpty)
                    ? Center(
                        child: NotFoundLottie(
                            title: "Help Center List Not Found",
                            description:
                                "Currently there are no help centers to display"),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomSearchBar(
                                controller: controller,
                                onChanged: (value) {
                                  context
                                      .read<HelpCenterCubit>()
                                      .searchCenters(value);
                                },
                                hint: "Search by name or city",
                                suffixIcon: PopupMenuButton(
                                  itemBuilder: (context) {
                                    if (UserInfo.currentLatLng != null) {
                                      return [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: const Text("Sort by distance"),
                                          onTap: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .sortbyDistance();
                                          },
                                        ),
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: const Text("Sort by name"),
                                          onTap: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .sortbyName();
                                          },
                                        ),
                                        PopupMenuItem<int>(
                                          value: 2,
                                          child: const Text("Sort by city"),
                                          onTap: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .sortbyCity();
                                          },
                                        ),
                                      ];
                                    } else {
                                      return [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: const Text("Sort by name"),
                                          onTap: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .sortbyName();
                                          },
                                        ),
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: const Text("Sort by city"),
                                          onTap: () {
                                            context
                                                .read<HelpCenterCubit>()
                                                .sortbyCity();
                                          },
                                        ),
                                      ];
                                    }
                                  },
                                )),
                          ),
                          state is HelpCenterNotFound
                              ? Center(
                                  child: NotFoundLottie(
                                      title: "No Help Center Found",
                                      description: "No help center found"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: context
                                          .read<HelpCenterCubit>()
                                          .tempHelpCentersList
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    HelpCenterModel currentCenter = context
                                        .read<HelpCenterCubit>()
                                        .tempHelpCentersList![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: HelpCenterBriefCard(
                                          currentCenter: currentCenter),
                                    );
                                  })
                        ],
                      ),
              );
            } else if (state is HelpCenterLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is HelpCenterNotFound) {
              return Center(
                child: NotFoundLottie(
                    title: "No Help Center Found",
                    description: "No help center found"),
              );
            } else {
              return const Text("Error");
            }
          },
        ),
      ),
    );
  }
}

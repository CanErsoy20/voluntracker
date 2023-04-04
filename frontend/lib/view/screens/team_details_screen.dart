import 'package:star_menu/star_menu.dart';
import 'package:voluntracker/models/assign_team_leader_model.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:voluntracker/view/widgets/participant_circle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/team/team_cubit.dart';
import '../../models/volunteer_model.dart';
import '../widgets/custom_snackbars.dart';

class TeamDetailsScreen extends StatefulWidget {
  const TeamDetailsScreen({super.key});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  final assignLeadKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Team Details"),
        ),
        endDrawer: CustomDrawer(loggedIn: true),
        body: BlocConsumer<TeamCubit, TeamState>(
          listener: (context, state) {
            if (state is TeamSuccess) {
              Navigator.pop(context);
              CustomSnackbars.successSnackbar(
                  context, state.title, state.description);

              context.read<TeamCubit>().emitLoading();
              context.read<HelpCenterCubit>().getMyCenter();
              context.read<TeamCubit>().selectedTeam = context
                  .read<HelpCenterCubit>()
                  .myCenter!
                  .volunteerTeams![context.read<TeamCubit>().selectedTeamIndex];

              context.read<TeamCubit>().emitDisplay();
              Navigator.pop(context);
            } else if (state is TeamError) {
              CustomSnackbars.errorSnackbar(
                  context, state.title, state.description);
            }
          },
          builder: (context, state) {
            if (state is TeamLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${context.read<TeamCubit>().selectedTeam.teamName}",
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.blue),
                            )
                          ],
                        )),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Team Leader: ",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    context
                                .read<TeamCubit>()
                                .selectedTeam
                                .volunteerTeamLeader !=
                            null
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 5,
                            child: ListTile(
                                leading: const CircleAvatar(),
                                title: Text(
                                    "${context.read<TeamCubit>().selectedTeam.volunteerTeamLeader!.volunteer!.user!.firstname} ${context.read<TeamCubit>().selectedTeam.volunteerTeamLeader!.volunteer!.user!.surname}"),
                                //subtitle: Text("${context.read<TeamCubit>().selectedTeam.volunteerTeamLeader!.volunteer!.user!.getHighestRole()}"),
                                trailing: PopupMenuButton(
                                  itemBuilder: (contex) {
                                    return [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: const Text("Remove from team"),
                                        onTap: () {
                                          // remove isteği at
                                        },
                                      ),
                                    ];
                                  },
                                  position: PopupMenuPosition.over,
                                )),
                          )
                        : const Text(
                            "No Team Leader Assigned",
                            style: TextStyle(fontSize: 20),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Team members: ",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildVolunteerList(
                        context.read<TeamCubit>().selectedTeam.volunteers!)
                  ]),
            );
          },
        ),
        floatingActionButton: StarMenu(
          onItemTapped: (index, controller) {
            if (index != 1) controller.closeMenu!();
          },
          params: const StarMenuParameters(
            shape: MenuShape.linear,
            linearShapeParams: LinearShapeParams(
                angle: 270, space: 10, alignment: LinearAlignment.center),
          ),
          items: [
            _buildAddVolunteerFAB(context),
            FloatingActionButton.extended(
              onPressed: () {
                AssignTeamLeaderModel assignTeamLeaderModel =
                    AssignTeamLeaderModel();
                assignTeamLeaderModel.volunteerTeamId =
                    context.read<TeamCubit>().selectedTeam.id!;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Form(
                            key: assignLeadKey,
                            child: SizedBox(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return "Please choose a volunteer to assign as team leader";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: "Volunteers",
                                    border: OutlineInputBorder(),
                                    errorMaxLines: 5),
                                items: context
                                    .read<TeamCubit>()
                                    .selectedTeam
                                    .volunteers!
                                    .map<DropdownMenuItem<Volunteer>>(
                                        (Volunteer value) {
                                  return DropdownMenuItem<Volunteer>(
                                    value: value,
                                    child: Text(
                                        "${value.user!.firstname!} ${value.user!.surname!}"),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  assignTeamLeaderModel.volunteerId =
                                      value!.id!;
                                },
                              ),
                            ))),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (assignLeadKey.currentState!.validate()) {
                                  context
                                      .read<TeamCubit>()
                                      .assignLeader(assignTeamLeaderModel);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Assign Team Leader")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        ],
                      );
                    });
              },
              label: const Text("Assign Team Leader"),
            ),
            const SizedBox(height: 70),
          ],
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        ));
  }

  FloatingActionButton _buildAddVolunteerFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            builder: (BuildContext context) {
              return BlocBuilder<TeamCubit, TeamState>(
                builder: (context, state) {
                  List<Volunteer> helpCenterVolunteers =
                      context.read<HelpCenterCubit>().myCenter!.volunteers ??
                          [];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  context.read<TeamCubit>().addVolunteers();
                                  context.read<TeamCubit>().volunteersToAdd =
                                      [];
                                },
                                child: const Text(
                                  "Add to team",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                )),
                          ),
                          context.read<TeamCubit>().volunteersToAdd.isNotEmpty
                              ? CarouselSlider.builder(
                                  itemCount: context
                                      .read<TeamCubit>()
                                      .volunteersToAdd
                                      .length,
                                  itemBuilder:
                                      (context, itemIndex, pageViewIndex) {
                                    return FittedBox(
                                      child: ParticipantCircleAvatar(
                                        onClosePressed: () {
                                          context
                                              .read<TeamCubit>()
                                              .removeFromList(itemIndex);
                                        },
                                        name:
                                            "${context.read<TeamCubit>().volunteersToAdd[itemIndex].user!.firstname!} ${context.read<TeamCubit>().volunteersToAdd[itemIndex].user!.surname!}",
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.25,
                                    enlargeFactor: 0.3,
                                    autoPlay: false,
                                    height: 100,
                                  ))
                              : const SizedBox.shrink(),
                          ListView.builder(
                              itemCount: helpCenterVolunteers.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ListTile(
                                          onTap: () {
                                            if (!context
                                                .read<TeamCubit>()
                                                .isInList(helpCenterVolunteers[
                                                    index])) {
                                              context
                                                  .read<TeamCubit>()
                                                  .addToList(
                                                      helpCenterVolunteers[
                                                          index]);
                                            }
                                          },
                                          leading: const CircleAvatar(),
                                          title: Text(
                                              "${helpCenterVolunteers[index].user!.firstname!} ${helpCenterVolunteers[index].user!.surname!}"),
                                          trailing: context
                                                  .read<TeamCubit>()
                                                  .isInList(
                                                      helpCenterVolunteers[
                                                          index])
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )
                                              : const Icon(Icons
                                                  .check_circle_outline_outlined)),
                                    ),
                                    const Divider(
                                      indent: 25,
                                      endIndent: 25,
                                      color: Colors.black,
                                      thickness: 2,
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
      label:
          const SizedBox(width: 140, child: Center(child: Text("Add Members"))),
    );
  }

  Widget _buildVolunteerList(List<Volunteer> volunteers) {
    if (volunteers.isNotEmpty) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: volunteers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildTeammemberTile(volunteers, index);
          });
    } else {
      return const Center(
        child: Text(
          "No volunteers are found in this team right now.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Padding _buildTeammemberTile(List<Volunteer> volunteers, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: ListTile(
            leading: const CircleAvatar(),
            title: Text(
                "${volunteers[index].user?.firstname} ${volunteers[index].user?.surname}"),
            subtitle: Text("${volunteers[index].user?.getHighestRole()}"),
            trailing: PopupMenuButton(
              itemBuilder: (contex) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: const Text("Remove from team"),
                    onTap: () {
                      // remove isteği at
                    },
                  ),
                ];
              },
              position: PopupMenuPosition.over,
            )),
      ),
    );
  }
}

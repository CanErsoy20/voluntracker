import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_text_form_field.dart';
import 'package:afet_takip/view/widgets/participant_circle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/team/team_cubit.dart';
import '../../models/user/user_model.dart';
import '../../models/user/user_role_model.dart';
import '../../models/volunteer_model.dart';
import '../widgets/custom_snackbars.dart';

class AddToTeamScreen extends StatefulWidget {
  const AddToTeamScreen({super.key});

  @override
  State<AddToTeamScreen> createState() => _AddToTeamScreenState();
}

class _AddToTeamScreenState extends State<AddToTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Members To Team"),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is TeamSuccess) {
            CustomSnackbars.successSnackbar(
                context, state.title, state.description);
            Navigator.pop(context);
          } else if (state is TeamError) {
            CustomSnackbars.errorSnackbar(
                context, state.title, state.description);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text(
                          "Team Name: ${context.read<TeamCubit>().selectedTeam.teamName}")
                    ],
                  )),
              const Text("Team members: "),
              const SizedBox(
                height: 10,
              ),
              _buildVolunteerList()
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
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
                                                  .isInList(
                                                      helpCenterVolunteers[
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
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                                : Icon(Icons
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
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVolunteerList() {
    List<Volunteer> volunteers =
        context.read<TeamCubit>().selectedTeam.volunteers ?? [];
    if (volunteers.isNotEmpty) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: volunteers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(
                      "${volunteers[index].user?.firstname} ${volunteers[index].user?.surname}"),
                  subtitle: Text("${volunteers[index].user?.getHighestRole()}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // open menu, show remove volunteer from team option, if selected remove them from the team
                    },
                  ),
                ),
              ),
            );
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
}

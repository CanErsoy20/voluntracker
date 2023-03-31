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
      body: SingleChildScrollView(
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
          _buildVolunteerList(
              context.read<TeamCubit>().selectedTeam.volunteers ?? [])
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<Volunteer> helpCenterVolunteers =
              context.read<HelpCenterCubit>().myCenter!.volunteers ?? [];
          showModalBottomSheet(
              backgroundColor: Colors.green,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Add to team",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        //Search bar
                        CustomTextFormField(
                          initialValue: "",
                          label: "",
                          suffixIcon: const Icon(Icons.search),
                        ),
                        (context.read<TeamCubit>().selectedTeam.volunteers !=
                                    null) &&
                                context
                                    .read<TeamCubit>()
                                    .selectedTeam
                                    .volunteers!
                                    .isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: context
                                    .read<TeamCubit>()
                                    .selectedTeam
                                    .volunteers!
                                    .length,
                                itemBuilder:
                                    (context, itemIndex, pageViewIndex) {
                                  return const FittedBox(
                                    child: ParticipantCircleAvatar(),
                                  );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 0.25,
                                  enlargeFactor: 0.3,
                                  autoPlay: false,
                                  height: 100,
                                  initialPage: 0,
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
                                        leading: const CircleAvatar(),
                                        title: Text(
                                            "${helpCenterVolunteers[index].user!.firstname!} ${helpCenterVolunteers[index].user!.surname!}"),
                                        trailing: Icon(Icons
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
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVolunteerList(List<Volunteer> volunteers) {
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

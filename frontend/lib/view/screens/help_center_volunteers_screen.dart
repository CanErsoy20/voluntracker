import 'package:afet_takip/models/help_center/busiest_hours_model.dart';
import 'package:afet_takip/models/help_center/contact_info_model.dart';
import 'package:afet_takip/models/help_center/location_model.dart';
import 'package:afet_takip/models/help_center/open_close_info_model.dart';
import 'package:afet_takip/models/user/user_model.dart';
import 'package:afet_takip/models/user/user_role_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/models/volunteer_team_leader_model.dart';
import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:afet_takip/view/widgets/loading_widget.dart';
import 'package:afet_takip/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import '../../cubit/team/team_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../widgets/custom_snackbars.dart';

class HelpCenterVolunteersScreen extends StatefulWidget {
  const HelpCenterVolunteersScreen({super.key});

  @override
  State<HelpCenterVolunteersScreen> createState() =>
      _HelpCenterVolunteersScreenState();
}

class _HelpCenterVolunteersScreenState
    extends State<HelpCenterVolunteersScreen> {
  List<VolunteerTeam> volunteerTeams = [];

  @override
  Widget build(BuildContext context) {
    final createTeamFormKey = GlobalKey<FormState>();
    final assignVolunteerFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Volunteers'),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is TeamSuccess) {
            CustomSnackbars.successSnackbar(
                context, state.title, state.description);
            Navigator.pop(context);
            context.read<TeamCubit>().emitDisplay();
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
          return VolunteerList(
            volunteerTeams: volunteerTeams,
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
          FloatingActionButton(
            onPressed: () {
              // show dialog for creating a team
              _showCreateTeamDialog(context, createTeamFormKey);
            },
            child: const Icon(Icons.people),
          ),
          FloatingActionButton(
            onPressed: () {
              // show dialog for adding a volunteer to help center
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Form(
                          key: assignVolunteerFormKey,
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomFormField(
                                  hint: "",
                                  label: "Volunteer Email",
                                  labelColor: Colors.black,
                                  onChanged: (value) {
                                    //TODO:
                                  },
                                ),
                                Text("OR"),
                                CustomFormField(
                                  hint: "",
                                  label: "Volunteer Phone Number",
                                  labelColor: Colors.black,
                                  onChanged: (value) {
                                    //TODO:
                                  },
                                ),
                              ],
                            ),
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (assignVolunteerFormKey.currentState!
                                  .validate()) {
                                //TODO: assign request at
                              }
                            },
                            child: const Text(
                                "Assign Volunteer to My Help Center")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                      ],
                    );
                  });
            },
            child: const Icon(Icons.person),
          ),
          const SizedBox(height: 70),
        ],
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCreateTeamDialog(
      BuildContext context, GlobalKey<FormState> formKey) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                key: formKey,
                child: SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      CustomFormField(
                        hint: "",
                        label: "Team Name",
                        labelColor: Colors.black,
                        onChanged: (value) {
                          context.read<TeamCubit>().newTeam.teamName = value;
                        },
                      )
                    ],
                  ),
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<TeamCubit>().createNewTeam();
                    }
                  },
                  child: const Text("Create New Team")),
            ],
          );
        });
  }
}

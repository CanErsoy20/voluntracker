import 'package:afet_takip/models/assign_volunteer_model.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:afet_takip/view/widgets/loading_widget.dart';
import 'package:afet_takip/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/team/team_cubit.dart';
import '../widgets/custom_snackbars.dart';

class HelpCenterVolunteersScreen extends StatefulWidget {
  const HelpCenterVolunteersScreen({super.key});

  @override
  State<HelpCenterVolunteersScreen> createState() =>
      _HelpCenterVolunteersScreenState();
}

class _HelpCenterVolunteersScreenState
    extends State<HelpCenterVolunteersScreen> {
  @override
  Widget build(BuildContext context) {
    final createTeamFormKey = GlobalKey<FormState>();
    final assignVolunteerFormKey = GlobalKey<FormState>();
    return BlocListener<HelpCenterCubit, HelpCenterState>(
      listener: (context, state) {
        if (state is HelpCenterSuccess) {
          CustomSnackbars.successSnackbar(
              context, state.title, state.description);
          Navigator.pop(context);
        } else if (state is HelpCenterError) {
          CustomSnackbars.errorSnackbar(
              context, state.title, state.description);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Volunteer Teams"),
        ),
        endDrawer: CustomDrawer(loggedIn: true),
        body: BlocConsumer<TeamCubit, TeamState>(
          listener: (context, state) {
            if (state is TeamSuccess) {
              CustomSnackbars.successSnackbar(
                  context, state.title, state.description);

              Navigator.pop(context);
              context.read<TeamCubit>().emitLoading();
              context.read<HelpCenterCubit>().getMyCenter();
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
            } else {
              return VolunteerList(
                volunteerTeams:
                    context.read<HelpCenterCubit>().myCenter!.volunteerTeams ??
                        [],
              );
            }
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
            FloatingActionButton.extended(
              label: SizedBox(
                  width: 140, child: Center(child: const Text("Create Team"))),
              onPressed: () {
                // show dialog for creating a team
                _showCreateTeamDialog(context, createTeamFormKey);
              },
            ),
            FloatingActionButton.extended(
              label: const SizedBox(
                  width: 140, child: Center(child: Text("Assign Volunteers"))),
              onPressed: () {
                // show dialog for adding a volunteer to help center
                AssignVolunteerModel assignVolunteerModel =
                    AssignVolunteerModel();
                assignVolunteerModel.helpCenterId =
                    context.read<HelpCenterCubit>().myCenter!.id!;
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
                                    customValidator: (value) {},
                                    hint: "",
                                    label: "Volunteer Email",
                                    labelColor: Colors.black,
                                    onChanged: (value) {
                                      assignVolunteerModel.email = value;
                                    },
                                  ),
                                  Text("OR"),
                                  CustomFormField(
                                    customValidator: (value) {},
                                    hint: "",
                                    label: "Volunteer Phone Number",
                                    labelColor: Colors.black,
                                    onChanged: (value) {
                                      assignVolunteerModel.phone = value;
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
                                  context
                                      .read<HelpCenterCubit>()
                                      .assignVolunteers(assignVolunteerModel);
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
            ),
            const SizedBox(height: 70),
          ],
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
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

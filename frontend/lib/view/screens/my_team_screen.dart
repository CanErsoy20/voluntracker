import 'package:voluntracker/models/assign_volunteer_model.dart';
import 'package:voluntracker/models/user/user_info.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_text_field.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:voluntracker/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/team/team_cubit.dart';
import '../../models/volunteer_team_model.dart';
import '../widgets/custom_snackbars.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  @override
  Widget build(BuildContext context) {
    VolunteerTeam myTeam = context
        .read<HelpCenterCubit>()
        .myCenter!
        .volunteerTeams!
        .firstWhere((element) =>
            element.id == UserInfo.loggedUser!.volunteer!.volunteerTeamId);
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
          title: const Text("My Team"),
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
        floatingActionButton: FloatingActionButton.extended(
          label: const SizedBox(
              width: 140, child: Center(child: Text("Assign Volunteers"))),
          onPressed: () {
            // show dialog for adding a volunteer to help center
            AssignVolunteerModel assignVolunteerModel = AssignVolunteerModel();
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
                              const Text("OR"),
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
                          child:
                              const Text("Assign Volunteer to My Help Center")),
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
      ),
    );
  }
}

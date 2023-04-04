import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voluntracker/models/volunteer_model.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_dropdown_form_field.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../models/assign_volunteer_model.dart';
import '../../models/help_center/help_center_model.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/custom_snackbars.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_widget.dart';
import '../widgets/not_found_widget.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Manage Users"),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: BlocConsumer<HelpCenterCubit, HelpCenterState>(
        listener: (context, state) {
          if (state is HelpCenterSuccess) {
            CustomSnackbars.successSnackbar(
                context, state.title, state.description);
            context.read<HelpCenterCubit>().getHelpCenters();
          } else if (state is HelpCenterError) {
            CustomSnackbars.errorSnackbar(
                context, state.title, state.description);

            context.read<HelpCenterCubit>().getHelpCenters();
          }
        },
        builder: (context, state) {
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
                          ),
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
                                  return CenterExpansionTile(
                                      currentCenter: currentCenter);
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
            return const Center(
                child: Text(
                    "An Error Has Occured. We are sorry for the inconvinience"));
          }
        },
      ),
    );
  }
}

class CenterExpansionTile extends StatelessWidget {
  const CenterExpansionTile({
    super.key,
    required this.currentCenter,
  });

  final HelpCenterModel currentCenter;

  @override
  Widget build(BuildContext context) {
    final assignCoordKey = GlobalKey<FormState>();
    final assignVolunteerKey = GlobalKey<FormState>();
    int? volunteerId;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: ExpansionTile(
            title: Row(
              children: [
                Text(currentCenter.name!),
              ],
            ),
            children: [
              ListTile(
                title: Column(
                  children: [
                    Text("Adress: ${currentCenter.contactInfo!.address!}"),
                    currentCenter.coordinator == null
                        ? const Text("No Coordinator Assigned")
                        : Text(
                            "Coordinator: ${currentCenter.volunteers?.firstWhere((element) => element.id == currentCenter.coordinator?.volunteerId).user!.firstname} ${currentCenter.volunteers?.firstWhere((element) => element.id == currentCenter.coordinator?.volunteerId).user!.surname}"),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            AssignVolunteerModel assignVolunteerModel =
                                AssignVolunteerModel();
                            assignVolunteerModel.helpCenterId =
                                currentCenter.id!;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Form(
                                        key: assignVolunteerKey,
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
                                                  assignVolunteerModel.email =
                                                      value;
                                                },
                                              ),
                                              const Text("OR"),
                                              CustomFormField(
                                                customValidator: (value) {},
                                                hint: "",
                                                label: "Volunteer Phone Number",
                                                labelColor: Colors.black,
                                                onChanged: (value) {
                                                  assignVolunteerModel.phone =
                                                      value;
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (assignVolunteerKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<HelpCenterCubit>()
                                                  .assignVolunteers(
                                                      assignVolunteerModel);
                                              Navigator.pop(context);
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
                          child: Text("Assign Volunteer")),
                      ElevatedButton(
                          onPressed: (currentCenter.coordinator != null ||
                                  currentCenter.volunteers == null ||
                                  currentCenter.volunteers!.isEmpty)
                              ? null
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Form(
                                              key: assignCoordKey,
                                              child: SizedBox(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: DropdownButtonFormField(
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return "Please choose a volunteer to assign as coordinator";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              "Volunteers",
                                                          border:
                                                              OutlineInputBorder(),
                                                          errorMaxLines: 5),
                                                  items: currentCenter
                                                      .volunteers!
                                                      .map<
                                                              DropdownMenuItem<
                                                                  Volunteer>>(
                                                          (Volunteer value) {
                                                    return DropdownMenuItem<
                                                        Volunteer>(
                                                      value: value,
                                                      child: Text(
                                                          "${value.user!.firstname!} ${value.user!.surname!}"),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    volunteerId = value!.id!;
                                                  },
                                                ),
                                              ))),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  if (assignCoordKey
                                                      .currentState!
                                                      .validate()) {
                                                    context
                                                        .read<HelpCenterCubit>()
                                                        .assignCoordinator(
                                                            currentCenter.id!,
                                                            volunteerId!);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text(
                                                    "Assign Coordinator")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel")),
                                          ],
                                        );
                                      });
                                },
                          child: const Text("Assign Coordinator")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: currentCenter.coordinator != null
                              ? () {
                                  context
                                      .read<HelpCenterCubit>()
                                      .removeCoordinator(currentCenter
                                          .coordinator!.volunteerId!);
                                }
                              : null,
                          child: const Text("Remove Coordinator"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/models/needed_volunteer/create_needed_volunteer_model.dart';
import 'package:afet_takip/models/needed_volunteer/needed_volunteer_model.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../enums.dart';
import '../../models/help_center/help_center_model.dart';
import '../widgets/custom_dropdown_form_field.dart';
import '../widgets/custom_need_card.dart';

class UpdateHelpCenterScreen extends StatefulWidget {
  const UpdateHelpCenterScreen({super.key});

  @override
  State<UpdateHelpCenterScreen> createState() => _UpdateHelpCenterScreenState();
}

class _UpdateHelpCenterScreenState extends State<UpdateHelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Help Center Details"),
        centerTitle: true,
      ),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                ),
                child: TabBar(
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue),
                  tabs: const [
                    Tab(
                      text: "Volunteer",
                    ),
                    Tab(
                      text: "Suppply",
                    ),
                    Tab(
                      text: "Other Details",
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  _buildVolunteerNeeds(
                      context,
                      context.read<HelpCenterCubit>().selectedCenter ??
                          context.read<HelpCenterCubit>().helpCenterList![1]),
                  _buildVolunteerNeeds(
                      context,
                      context.read<HelpCenterCubit>().selectedCenter ??
                          context.read<HelpCenterCubit>().helpCenterList![1]),
                  _buildVolunteerNeeds(
                      context,
                      context.read<HelpCenterCubit>().selectedCenter ??
                          context.read<HelpCenterCubit>().helpCenterList![1])
                ]),
              )
            ],
          )),
    );
  }

  Widget _buildVolunteerNeeds(
      BuildContext context, HelpCenterModel currentCenter) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: currentCenter.neededVolunteerList!.length,
                  itemBuilder: (context, index) {
                    return CustomNeedCard(
                      needName: currentCenter
                          .neededVolunteerList![index].volunteerTypeName!,
                      needCategory: currentCenter
                          .neededVolunteerList![index].volunteerTypeCategory!,
                      needPercent: double.parse(currentCenter
                          .neededVolunteerList![index].quantity!
                          .toString()),
                      // (currentCenter.volunteerCapacity! -
                      //         currentCenter
                      //             .neededVolunteerList![index].quantity!) /
                      //     currentCenter.volunteerCapacity!,
                      lastUpdatedAt:
                          currentCenter.neededVolunteerList![index].updatedAt!,
                      leading: Icon(
                        Icons.warning_amber_sharp,
                        color:
                            currentCenter.neededVolunteerList![index].urgency ==
                                    "Low"
                                ? Colors.green
                                : currentCenter.neededVolunteerList![index]
                                            .urgency ==
                                        "Medium"
                                    ? Colors.orange
                                    : Colors.red,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            _showUpdateNeedDialog(context,
                                currentCenter.neededVolunteerList![index]);
                          },
                          iconSize: 20,
                          icon: const Icon(Icons.edit)),
                    );
                  });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _showNewVolunteerDialog(context);
          },
          child: const Text("Add New"),
        )
      ],
    );
  }

  void _showUpdateNeedDialog(BuildContext context, NeededVolunteer oldModel) {
    showDialog(
        context: context,
        builder: (context) {
          final _formKey1 = GlobalKey<FormState>();
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_formKey1.currentState!.validate()) {
                      context.read<HelpCenterCubit>().updateNeededVolunteer(
                          context.read<HelpCenterCubit>().newVolunteerNeed,
                          1,
                          oldModel.id!);
                      context.read<HelpCenterCubit>().newVolunteerNeed =
                          CreateNeededVolunteer();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"))
            ],
            content: _buildNeededVolunteerForm(_formKey1, oldModel),
          );
        });
  }

  void _showNewVolunteerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          final _formKey = GlobalKey<FormState>();
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<HelpCenterCubit>().createNeededVolunteer(
                          context.read<HelpCenterCubit>().newVolunteerNeed, 1);
                      context.read<HelpCenterCubit>().newVolunteerNeed =
                          CreateNeededVolunteer();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add New Need"))
            ],
            content: _buildNeededVolunteerForm(_formKey),
          );
        });
  }

  Form _buildNeededVolunteerForm(GlobalKey<FormState> formKey,
      [NeededVolunteer? oldModel]) {
    List<String> volunteerTypeNames =
        VolunteerTypeName.values.map((e) => e.name).toList();
    List<String> volunteerTypeCategory =
        VolunteerTypeCategory.values.map((e) => e.name).toList();
    List<String> urgency = Urgency.values.map((e) => e.name).toList();

    oldModel != null
        ? context.read<HelpCenterCubit>().newVolunteerNeed = oldModel
        : null;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text("Create New Needed Volunteer"),
            ),
            CustomDropdownFormField(
              list: volunteerTypeCategory,
              label: "Category",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newVolunteerNeed
                    .volunteerTypeCategory = value;
              },
            ),
            CustomDropdownFormField(
              list: volunteerTypeNames,
              label: "Name",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newVolunteerNeed
                    .volunteerTypeName = value;
              },
            ),
            CustomDropdownFormField(
              list: urgency,
              label: "Urgency",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newVolunteerNeed.urgency =
                    value;
              },
            ),
            CustomFormField(
                hint: "Ex: 50",
                label: "Quantity",
                onChanged: (value) {
                  context.read<HelpCenterCubit>().newVolunteerNeed.quantity =
                      int.tryParse(value);
                },
                customValidator: (value) {
                  if (isInt(value!)) {
                    if (int.parse(value) > 0) {
                      return null;
                    } else {
                      return "Quantity must be a number >= 0";
                    }
                  } else {
                    return "Quantity must be a number => 0";
                  }
                })
          ],
        ),
      ),
    );
  }
}

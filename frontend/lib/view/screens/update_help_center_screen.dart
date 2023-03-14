import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/models/needed_volunteer/create_needed_volunteer_model.dart';
import 'package:afet_takip/models/needed_volunteer/needed_volunteer_model.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../enums.dart';
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
                  _buildVolunteerNeeds(context),
                  _buildVolunteerNeeds(context),
                  _buildVolunteerNeeds(context)
                ]),
              )
            ],
          )),
    );
  }

  Widget _buildVolunteerNeeds(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CustomNeedCard(
                  needName: "Some example volunteer name",
                  needCategory: "Some example volunteer category",
                  needPercent: 0.8,
                  lastUpdatedAt: "15:17",
                  leading: Icon(
                    Icons.warning_amber_sharp,
                    color: index == 1
                        ? Colors.green
                        : index == 2
                            ? Colors.orange
                            : Colors.red,
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        CreateNeededVolunteer newVolunteerNeed =
                            CreateNeededVolunteer();
                        newVolunteerNeed.helpCenterId = 2;
                        // TODO: cubitten getir
                        NeededVolunteer oldModelFromApi = NeededVolunteer();
                        _showUpdateNeedDialog(
                            context, newVolunteerNeed, oldModelFromApi);
                      },
                      iconSize: 20,
                      icon: const Icon(Icons.edit)),
                );
              }),
        ),
        ElevatedButton(
          onPressed: () {
            CreateNeededVolunteer newVolunteerNeed = CreateNeededVolunteer();
            newVolunteerNeed.helpCenterId = 2;
            _showNewVolunteerDialog(context, newVolunteerNeed);
          },
          child: const Text("Add New"),
        )
      ],
    );
  }

  void _showUpdateNeedDialog(BuildContext context,
      CreateNeededVolunteer newVolunteerNeed, NeededVolunteer oldModel) {
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
                      // TODO: sent request to API to update with the given parameters
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Update"))
            ],
            content:
                _buildNeededVolunteerForm(_formKey, newVolunteerNeed, oldModel),
          );
        });
  }

  void _showNewVolunteerDialog(
      BuildContext context, CreateNeededVolunteer newVolunteerNeed) {
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
                      context
                          .read<HelpCenterCubit>()
                          .createNeededVolunteer(newVolunteerNeed, 2);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add New Need"))
            ],
            content: _buildNeededVolunteerForm(_formKey, newVolunteerNeed),
          );
        });
  }

  Form _buildNeededVolunteerForm(
      GlobalKey<FormState> formKey, CreateNeededVolunteer newVolunteerNeed,
      [NeededVolunteer? oldModel]) {
    List<String> volunteerTypeNames =
        VolunteerTypeName.values.map((e) => e.name).toList();
    List<String> volunteerTypeCategory =
        VolunteerTypeCategory.values.map((e) => e.name).toList();
    List<String> urgency = Urgency.values.map((e) => e.name).toList();
    oldModel != null ? newVolunteerNeed = oldModel : null;

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
                newVolunteerNeed.volunteerTypeCategory = value;
              },
            ),
            CustomDropdownFormField(
              list: volunteerTypeNames,
              label: "Name",
              onChanged: (value) {
                newVolunteerNeed.volunteerTypeName = value;
              },
            ),
            CustomDropdownFormField(
              list: urgency,
              label: "Urgency",
              onChanged: (value) {
                newVolunteerNeed.urgency = value;
              },
            ),
            CustomFormField(
                hint: "Ex: 50",
                label: "Quantity",
                onChanged: (value) {
                  newVolunteerNeed.quantity = int.tryParse(value);
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

import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/enums.dart';
import 'package:afet_takip/models/needed_volunteer/create_needed_volunteer_model.dart';
import 'package:afet_takip/models/needed_volunteer/needed_volunteer_model.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../models/help_center/help_center_model.dart';
import '../../models/needed_supply/create_needed_supply_model.dart';
import '../../models/needed_supply/needed_supply_model.dart';
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
                child: BlocListener<HelpCenterCubit, HelpCenterState>(
                  listener: (context, state) {
                    if (state is HelpCenterError) {
                      _errorSnackbar(context, state);
                    } else if (state is HelpCenterSuccess) {
                      _successSnackbar(context, state);
                    }
                  },
                  child: TabBarView(children: [
                    _buildVolunteerNeeds(
                        context,
                        context.read<HelpCenterCubit>().selectedCenter ??
                            context.read<HelpCenterCubit>().helpCenterList![1]),
                    _buildSupplyNeeds(
                        context,
                        context.read<HelpCenterCubit>().selectedCenter ??
                            context.read<HelpCenterCubit>().helpCenterList![1]),
                    _buildVolunteerNeeds(
                        context,
                        context.read<HelpCenterCubit>().selectedCenter ??
                            context.read<HelpCenterCubit>().helpCenterList![1])
                  ]),
                ),
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
                      quantity:
                          currentCenter.neededVolunteerList![index].quantity!,
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
                            _showUpdateVolunteerNeedDialog(context,
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

  void _errorSnackbar(BuildContext context, HelpCenterError state) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: AwesomeSnackbarContent(
          color: Colors.red,
          title: state.title,
          message: state.description,
          contentType: ContentType.failure,
        )));
  }

  void _successSnackbar(BuildContext context, HelpCenterSuccess state) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          color: Colors.green,
          title: state.title,
          message: state.description,
          contentType: ContentType.success,
        )));
  }

  // Needed Volunteer methods
  void _showUpdateVolunteerNeedDialog(
      BuildContext context, NeededVolunteer oldModel) {
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
            content: _buildNeededVolunteerForm(
                _formKey1, "Update Volunteer Need", oldModel),
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
            content: _buildNeededVolunteerForm(
                _formKey, "Create New Volunteer Need"),
          );
        });
  }

  Form _buildNeededVolunteerForm(GlobalKey<FormState> formKey, String title,
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
            Center(
              child: Text(title),
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
                hint: context
                    .read<HelpCenterCubit>()
                    .newVolunteerNeed
                    .quantity
                    .toString(),
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

  // Needed supply methods
  Form _buildNeededSupplyForm(GlobalKey<FormState> formKey, String title,
      [NeededSupply? oldModel]) {
    List<String> supplyTypeNames =
        SupplyTypeName.values.map((e) => e.name).toList();
    List<String> supplyTypeCategory =
        SupplyTypeCategory.values.map((e) => e.name).toList();
    List<String> urgency = Urgency.values.map((e) => e.name).toList();

    oldModel != null
        ? context.read<HelpCenterCubit>().newSupplyNeed = oldModel
        : null;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(title),
            ),
            CustomDropdownFormField(
              list: supplyTypeCategory,
              label: "Category",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newSupplyNeed
                    .supplyTypeCategory = value;
              },
            ),
            CustomDropdownFormField(
              list: supplyTypeNames,
              label: "Name",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newSupplyNeed.supplyTypeName =
                    value;
              },
            ),
            CustomDropdownFormField(
              list: urgency,
              label: "Urgency",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newSupplyNeed.urgency = value;
              },
            ),
            CustomFormField(
                hint: context
                    .read<HelpCenterCubit>()
                    .newSupplyNeed
                    .quantity
                    .toString(),
                label: "Quantity",
                onChanged: (value) {
                  context.read<HelpCenterCubit>().newSupplyNeed.quantity =
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

  void _showNewSupplyDialog(BuildContext context) {
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
                      context.read<HelpCenterCubit>().createNeededSupply(
                          context.read<HelpCenterCubit>().newSupplyNeed, 1);
                      context.read<HelpCenterCubit>().newSupplyNeed =
                          CreateNeededSupply();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add New Need"))
            ],
            content: _buildNeededSupplyForm(_formKey, "Create New Supply Need"),
          );
        });
  }

  void _showUpdateSupplyNeedDialog(
      BuildContext context, NeededSupply oldModel) {
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
                      context.read<HelpCenterCubit>().updateNeededSupply(
                          context.read<HelpCenterCubit>().newSupplyNeed,
                          1,
                          oldModel.id!);
                      context.read<HelpCenterCubit>().newSupplyNeed =
                          CreateNeededSupply();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"))
            ],
            content: _buildNeededSupplyForm(
                _formKey1, "Update Supply Need", oldModel),
          );
        });
  }

  Widget _buildSupplyNeeds(
      BuildContext context, HelpCenterModel currentCenter) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: currentCenter.neededSupplyList!.length,
                  itemBuilder: (context, index) {
                    return CustomNeedCard(
                      needName: currentCenter
                          .neededSupplyList![index].supplyTypeName!,
                      needCategory: currentCenter
                          .neededSupplyList![index].supplyTypeCategory!,
                      quantity:
                          currentCenter.neededSupplyList![index].quantity!,
                      lastUpdatedAt:
                          currentCenter.neededSupplyList![index].updatedAt!,
                      leading: Icon(
                        Icons.warning_amber_sharp,
                        color: currentCenter.neededSupplyList![index].urgency ==
                                "Low"
                            ? Colors.green
                            : currentCenter.neededSupplyList![index].urgency ==
                                    "Medium"
                                ? Colors.orange
                                : Colors.red,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            _showUpdateSupplyNeedDialog(context,
                                currentCenter.neededSupplyList![index]);
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
            _showNewSupplyDialog(context);
          },
          child: const Text("Add New"),
        )
      ],
    );
  }
}

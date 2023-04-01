import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/enums.dart';
import 'package:voluntracker/helper_functions.dart';
import 'package:voluntracker/models/help_center/busiest_hours_model.dart';
import 'package:voluntracker/models/help_center/create_help_center_model.dart';
import 'package:voluntracker/models/help_center/location_model.dart';
import 'package:voluntracker/models/help_center/open_close_info_model.dart';
import 'package:voluntracker/models/needed_volunteer/create_needed_volunteer_model.dart';
import 'package:voluntracker/models/needed_volunteer/needed_volunteer_model.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_text_field.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../models/help_center/help_center_model.dart';
import '../../models/needed_supply/create_needed_supply_model.dart';
import '../../models/needed_supply/needed_supply_model.dart';
import '../widgets/custom_dropdown_form_field.dart';
import '../widgets/custom_need_card.dart';
import '../widgets/custom_snackbars.dart';
import '../widgets/custom_text_form_field.dart';

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
        title: const FittedBox(
            fit: BoxFit.fitWidth, child: Text("Update Help Center Details")),
        centerTitle: true,
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                child: TabBar(
                  indicatorPadding: EdgeInsets.all(5),
                  tabs: [
                    Tab(
                      text: "Volunteer",
                    ),
                    Tab(
                      text: "Supply",
                    ),
                    Tab(
                      text: "Other Details",
                    )
                  ],
                ),
              ),
              Expanded(
                  child: BlocConsumer<HelpCenterCubit, HelpCenterState>(
                listener: (context, state) {
                  if (state is HelpCenterError) {
                    context.read<HelpCenterCubit>().getHelpCenters();
                    context.read<HelpCenterCubit>().getMyCenter();
                    CustomSnackbars.errorSnackbar(
                        context, state.title, state.description);
                  } else if (state is HelpCenterSuccess) {
                    context.read<HelpCenterCubit>().getHelpCenters();
                    context.read<HelpCenterCubit>().getMyCenter();
                    CustomSnackbars.successSnackbar(
                        context, state.title, state.description);
                  }
                },
                builder: (context, state) {
                  return TabBarView(children: [
                    _buildVolunteerNeeds(
                      context,
                      context.read<HelpCenterCubit>().myCenter!,
                    ),
                    _buildSupplyNeeds(
                        context, context.read<HelpCenterCubit>().myCenter!),
                    _buildOtherDetails(
                        context, context.read<HelpCenterCubit>().myCenter!)
                  ]);
                },
              ))
            ],
          )),
    );
  }

  Widget _buildVolunteerNeeds(
    BuildContext context,
    HelpCenterModel currentCenter,
  ) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: currentCenter.neededVolunteerList!.length,
                  itemBuilder: (context, index) {
                    return CustomNeedCard(
                      backgroundColor: currentCenter
                                  .neededVolunteerList![index].urgency ==
                              "Low"
                          ? Colors.green
                          : currentCenter.neededVolunteerList![index].urgency ==
                                  "Medium"
                              ? Colors.orange
                              : Colors.red,
                      needName: currentCenter
                          .neededVolunteerList![index].volunteerTypeName!,
                      needCategory: currentCenter
                          .neededVolunteerList![index].volunteerTypeCategory!,
                      quantity:
                          currentCenter.neededVolunteerList![index].quantity!,
                      lastUpdatedAt:
                          currentCenter.neededVolunteerList![index].updatedAt!,
                      trailing: IconButton(
                          onPressed: () {
                            _showUpdateVolunteerNeedDialog(
                              context,
                              currentCenter.neededVolunteerList![index],
                            );
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

  // Needed Volunteer methods
  void _showUpdateVolunteerNeedDialog(
    BuildContext context,
    NeededVolunteer oldModel,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
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
                    if (formKey.currentState!.validate()) {
                      context.read<HelpCenterCubit>().updateNeededVolunteer(
                          context.read<HelpCenterCubit>().newVolunteerNeed,
                          context.read<HelpCenterCubit>().myCenter!.id!,
                          oldModel.id!);
                      context.read<HelpCenterCubit>().newVolunteerNeed =
                          CreateNeededVolunteer();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"))
            ],
            content: _buildNeededVolunteerForm(
                formKey, "Update Volunteer Need", context, oldModel),
          );
        });
  }

  void _showNewVolunteerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
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
                    if (formKey.currentState!.validate()) {
                      context.read<HelpCenterCubit>().createNeededVolunteer(
                          context.read<HelpCenterCubit>().newVolunteerNeed,
                          context.read<HelpCenterCubit>().myCenter!.id!);
                      context.read<HelpCenterCubit>().newVolunteerNeed =
                          CreateNeededVolunteer();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add New Need"))
            ],
            content: _buildNeededVolunteerForm(
                formKey, "Create New Volunteer Need", context),
          );
        });
  }

  Form _buildNeededVolunteerForm(
      GlobalKey<FormState> formKey, String title, BuildContext context,
      [NeededVolunteer? oldModel]) {
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
              value: oldModel?.volunteerTypeCategory,
              list: context.read<HelpCenterCubit>().volunteerTypeCategory,
              label: "Category",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newVolunteerNeed
                    .volunteerTypeCategory = value;
              },
            ),
            CustomDropdownFormField(
              value: oldModel?.volunteerTypeName,
              list: context.read<HelpCenterCubit>().volunteerTypeNames,
              label: "Name",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newVolunteerNeed
                    .volunteerTypeName = value;
              },
            ),
            CustomDropdownFormField(
              value: oldModel?.urgency,
              list: urgency,
              label: "Urgency",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newVolunteerNeed.urgency =
                    value;
              },
            ),
            CustomFormField(
                value: oldModel?.quantity.toString(),
                hint: oldModel?.quantity.toString() ?? "50",
                label: "Quantity",
                onChanged: (value) {
                  context.read<HelpCenterCubit>().newVolunteerNeed.quantity =
                      int.tryParse(value);
                },
                customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Quantity cannot be blank";
                  }
                  if (isInt(value)) {
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
  Form _buildNeededSupplyForm(
      GlobalKey<FormState> formKey, String title, BuildContext context,
      [NeededSupply? oldModel]) {
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
              value: oldModel?.supplyTypeCategory,
              list: context.read<HelpCenterCubit>().supplyTypeCategory,
              label: "Category",
              onChanged: (value) {
                context
                    .read<HelpCenterCubit>()
                    .newSupplyNeed
                    .supplyTypeCategory = value;
              },
            ),
            CustomDropdownFormField(
              value: oldModel?.supplyTypeName,
              list: context.read<HelpCenterCubit>().supplyTypeNames,
              label: "Name",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newSupplyNeed.supplyTypeName =
                    value;
              },
            ),
            CustomDropdownFormField(
              value: oldModel?.urgency,
              list: urgency,
              label: "Urgency",
              onChanged: (value) {
                context.read<HelpCenterCubit>().newSupplyNeed.urgency = value;
              },
            ),
            CustomFormField(
                value: oldModel?.quantity.toString(),
                hint: oldModel?.quantity.toString() ?? "50",
                label: "Quantity",
                onChanged: (value) {
                  context.read<HelpCenterCubit>().newSupplyNeed.quantity =
                      int.tryParse(value);
                },
                customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Quantity cannot be blank";
                  }
                  if (isInt(value)) {
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
          final formKey = GlobalKey<FormState>();
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
                    if (formKey.currentState!.validate()) {
                      context.read<HelpCenterCubit>().createNeededSupply(
                          context.read<HelpCenterCubit>().newSupplyNeed,
                          context.read<HelpCenterCubit>().myCenter!.id!);
                      context.read<HelpCenterCubit>().newSupplyNeed =
                          CreateNeededSupply();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add New Need"))
            ],
            content: _buildNeededSupplyForm(
                formKey, "Create New Supply Need", context),
          );
        });
  }

  void _showUpdateSupplyNeedDialog(
      BuildContext context, NeededSupply oldModel) {
    showDialog(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
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
                    if (formKey.currentState!.validate()) {
                      context.read<HelpCenterCubit>().updateNeededSupply(
                          context.read<HelpCenterCubit>().newSupplyNeed,
                          context.read<HelpCenterCubit>().myCenter!.id!,
                          oldModel.id!);
                      context.read<HelpCenterCubit>().newSupplyNeed =
                          CreateNeededSupply();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"))
            ],
            content: _buildNeededSupplyForm(
                formKey, "Update Supply Need", context, oldModel),
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
                      backgroundColor: currentCenter
                                  .neededSupplyList![index].urgency ==
                              "Low"
                          ? Colors.green
                          : currentCenter.neededSupplyList![index].urgency ==
                                  "Medium"
                              ? Colors.orange
                              : Colors.red,
                      needName: currentCenter
                          .neededSupplyList![index].supplyTypeName!,
                      needCategory: currentCenter
                          .neededSupplyList![index].supplyTypeCategory!,
                      quantity:
                          currentCenter.neededSupplyList![index].quantity!,
                      lastUpdatedAt:
                          currentCenter.neededSupplyList![index].updatedAt!,
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
        // Align(
        //   alignment: Alignment.topRight,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       _showNewSupplyDialog(context);
        //     },
        //     child: const Icon(Icons.add),
        //   ),
        // ),
        ElevatedButton(
          onPressed: () {
            _showNewSupplyDialog(context);
          },
          child: const Text("Add New"),
        )
      ],
    );
  }

  Widget _buildOtherDetails(
      BuildContext context, HelpCenterModel currentCenter) {
    final formKey = GlobalKey<FormState>();
    context.read<HelpCenterCubit>().updateHelpCenter.name = currentCenter.name;
    context.read<HelpCenterCubit>().updateHelpCenter.additionalInfo =
        currentCenter.additionalInfo;
    context.read<HelpCenterCubit>().updateHelpCenter.busiestHours =
        currentCenter.busiestHours;
    context.read<HelpCenterCubit>().updateHelpCenter.contactInfo =
        currentCenter.contactInfo;
    context.read<HelpCenterCubit>().updateHelpCenter.location =
        currentCenter.location;
    context.read<HelpCenterCubit>().updateHelpCenter.openCloseInfo =
        currentCenter.openCloseInfo;
    context.read<HelpCenterCubit>().updateHelpCenter.volunteerCapacity =
        currentCenter.volunteerCapacity;
    context.read<HelpCenterCubit>().updateHelpCenter.city = currentCenter.city;
    context.read<HelpCenterCubit>().updateHelpCenter.country =
        currentCenter.country;

    return BlocBuilder<HelpCenterCubit, HelpCenterState>(
      builder: (context, state) {
        if (state is HelpCenterLoading) {
          return const Center(child: LoadingWidget());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _selectBHstart(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context
                                          .read<HelpCenterCubit>()
                                          .updateHelpCenter
                                          .busiestHours!
                                          .start ==
                                      null
                                  ? "Busiest Hours Start At: Press to select"
                                  : "Busiest Hours Start At: ${HelperFunctions.formatDateToTime(context.read<HelpCenterCubit>().updateHelpCenter.busiestHours!.start!)}"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.watch_later_outlined)
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _selectBHend(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context
                                          .read<HelpCenterCubit>()
                                          .updateHelpCenter
                                          .busiestHours!
                                          .end ==
                                      null
                                  ? "Busiest Hours End At: Press to select"
                                  : "Busiest Hours End At: ${HelperFunctions.formatDateToTime(context.read<HelpCenterCubit>().updateHelpCenter.busiestHours!.end!)}"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.watch_later_outlined)
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _selectOCopen(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context
                                          .read<HelpCenterCubit>()
                                          .updateHelpCenter
                                          .openCloseInfo!
                                          .start ==
                                      null
                                  ? "Help Center Opens At: Press to select"
                                  : "Help Center Opens At: ${HelperFunctions.formatDateToTime(context.read<HelpCenterCubit>().updateHelpCenter.openCloseInfo!.start!)}"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.watch_later_outlined)
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _selectOCend(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context
                                          .read<HelpCenterCubit>()
                                          .updateHelpCenter
                                          .openCloseInfo!
                                          .end ==
                                      null
                                  ? "Help Center Closes At: Press to select"
                                  : "Help Center Closes At: ${HelperFunctions.formatDateToTime(context.read<HelpCenterCubit>().updateHelpCenter.openCloseInfo!.end!)}"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.watch_later_outlined)
                            ],
                          )),
                      CustomTextFormField(
                        onChanged: (value) {
                          context
                              .read<HelpCenterCubit>()
                              .updateHelpCenter
                              .additionalInfo = value;
                        },
                        initialValue: currentCenter.additionalInfo!,
                        label: "Additional Info",
                      ),
                      CustomTextFormField(
                          customValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Volunteer Capacity cannot be blank";
                            }
                            if (isInt(value)) {
                              if (int.parse(value) > 0) {
                                return null;
                              } else {
                                return "Volunteer Capacity must be a number >= 0";
                              }
                            } else {
                              return "Volunteer Capacity must be a number => 0";
                            }
                          },
                          onChanged: (value) {
                            context
                                .read<HelpCenterCubit>()
                                .updateHelpCenter
                                .volunteerCapacity = int.tryParse(value);
                          },
                          initialValue:
                              currentCenter.volunteerCapacity.toString(),
                          label: "Volunteer Capacity"),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<HelpCenterCubit>()
                                  .updateOtherDetails(
                                      context
                                          .read<HelpCenterCubit>()
                                          .updateHelpCenter,
                                      currentCenter.id!);
                            }
                          },
                          child: const Text("Update"))
                    ],
                  ),
                )),
          );
        }
      },
    );
  }

  Future<void> _selectBHstart(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    DateTime ocEnd =
        DateTime(2023, 3, 24, selectedTime!.hour, selectedTime.minute);
    context.read<HelpCenterCubit>().updateHelpCenter.busiestHours!.start =
        ocEnd.toIso8601String();
  }

  Future<void> _selectBHend(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    DateTime bhEnd =
        DateTime(2023, 3, 24, selectedTime!.hour, selectedTime.minute);
    context.read<HelpCenterCubit>().updateHelpCenter.busiestHours!.end =
        bhEnd.toIso8601String();
  }

  Future<void> _selectOCopen(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    DateTime ocStart =
        DateTime(2023, 3, 24, selectedTime!.hour, selectedTime.minute);
    context.read<HelpCenterCubit>().updateHelpCenter.openCloseInfo!.start =
        ocStart.toIso8601String();
  }

  Future<void> _selectOCend(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    DateTime ocEnd =
        DateTime(2023, 3, 24, selectedTime!.hour, selectedTime.minute);
    context.read<HelpCenterCubit>().updateHelpCenter.openCloseInfo!.end =
        ocEnd.toIso8601String();
  }
}

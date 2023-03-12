import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/models/help_center/busiest_hours_model.dart';
import 'package:afet_takip/models/help_center/contact_info_model.dart';
import 'package:afet_takip/models/help_center/create_help_center_model.dart';
import 'package:afet_takip/models/help_center/location_model.dart';
import 'package:afet_takip/models/help_center/open_close_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class CreateHelpCenterScreen extends StatefulWidget {
  const CreateHelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<CreateHelpCenterScreen> createState() => _CreateHelpCenterScreenState();
}

class _CreateHelpCenterScreenState extends State<CreateHelpCenterScreen> {
  final _formKey = GlobalKey<FormState>();
  final CreateHelpCenter newCenter = CreateHelpCenter(
      location: Location(),
      busiestHours: BusiestHours(),
      openCloseInfo: OpenCloseInfo(),
      contactInfo: ContactInfo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create New Help Center"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomFormField(
                    label: "Name",
                    hint: "Name",
                    onChanged: (value) {
                      newCenter.name = value;
                    },
                  ),
                  CustomFormField(
                    label: "Adress",
                    hint: "Adress",
                    onChanged: (value) {
                      newCenter.contactInfo!.address = value;
                    },
                  ),
                  CustomFormField(
                    label: "Latitude",
                    hint: "Latitude",
                    onChanged: (value) {
                      newCenter.location!.lat = double.tryParse(value);
                    },
                    customValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Latitude cannot be blank";
                      } else if (!isFloat(value)) {
                        return "Longitude should be a number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomFormField(
                    label: "Longitude",
                    hint: "Longitude",
                    customValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Longitude cannot be blank";
                      } else if (!isFloat(value)) {
                        return "Longitude should be a number";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      newCenter.location!.lon = double.tryParse(value);
                    },
                  ),
                  CustomFormField(
                    label: "Busiest Hours Start At",
                    hint: "Busiest Hours Start At",
                    onChanged: (value) {
                      newCenter.busiestHours!.start = value;
                    },
                  ),
                  CustomFormField(
                    label: "Busiest Hours End At",
                    hint: "Busiest Hours End At",
                    onChanged: (value) {
                      newCenter.busiestHours!.end = value;
                    },
                  ),
                  CustomFormField(
                    label: "Help Center Opens At",
                    hint: "Help Center Opens At",
                    onChanged: (value) {
                      newCenter.openCloseInfo!.start = value;
                    },
                  ),
                  CustomFormField(
                    label: "Help Center Closes At",
                    hint: "Help Center Closes At",
                    onChanged: (value) {
                      newCenter.openCloseInfo!.end = value;
                    },
                  ),
                  CustomFormField(
                    label: "E-mail",
                    hint: "E-mail",
                    onChanged: (value) {
                      newCenter.contactInfo!.email = value;
                    },
                    customValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "E-mail cannot be blank";
                      } else if (!isEmail(value)) {
                        return "Please enter a valid e-mail adress";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomFormField(
                    label: "Phone",
                    hint: "Phone",
                    onChanged: (value) {
                      newCenter.contactInfo!.phone = value;
                    },
                  ),
                  CustomFormField(
                    label: "Additional Info",
                    hint: "Additional Info",
                    onChanged: (value) {
                      newCenter.additionalInfo = value;
                    },
                  ),
                  CustomFormField(
                    label: "Volunteer Capacity",
                    hint: "Volunteer Capacity",
                    onChanged: (value) {
                      newCenter.volunteerCapacity = int.tryParse(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Sending");
                          context
                              .read<HelpCenterCubit>()
                              .createHelpCenter(newCenter);
                          print("sent");
                        }
                        print("not valid");
                      },
                      child: Text("Submit"))
                ],
              ),
            )),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.hint,
      required this.label,
      this.customValidator,
      this.onChanged});
  final String hint;
  final String label;
  final String? Function(String?)? customValidator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            border: const OutlineInputBorder()),
        validator: customValidator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "$label cannot be blank";
              }
              return null;
            },
      ),
    );
  }
}

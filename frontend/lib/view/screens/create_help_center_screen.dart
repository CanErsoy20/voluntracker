import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/models/help_center/busiest_hours_model.dart';
import 'package:afet_takip/models/help_center/contact_info_model.dart';
import 'package:afet_takip/models/help_center/create_help_center_model.dart';
import 'package:afet_takip/models/help_center/location_model.dart';
import 'package:afet_takip/models/help_center/open_close_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../widgets/custom_text_field.dart';

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
                    hint: "Ex: Ahmet Taner Kışlalı Spor Salonu",
                    onChanged: (value) {
                      newCenter.name = value;
                    },
                  ),
                  CustomFormField(
                    label: "Adress",
                    hint: "Ex: Koru, 2580. Sk. No:2, 06810 Yenimahalle/Ankara",
                    onChanged: (value) {
                      newCenter.contactInfo!.address = value;
                    },
                  ),
                  CustomFormField(
                    label: "Latitude",
                    hint: "Ex: 39.88",
                    onChanged: (value) {
                      newCenter.location!.lat = double.tryParse(value);
                    },
                    customValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Latitude cannot be blank";
                      } else if (!isFloat(value)) {
                        return "Latitude should be a number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomFormField(
                    label: "Longitude",
                    hint: "Ex: 32.68",
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
                    hint: "Ex: 12:00",
                    onChanged: (value) {
                      newCenter.busiestHours!.start = value;
                    },
                  ),
                  CustomFormField(
                    label: "Busiest Hours End At",
                    hint: "Ex: 16:00",
                    onChanged: (value) {
                      newCenter.busiestHours!.end = value;
                    },
                  ),
                  CustomFormField(
                    label: "Help Center Opens At",
                    hint: "Ex: 8:00",
                    onChanged: (value) {
                      newCenter.openCloseInfo!.start = value;
                    },
                  ),
                  CustomFormField(
                    label: "Help Center Closes At",
                    hint: "23:00",
                    onChanged: (value) {
                      newCenter.openCloseInfo!.end = value;
                    },
                  ),
                  CustomFormField(
                    label: "E-mail",
                    hint: "Ex: examle@gmail.com",
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
                    hint: "Ex: This help center distributes...",
                    onChanged: (value) {
                      newCenter.additionalInfo = value;
                    },
                  ),
                  CustomFormField(
                    label: "Volunteer Capacity",
                    hint: "Ex: 250",
                    onChanged: (value) {
                      newCenter.volunteerCapacity = int.tryParse(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<HelpCenterCubit>()
                              .createHelpCenter(newCenter);
                        }
                      },
                      child: const Text("Add New Help Center"))
                ],
              ),
            )),
      ),
    );
  }
}

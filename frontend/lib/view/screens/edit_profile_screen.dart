import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';

import '../../cubit/profile/profile_cubit.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_snackbars.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editing My Profile"),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            CustomSnackbars.successSnackbar(
                context, state.title, state.description);
            context.read<ProfileCubit>().emitDisplay();
          } else if (state is ProfileError) {
            CustomSnackbars.errorSnackbar(
                context, state.title, state.description);
            context.read<ProfileCubit>().emitDisplay();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: LoadingWidget());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileCubit>().pickImage();
                        },
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              UserInfo.loggedUser!.profileImageUrl != ""
                                  ? NetworkImage(
                                      UserInfo.loggedUser!.profileImageUrl!)
                                  : null,
                          child: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Change Button
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfileCubit>().pickImage();
                        },
                        child: const Text("Upload"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      CustomTextFormField(
                        label: 'First Name',
                        initialValue: UserInfo.loggedUser!.firstname ?? "",
                        prefixIcon: Icon(Icons.badge,
                            size: 24.0, color: Colors.grey[600]),
                      ),
                      CustomTextFormField(
                        label: 'Surname',
                        initialValue: UserInfo.loggedUser!.surname ?? "",
                        prefixIcon: Icon(Icons.badge,
                            size: 24.0, color: Colors.grey[600]),
                      ),
                      CustomTextFormField(
                        label: "Email",
                        initialValue: UserInfo.loggedUser!.email ?? "",
                        prefixIcon: Icon(Icons.email,
                            size: 24.0, color: Colors.grey[600]),
                      ),
                      CustomTextFormField(
                        label: "Phone",
                        initialValue: UserInfo.loggedUser!.phone ?? "",
                        prefixIcon: Icon(Icons.phone,
                            size: 24.0, color: Colors.grey[600]),
                      ),

                      const SizedBox(height: 16.0),
                      // Change Password Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.changePassword);
                        },
                        child: const Text("Change Password"),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

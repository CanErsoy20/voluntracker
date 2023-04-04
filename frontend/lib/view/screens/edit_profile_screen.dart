import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
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

  Future pickImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _imageFile = File(value!.path);
      });
      uploadImage();
      faceDetectImage();
    });
  }

  Future<void> faceDetectImage() async {
    print("Face Detecting");
    if (_imageFile == null) {
      print("Image is null");
      return;
    }
    print("Detecting image");
    final inputImage = InputImage.fromFile(_imageFile!);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    String text = 'Detected ${faces.length} faces';
    print(text);
    // for (Face face in faces) {
    //   final Rect boundingBox = face.boundingBox;

    //   final double? rotX = face.headEulerAngleX; // Head is tilted up and down rotX degrees
    //   final double? rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
    //   final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

    //   // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
    //   // eyes, cheeks, and nose available):
    //   final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
    //   if (leftEar != null) {
    //     final Point<int> leftEarPos = leftEar.position;
    //   }

    //   // If classification was enabled with FaceDetectorOptions:
    //   if (face.smilingProbability != null) {
    //     final double? smileProb = face.smilingProbability;
    //   }

    //   // If face tracking was enabled with FaceDetectorOptions:
    //   if (face.trackingId != null) {
    //     final int? id = face.trackingId;
    //   }
    // }
    // print("Detected faces: $text");
  }

  Future uploadImage() async {
    String fileName = _imageFile!.path.split('/').last;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => print('Image uploaded to Firebase Storage'));
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _downloadUrl = url;
    });

    print("URL: $_downloadUrl");
    // TODO: Bu url'yi selim'e gonder
  }
}

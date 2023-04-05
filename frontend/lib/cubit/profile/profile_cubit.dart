import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voluntracker/models/add_profile_pic.dart';
import 'package:voluntracker/models/user/user_info.dart';

import '../../services/profile_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.service) : super(ProfileInitial());
  ProfileService service;
  ImagePicker picker = ImagePicker();
  File? imageFile;
  String? downloadUrl;

  void showToast(String message){
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<String> pickImage() async {
    File file = await picker.pickImage(source: ImageSource.gallery).then((value) {
      return File(value!.path);
    });
    if(file == null){
      print("File is null");
      showToast("File is not found");
      return "File is not found";
    }
    String message = await faceDetectImage(file);
    if(imageFile == null){
      showToast(message);
      return message;
    }
    showToast(message);
    await uploadImage();
    return message;
  }

  Future<String> faceDetectImage(File file) async {
    print("Face Detecting");
    if (file == null) {
      print("Image is null");
      return "Error! Image is not found";
    }
    print("Detecting image");
    final inputImage = InputImage.fromFile(file!);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if(faces.length == 0){
      print("No faces detected");
      return "Error! No faces detected";
    }else if(faces.length == 1){
      print("One face detected");
      imageFile = file;
      return "Success! One face detected";
    }else {
      print("Error! More than one face detected");
      return "Error! More than one face detected";
    }
  }

  Future uploadImage() async {
    String fileName = imageFile!.path.split('/').last;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => print('Image uploaded to Firebase Storage'));
    String url = await taskSnapshot.ref.getDownloadURL();

    downloadUrl = url;

    updateProfileImage(downloadUrl ?? "");
  }

  Future<void> updateProfileImage(String newUrl) async {
    emit(ProfileLoading());
    AddProfileImageModel bodyModel = AddProfileImageModel();
    bodyModel.imageUrl = newUrl;
    bodyModel.userId = UserInfo.loggedUser!.id!;
    String? response = await service.updateProfilePicture(bodyModel);
    if (response == null || response == '') {
      emit(ProfileError("Update Failed", "Could not update profile image"));
    } else {
      emit(ProfileSuccess(
          "Successfully Updated", "Profile image successfully updated"));
    }
  }

  void emitDisplay() {
    emit(ProfileDisplay());
  }
}

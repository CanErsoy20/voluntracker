import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future pickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      imageFile = File(value!.path);

      uploadImage();
      //faceDetectImage();
    });
  }

  // Future<void> faceDetectImage() async {
  //   print("Face Detecting");
  //   if (imageFile == null) {
  //     print("Image is null");
  //     return;
  //   }
  //   print("Detecting image");
  //   final inputImage = InputImage.fromFile(imageFile!);
  //   final options = FaceDetectorOptions();
  //   final faceDetector = FaceDetector(options: options);
  //   final List<Face> faces = await faceDetector.processImage(inputImage);
  //   String text = 'Detected ${faces.length} faces';
  //   print(text);
  // }

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

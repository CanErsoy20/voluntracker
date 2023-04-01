import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voluntracker/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';

import '../../models/user/user_info.dart';

class EditProfileScreen extends StatefulWidget {
  
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _picker = ImagePicker();
  File? _imageFile;
  String? _downloadUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editing My Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    radius: 40.0,
                    
                    backgroundImage:
                      _downloadUrl != null ? NetworkImage(_downloadUrl!) :
                        const NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Change Button
                ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text("Upload"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  buildProfileInfoRow(Icons.badge, 'First Name',
                      UserInfo.loggedUser!.firstname ?? ""),
                  buildProfileInfoRow(Icons.badge, 'Last Name',
                      UserInfo.loggedUser!.surname ?? ""),
                  buildProfileInfoRow(
                      Icons.email, 'Email', UserInfo.loggedUser!.email ?? ""),
                  buildProfileInfoRow(
                      Icons.phone, 'Phone', UserInfo.loggedUser!.phone ?? ""),
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
          ),
        ],
      ),
    );
  }

  
  Future pickImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _imageFile = File(value!.path);
      });
      uploadImage();
    });
  }

  Future uploadImage() async {
    String fileName = _imageFile!.path.split('/').last;
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('Image uploaded to Firebase Storage'));
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _downloadUrl = url;
    });

    print("URL: $_downloadUrl");
    // TODO: Bu url'yi selim'e gonder
  }

  Widget buildProfileInfoRow(IconData iconData, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 24.0, color: Colors.grey[600]),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: title,
                  initialValue: subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

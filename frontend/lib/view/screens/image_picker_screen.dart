import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  final picker = ImagePicker();



  Future pickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {

      setState(() {
        _imageFile = File(value!.path);
      });
    });
  }

  Future uploadImage() async {
    String fileName = _imageFile!.path.split('/').last;
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('Image uploaded to Firebase Storage'));
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print("URL: $downloadUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(
                    _imageFile!,
                    height: 200,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
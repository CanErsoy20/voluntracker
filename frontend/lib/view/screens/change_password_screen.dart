import 'package:flutter/material.dart';
import 'package:voluntracker/models/user/user_info.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Change Password"),
          ),
        ),
      endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              label: "Current Password",
              controller: _currentPasswordController,
              isObscure: true,
              customValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your current password';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              label: "New Password",
              controller: _newPasswordController,
              isObscure: true,
              customValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your new password';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              label: "Confirm New Password",
              controller: _confirmPasswordController,
              isObscure: true,
              customValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement change password functionality
                },
                child: Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

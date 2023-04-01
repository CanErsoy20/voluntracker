import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:voluntracker/models/user/user_info.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Forgot Password"),
        ),
      ),
      endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Please enter your email address below to reset your password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              label: "Email Address",
              hint: "Enter your email address",
              controller: _emailController,
              customValidator: (value) {
                if (value!.isEmpty) {
                  return 'Email address cannot be blank';
                }
                if (!isEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement forgot password functionality
                },
                child: const Text('Reset Password'),
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

import 'package:voluntracker/cubit/help_centers/help_center_cubit.dart';
import 'package:voluntracker/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo at the top
          const Padding(
            padding: EdgeInsets.all(20),
            // child: Image.asset('assets/logo.png'),
          ),

          // Catchphrase to encourage volunteering
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Join us to make a difference!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Sign in / Login text
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Please sign in or login to have full access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),

          // Continue as guest text
          GestureDetector(
            onTap: () {
              context.read<HelpCenterCubit>().getHelpCenters();
              Navigator.pushNamed(context, Routes.helpCenterList);
            },
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Or continue as guest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

          // Buttons at the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left button
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginRoute);
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Right button
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerRoute);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
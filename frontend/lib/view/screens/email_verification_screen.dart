import 'package:voluntracker/cubit/sign_up/sign_up_cubit.dart';
import 'package:voluntracker/models/confirm_email_model.dart';
import 'package:voluntracker/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

import '../../models/user/user_info.dart';
import '../widgets/custom_snackbars.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  int _secondsRemaining = 30;
  bool _isResendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isResendButtonEnabled = false;
    _secondsRemaining = 30;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _isResendButtonEnabled = true;
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _resendCode() {
    // Resend the verification code here
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          CustomSnackbars.successSnackbar(
              context, state.title, state.description);
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.loginRoute);
        } else if (state is SignUpError) {
          CustomSnackbars.errorSnackbar(
              context, state.title, state.description);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Email Verification'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Enter the 6-digit verification code sent to your email',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              Pinput(
                length: 6,
                onCompleted: (value) {
                  ConfirmEmailModel confirmEmailModel = ConfirmEmailModel();
                  confirmEmailModel.email =
                      context.read<SignUpCubit>().signUpModel.user!.email;
                  confirmEmailModel.code = value;
                  context.read<SignUpCubit>().confirmEmail(confirmEmailModel);
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend code in $_secondsRemaining seconds',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: _isResendButtonEnabled ? _resendCode : null,
                    child: const Text('Resend'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCodeDigitTextField(int index) {
  //   return SizedBox(
  //     width: 50.0,
  //     child: TextField(
  //       controller: _codeControllers[index],
  //       textAlign: TextAlign.center,
  //       keyboardType: TextInputType.number,
  //       maxLength: 1,
  //       style: const TextStyle(color: Colors.white),
  //       decoration: InputDecoration(
  //         counterText: '',
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //         ),
  //       ),
  //       onChanged: (value) {
  //         setState(() {
  //           _isCodeValid = _codeControllers.every((controller) =>
  //               controller.text.isNotEmpty && controller.text.length == 1);
  //         });
  //         if (value.isNotEmpty) {
  //           if (index < 5) {
  //             FocusScope.of(context).nextFocus();
  //           } else {
  //             FocusScope.of(context).unfocus();
  //           }
  //         } else {
  //           if (index > 0) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         }
  //       },
  //     ),
  //   );
  // }
}

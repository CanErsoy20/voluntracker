import 'package:flutter/material.dart';
import 'dart:async';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  List<TextEditingController> _codeControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isCodeValid = false;
  int _secondsRemaining = 30;
  bool _isResendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _codeControllers.forEach((controller) => controller.dispose());
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCodeDigitTextField(0),
                _buildCodeDigitTextField(1),
                _buildCodeDigitTextField(2),
                _buildCodeDigitTextField(3),
                _buildCodeDigitTextField(4),
                _buildCodeDigitTextField(5),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isCodeValid
                  ? () {
                      // TODO: Verify the code here
                      // If the code is valid, navigate to the next screen
                    }
                  : null,
              child: const Text('Verify'),
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
    );
  }

  Widget _buildCodeDigitTextField(int index) {
    return SizedBox(
      width: 50.0,
      child: TextField(
        controller: _codeControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _isCodeValid = _codeControllers.every((controller) =>
                controller.text.isNotEmpty && controller.text.length == 1);
          });
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            if (index > 0) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }
}
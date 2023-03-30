import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  List<String> _code = List.filled(6, '');
  bool _isCodeValid = false;

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
                      // Verify the code here
                      // If the code is valid, navigate to the next screen
                    }
                  : null,
              child: const Text('Verify'),
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
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {
            _code[index] = value;
            _isCodeValid = _code.every((digit) => digit.isNotEmpty);
          });
        },
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
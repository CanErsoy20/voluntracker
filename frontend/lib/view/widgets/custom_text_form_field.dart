import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.initialValue,
    required this.label,
    this.hint,
    this.isObscure,
    this.onChanged,
    this.suffixIcon,
    this.customValidator,
    this.enabled,
    super.key,
  });

  final String? Function(String?)? customValidator;
  bool? enabled = true;
  String initialValue;
  String label;
  String? hint;
  bool? isObscure;
  Widget? suffixIcon;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 2,
          ),
          TextFormField(
            obscureText: isObscure ?? false,
            onChanged: onChanged,
            validator: customValidator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return "$label cannot be blank";
                  }
                  return null;
                },
            enabled: enabled,
            initialValue: initialValue,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              // labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      ),
    );
  }
}

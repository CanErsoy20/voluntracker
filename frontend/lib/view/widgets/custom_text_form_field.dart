import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.label,
    this.initialValue,
    this.hint,
    this.isObscure,
    this.maxLines,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.customValidator,
    this.enabled,
    super.key,
  });

  final String? Function(String?)? customValidator;
  bool? enabled = true;
  String? initialValue;
  String label;
  String? hint;
  int? maxLines;
  bool? isObscure;
  Widget? suffixIcon;
  TextEditingController? controller;
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
            controller: controller,
            maxLines: maxLines ?? 1,
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

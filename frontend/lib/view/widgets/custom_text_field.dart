import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.hint,
      required this.label,
      this.customValidator,
      this.onChanged});
  final String hint;
  final String label;
  final String? Function(String?)? customValidator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            border: const OutlineInputBorder()),
        validator: customValidator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "$label cannot be blank";
              }
              return null;
            },
      ),
    );
  }
}

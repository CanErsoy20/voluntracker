import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.initialValue,
    required this.label,
    this.onChanged,
    this.customValidator,
    this.enabled,
    super.key,
  });

  final String? Function(String?)? customValidator;
  bool? enabled = true;
  String initialValue;
  String label;
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
          SizedBox(
            height: 2,
          ),
          TextFormField(
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
              filled: true,
              fillColor: Colors.white,
              // labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

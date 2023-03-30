import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.hint,
      required this.label,
      this.customValidator,
      this.value,
      this.labelColor,
      this.maxLines,
      this.onChanged});
  final String hint;
  final String label;
  final Color? labelColor;
  final String? Function(String?)? customValidator;
  final void Function(String)? onChanged;
  final String? value;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: labelColor ?? Colors.white),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            maxLines: maxLines ?? 1,
            initialValue: value,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                errorMaxLines: 3,
                // labelText: label,
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder()),
            validator: customValidator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return "$label cannot be blank";
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}

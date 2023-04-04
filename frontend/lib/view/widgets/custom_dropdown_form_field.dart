import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField(
      {super.key,
      required this.list,
      required this.label,
      required this.onChanged,
      this.validator,
      this.value});
  final String label;
  final List<String> list;
  final void Function(String?)? onChanged;
  final String? value;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        validator: validator,
        value: value,
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            errorMaxLines: 5),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

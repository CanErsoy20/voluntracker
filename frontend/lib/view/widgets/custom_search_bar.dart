import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    required this.controller,
    required this.onChanged,
    this.suffixIcon,
    this.hint,
    super.key,
  });
  TextEditingController controller = TextEditingController();
  void Function(String)? onChanged;
  Widget? suffixIcon;
  String? hint;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.4,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: hint,
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
              ))),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    required this.controller,
    required this.onChanged,
    super.key,
  });
  TextEditingController controller = TextEditingController();
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              decoration: const InputDecoration(
                suffixIconColor: Colors.grey,
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ))),
    );
  }
}

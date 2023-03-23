import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
          child: TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), border: InputBorder.none))),
    );
  }
}

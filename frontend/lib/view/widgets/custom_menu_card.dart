import 'package:flutter/material.dart';

class CustomMenuCard extends StatelessWidget {
  final String title;

  CustomMenuCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Add your onTap functionality here
          print("Card $title tapped");
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
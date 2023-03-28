import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 109, 131, 155),
              Color.fromARGB(255, 27, 64, 105),
              Color.fromARGB(255, 2, 7, 13)
            ])),
        child: const Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({
    this.radius,
    this.height,
    this.width,
    this.iconSize,
    this.color,
    super.key,
  });
  double? radius;
  double? height;
  double? width;
  double? iconSize;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 50,
      backgroundColor: Colors.transparent,
      child: Container(
        height: height ?? 80,
        width: width ?? 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: color,
            gradient: color != null
                ? null
                : const LinearGradient(colors: [
                    Color.fromARGB(255, 109, 131, 155),
                    Color.fromARGB(255, 27, 64, 105),
                    Color.fromARGB(255, 2, 7, 13)
                  ])),
        child: Icon(
          Icons.person,
          size: iconSize ?? 50,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({
    this.radius,
    this.height,
    this.width,
    this.iconSize,
    this.color,
    this.url,
    super.key,
  });
  double? radius;
  double? height;
  double? width;
  double? iconSize;
  Color? color;
  String? url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 50,
      backgroundColor: Colors.transparent,
      backgroundImage: url != null ? NetworkImage(url!) : null,
      child: Container(
        height: height ?? 80,
        width: width ?? 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: url == null
            ? Icon(
                Icons.person,
                size: iconSize ?? 50,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

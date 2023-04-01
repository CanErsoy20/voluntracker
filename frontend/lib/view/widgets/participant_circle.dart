import 'package:voluntracker/view/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class ParticipantCircleAvatar extends StatelessWidget {
  ParticipantCircleAvatar({this.name, this.onClosePressed, super.key});
  String? name;
  void Function()? onClosePressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          ProfileAvatar(
            color: Color.fromARGB(255, 171, 127, 127),
          ),
          Positioned(
              top: 10,
              left: 65,
              child: Stack(children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: -12,
                  right: -12,
                  child: IconButton(
                    onPressed: onClosePressed ?? () {},
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
              ])),
        ]),
        Text(
          name ?? "No name",
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }
}

import 'package:afet_takip/view/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ParticipantCircleAvatar extends StatelessWidget {
  const ParticipantCircleAvatar({super.key});

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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
              ])),
        ]),
        Text(
          "Name",
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }
}

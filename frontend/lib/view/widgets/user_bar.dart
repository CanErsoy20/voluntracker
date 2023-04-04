import 'package:voluntracker/models/user/user_model.dart';
import 'package:voluntracker/router.dart';
import 'package:flutter/material.dart';

import '../../models/user/user_info.dart';

class UserBar extends StatelessWidget {
  final UserModel user;

  UserBar({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.profile);
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image:
                      AssetImage("assets/images/user_banner_background.png"))),
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: user.profileImageUrl != ""
                      ? NetworkImage(UserInfo.loggedUser!.profileImageUrl!)
                      : null,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.firstname} ${user.surname}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.getHighestRole(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.volunteer!.team == null
                          ? "Team: You are not assigned to any team yet"
                          : "Team: ${user.volunteer!.team!.teamName}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

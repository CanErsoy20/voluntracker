import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/router.dart';
import 'package:flutter/material.dart';

class VolunteerList extends StatelessWidget {
  final List<VolunteerTeam> volunteerTeams;

  VolunteerList({required this.volunteerTeams});

  @override
  Widget build(BuildContext context) {
    if (volunteerTeams.isNotEmpty) {
      return Container(
        color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: volunteerTeams.length,
          itemBuilder: (context, index) {
            final volunteerTeam = volunteerTeams[index];
            return ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(volunteerTeam.teamName!),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.addTeam);
                      },
                      child: const Text("Add Member"))
                ],
              ),
              children: volunteerTeam.volunteers != null
                  ? _buildVolunteerList(volunteerTeam.volunteers!)
                  : [
                      const Text(
                        "There are no volunteers in this team at the moment",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
            );
          },
        ),
      );
    } else {
      return Center(
        child: Text(
          "No volunteer team found.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  List<Widget> _buildVolunteerList(List<Volunteer> volunteers) {
    if (volunteers.isNotEmpty) {
      return volunteers
          .map((volunteer) => ListTile(
                leading: CircleAvatar(),
                title: Text(
                    "${volunteer.user?.firstname} ${volunteer.user?.surname}}"),
                subtitle: Text("${volunteer.user?.getHighestRole()}"),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ))
          .toList();
    } else {
      return [];
    }
  }
}

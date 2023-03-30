import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:flutter/material.dart';


class VolunteerList extends StatelessWidget {
  final List<VolunteerTeam> volunteerTeams;

  VolunteerList({required this.volunteerTeams});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: volunteerTeams.length,
        itemBuilder: (context, index) {
          final volunteerTeam = volunteerTeams[index];
          return ExpansionTile(
            title: Text(volunteerTeam.teamName!),
            children: _buildVolunteerList(volunteerTeam.volunteers!),
          );
        },
      ),
    );
  }

  List<Widget> _buildVolunteerList(List<Volunteer> volunteers) {
    return volunteers.map((volunteer) => ListTile(
      leading: CircleAvatar(
        // backgroundImage: AssetImage(volunteer.image!),
      ),
      title: Text("${volunteer.user?.firstname} ${volunteer.user?.surname}}"),
      subtitle: Text("${volunteer.user?.getHighestRole()}"),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
    )).toList();
  }
}
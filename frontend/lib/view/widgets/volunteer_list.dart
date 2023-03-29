import 'package:afet_takip/models/volunteer_model.dart';
import 'package:flutter/material.dart';


class VolunteerList extends StatelessWidget {
  final List<Volunteer> volunteers;

  VolunteerList({required this.volunteers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: volunteers.length,
      itemBuilder: (context, index) {
        final volunteer = volunteers[index];
        return ListTile(
          leading: CircleAvatar(
            // backgroundImage: AssetImage(volunteer.image!),
          ),
          title: Text("${volunteer.user?.firstname} ${volunteer.user?.surname}}"),
          subtitle: Text("${volunteer.user?.getHighestRole()}"), 
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
import 'package:voluntracker/cubit/team/team_cubit.dart';
import 'package:voluntracker/models/volunteer_team_model.dart';
import 'package:voluntracker/models/volunteer_model.dart';
import 'package:voluntracker/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/help_centers/help_center_cubit.dart';

class VolunteerTeamList extends StatelessWidget {
  const VolunteerTeamList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpCenterCubit, HelpCenterState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: context
                .read<HelpCenterCubit>()
                .myCenter!
                .volunteerTeams!
                .length,
            itemBuilder: (context, index) {
              VolunteerTeam currentVolunteerTeam = context
                  .read<HelpCenterCubit>()
                  .myCenter!
                  .volunteerTeams![index];

              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${currentVolunteerTeam.teamName!} (${currentVolunteerTeam.volunteers?.length ?? 0})"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.addToTeam);
                          context.read<TeamCubit>().selectedTeam =
                              currentVolunteerTeam;
                          context.read<TeamCubit>().selectedTeamIndex = index;
                        },
                        child: const Text("Add Member"))
                  ],
                ),
                children: (currentVolunteerTeam.volunteers != null &&
                        currentVolunteerTeam.volunteers!.isNotEmpty)
                    ? _buildVolunteerList(currentVolunteerTeam.volunteers!)
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
      },
    );
  }

  List<Widget> _buildVolunteerList(List<Volunteer> volunteers) {
    if (volunteers.isNotEmpty) {
      return volunteers
          .map((volunteer) => ListTile(
              leading: CircleAvatar(),
              title: Text(
                  "${volunteer.user?.firstname} ${volunteer.user?.surname}"),
              subtitle: Text("${volunteer.user?.getHighestRole()}"),
              trailing: PopupMenuButton(
                itemBuilder: (contex) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: const Text("Remove from team"),
                      onTap: () {
                        // remove isteği at
                      },
                    ),
                  ];
                },
                position: PopupMenuPosition.over,
              )))
          .toList();
    } else {
      return [];
    }
  }
}
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/models/volunteer_team_model.dart';

class VolunteerTeamLeader {
  int? id;
  Volunteer? volunteer;
  VolunteerTeam? volunteerTeam;

  VolunteerTeamLeader({this.id, this.volunteer, this.volunteerTeam});

  VolunteerTeamLeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volunteer = json['volunteer'] != null
        ? Volunteer.fromJson(json['volunteer'])
        : null;
    volunteerTeam = json['volunteerTeam'] != null
        ? VolunteerTeam.fromJson(json['volunteerTeam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (volunteer != null) {
      data['volunteer'] = volunteer!.toJson();
    }
    if (volunteerTeam != null) {
      data['volunteerTeam'] = volunteerTeam!.toJson();
    }
    return data;
  }
}
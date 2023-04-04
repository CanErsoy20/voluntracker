import 'package:voluntracker/models/volunteer_model.dart';
import 'package:voluntracker/models/volunteer_team_model.dart';

class VolunteerTeamLeader {
  int? id;
  int? volunteerId;
  int? volunteerTeamId;

  VolunteerTeamLeader({this.id, this.volunteerId, this.volunteerTeamId});

  VolunteerTeamLeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volunteerId = json['volunteer'];
    volunteerTeamId = json['volunteerTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (volunteerId != null) {
      data['volunteer'] = volunteerId;
    }
    if (volunteerTeamId != null) {
      data['volunteerTeam'] = volunteerTeamId;
    }
    return data;
  }
}

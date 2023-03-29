import 'package:afet_takip/models/help_center/help_center_model.dart';
import 'package:afet_takip/models/volunter_team_leader_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';

class VolunteerTeam {
  int? id;
  String? teamName;
  HelpCenterModel? helpCenter;
  VolunteerTeamLeader? volunteerTeamLeader;
  List<Volunteer>? volunteers;
  String? createdAt;
  String? updatedAt;
  
  VolunteerTeam({
    this.id,
    this.teamName,
    this.helpCenter,
    this.volunteerTeamLeader,
    this.volunteers,
    this.createdAt,
    this.updatedAt,
  });

  VolunteerTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['teamName'];
    helpCenter = json['helpCenter'] != null
        ? HelpCenterModel.fromJson(json['helpCenter'])
        : null;
    
    volunteerTeamLeader = json['volunteerTeamLeader'] != null
        ? VolunteerTeamLeader.fromJson(json['volunteerTeamLeader'])
        : null;
    
    if (json['volunteers'] != null) {
      volunteers = <Volunteer>[];
      json['volunteers'].forEach((v) {
        volunteers!.add(Volunteer.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teamName'] = teamName;
    if (helpCenter != null) {
      data['helpCenter'] = helpCenter!.toJson();
    }
    if (volunteerTeamLeader != null) {
      data['volunteerTeamLeader'] = volunteerTeamLeader!.toJson();
    }
    if (volunteers != null) {
      data['volunteers'] = volunteers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

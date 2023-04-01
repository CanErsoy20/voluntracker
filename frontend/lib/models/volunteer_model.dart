import 'package:voluntracker/models/user/user_model.dart';
import 'package:voluntracker/models/volunteer_team_model.dart';

class Volunteer {
  int? id;
  int? userId;
  UserModel? user;
  String? volunteerTypeName;
  String? volunteerTypeCategory;
  String? image;
  VolunteerTeam? team;
  int? volunteerTeamId;
  int? helpCenterId;
  String? createdAt;
  String? updatedAt;

  Volunteer(
      {this.id,
      this.userId,
      this.user,
      this.volunteerTypeName,
      this.volunteerTypeCategory,
      this.image,
      this.volunteerTeamId,
      this.helpCenterId,
      this.createdAt,
      this.updatedAt});

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
    volunteerTeamId = json['volunteerTeamId'];
    helpCenterId = json['helpCenterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    data['volunteerTeamId'] = volunteerTeamId;
    data['helpCenterId'] = helpCenterId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

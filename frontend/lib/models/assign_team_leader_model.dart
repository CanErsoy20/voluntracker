class AssignTeamLeaderModel {
  int? volunteerId;
  int? volunteerTeamId;

  AssignTeamLeaderModel({this.volunteerId, this.volunteerTeamId});

  AssignTeamLeaderModel.fromJson(Map<String, dynamic> json) {
    volunteerId = json['volunteerId'];
    volunteerTeamId = json['volunteerTeamId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteerId'] = volunteerId;
    data['volunteerTeamId'] = volunteerTeamId;
    return data;
  }
}

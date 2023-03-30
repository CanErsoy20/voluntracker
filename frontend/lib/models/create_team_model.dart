class CreateTeamModel {
  int? helpCenterId;
  String? teamName;

  CreateTeamModel({this.helpCenterId, this.teamName});

  CreateTeamModel.fromJson(Map<String, dynamic> json) {
    helpCenterId = json['helpCenterId'];
    teamName = json['teamName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['helpCenterId'] = helpCenterId;
    data['teamName'] = teamName;
    return data;
  }
}

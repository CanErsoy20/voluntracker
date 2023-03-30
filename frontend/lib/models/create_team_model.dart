class CreateTeamModel {
  String? teamName;

  CreateTeamModel({this.teamName});

  CreateTeamModel.fromJson(Map<String, dynamic> json) {
    teamName = json['teamName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamName'] = teamName;
    return data;
  }
}

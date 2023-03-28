class Volunteer {
  int? id;
  int? userId;
  String? volunteerTypeName;
  String? volunteerTypeCategory;
  int? volunteerTeamId;
  int? helpCenterId;
  String? createdAt;
  String? updatedAt;

  Volunteer(
      {this.id,
      this.userId,
      this.volunteerTypeName,
      this.volunteerTypeCategory,
      this.volunteerTeamId,
      this.helpCenterId,
      this.createdAt,
      this.updatedAt});

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
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
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    data['volunteerTeamId'] = volunteerTeamId;
    data['helpCenterId'] = helpCenterId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

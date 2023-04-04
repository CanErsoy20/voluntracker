class FollowedCenterModel {
  int? id;
  int? helpCenterId;
  int? volunteerId;
  String? createdAt;

  FollowedCenterModel(
      {this.id, this.helpCenterId, this.volunteerId, this.createdAt});

  FollowedCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    helpCenterId = json['helpCenterId'];
    volunteerId = json['volunteerId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['helpCenterId'] = helpCenterId;
    data['volunteerId'] = volunteerId;
    data['createdAt'] = createdAt;
    return data;
  }
}

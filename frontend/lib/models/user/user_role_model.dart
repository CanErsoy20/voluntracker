class UserRole {
  int? id;
  String? roleName;
  String? createdAt;
  String? updatedAt;

  UserRole({this.id, this.roleName, this.createdAt, this.updatedAt});

  UserRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['roleName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roleName'] = roleName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

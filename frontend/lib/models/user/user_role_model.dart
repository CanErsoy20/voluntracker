class UserRole {
  int? userId;
  String? userRoleName;

  UserRole({this.userId, this.userRoleName});

  UserRole.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userRoleName = json['userRoleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userRoleName'] = userRoleName;
    return data;
  }
}

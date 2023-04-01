import 'package:voluntracker/models/user/user_role_model.dart';

import '../volunteer_model.dart';

class UserModel {
  int? id;
  String? firstname;
  String? surname;
  String? email;
  String? phone;
  String? password;
  int? roleId;
  String? hashedRefreshToken;
  String? createdAt;
  String? updatedAt;
  List<UserRole>? userRole;
  Volunteer? volunteer;

  UserModel(
      {this.id,
      this.firstname,
      this.surname,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.hashedRefreshToken,
      this.createdAt,
      this.updatedAt,
      this.userRole,
      this.volunteer});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    hashedRefreshToken = json['hashedRefreshToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userRole = json['userRole'] != null
        ? List<UserRole>.from(json['userRole'].map((x) => UserRole.fromJson(x)))
        : null;
    volunteer = json['volunteer'] != null
        ? Volunteer.fromJson(json['volunteer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['surname'] = surname;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['roleId'] = roleId;
    data['hashedRefreshToken'] = hashedRefreshToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (userRole != null) {
      data['userRole'] = List<UserRole>.from(userRole!.map((x) => x.toJson()));
    }
    if (volunteer != null) {
      data['volunteer'] = volunteer!.toJson();
    }
    return data;
  }

  // Create a Map of importance
  Map<String, int> roleImportance = {
    "Volunteer": 1,
    "VolunteerTeamLeader": 2,
    "HelpCenterCoordinator": 3,
    "Admin": 4
  };

  String getHighestRole() {
    // Get the highest role according to ruleImportance
    String highestRole = "Volunteer";
    for (var role in userRole!) {
      if (roleImportance[role.userRoleName!]! > roleImportance[highestRole]!) {
        highestRole = role.userRoleName!;
      }
    }
    return highestRole;
  }
}

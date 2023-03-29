import 'create_user_model.dart';

class SignUpModel {
  CreateUserModel? user;

  SignUpModel({this.user});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    user = CreateUserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    VolunteerTemp temp = VolunteerTemp(
        volunteerTypeName: "Carrier", volunteerTypeCategory: "Labor");
    data['user'] = user!.toJson();
    data['volunteer'] = temp.toJson();
    return data;
  }
}

class VolunteerTemp {
  String? volunteerTypeName;
  String? volunteerTypeCategory;

  VolunteerTemp({this.volunteerTypeName, this.volunteerTypeCategory});

  VolunteerTemp.fromJson(Map<String, dynamic> json) {
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    return data;
  }
}

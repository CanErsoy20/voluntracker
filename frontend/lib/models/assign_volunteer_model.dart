class AssignVolunteerModel {
  int? volunteerId;
  int? helpCenterId;
  String? phone;
  String? email;

  AssignVolunteerModel(
      {this.volunteerId, this.helpCenterId, this.phone, this.email});

  AssignVolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteerId = json['volunteerId'];
    helpCenterId = json['helpCenterId'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteerId'] = volunteerId;
    data['helpCenterId'] = helpCenterId;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

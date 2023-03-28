class SignUpModel {
  String? firstname;
  String? surname;
  String? email;
  String? password;
  String? phone;

  SignUpModel(
      {this.firstname, this.surname, this.email, this.password, this.phone});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['surname'] = surname;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    return data;
  }
}

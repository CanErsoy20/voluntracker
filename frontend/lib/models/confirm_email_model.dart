class ConfirmEmailModel {
  String? email;
  String? code;

  ConfirmEmailModel({this.email, this.code});

  ConfirmEmailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['code'] = code;
    return data;
  }
}

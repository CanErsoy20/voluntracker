import 'package:afet_takip/models/auth/tokens_model.dart';

import '../user/user_model.dart';

class AuthResponseModel {
  Tokens? tokens;
  UserModel? user;

  AuthResponseModel({this.tokens, this.user});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

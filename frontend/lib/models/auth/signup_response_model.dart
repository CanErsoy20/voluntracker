import 'package:afet_takip/models/auth/tokens_model.dart';

import '../user/user_model.dart';

class SignUpResponseModel {
  Tokens? tokens;
  UserModel? user;

  SignUpResponseModel({this.tokens, this.user});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
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

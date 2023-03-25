import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:http/http.dart';

import '../api.dart';
import '../models/auth/sign_up_model.dart';
import '../models/auth/tokens_model.dart';

class AuthService {
  AuthService();
  Future<Tokens?> signUp(SignUpModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstant.baseUrl,
          ApiConstant.signUpVolunteer, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        return Tokens.fromJson(body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

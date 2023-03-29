import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:http/http.dart';

import '../api.dart';
import '../models/auth/login_model.dart';
import '../models/auth/sign_up_model.dart';
import '../models/auth/auth_response_model.dart';
import '../models/response_model.dart';
import '../models/user/user_info.dart';
import '../models/user/user_model.dart';

class AuthService {
  AuthService();
  Future<AuthResponseModel?> signUp(SignUpModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstant.baseUrl,
          ApiConstant.signUpVolunteer, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return AuthResponseModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> login(LoginModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstant.baseUrl,
          ApiConstant.login, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = jsonDecode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        AuthResponseModel authResponseModel =
            AuthResponseModel.fromJson(responseModel.data);
        UserInfo.loggedUser = authResponseModel.user;
        UserInfo.tokens = authResponseModel.tokens;
        return authResponseModel.user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

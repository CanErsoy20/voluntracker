import 'dart:convert';

import 'package:http/http.dart';
import 'package:voluntracker/api.dart';
import 'package:voluntracker/constants/api_constants.dart';
import 'package:voluntracker/models/add_profile_pic.dart';

import '../models/response_model.dart';
import '../models/user/user_info.dart';

class ProfileService {
  ProfileService();
  Future<String?> getProfilePicture(int userId) async {
    try {
      Response? response;
      response = await Api.instance.getRequest(ApiConstant.baseUrl,
          "${ApiConstant.assets}${ApiConstant.profilePic}$userId");
      dynamic body = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(body);
      String? imageUrl = responseModel.data;
      return imageUrl;
    } catch (e) {
      return null;
    }
  }

  Future<String?> updateProfilePicture(AddProfileImageModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.assets}${ApiConstant.profilePic}",
          jsonEncode(bodyModel.toJson()));
      dynamic body = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(body);
      String? newImageUrl = responseModel.data;
      return newImageUrl;
    } catch (e) {
      return null;
    }
  }
}

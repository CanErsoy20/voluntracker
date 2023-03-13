import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:afet_takip/models/help_center/create_help_center_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../api.dart';
import '../models/help_center/help_center_model.dart';
import '../models/response_model.dart';

class HelpCenterService {
  HelpCenterService();
  Future<List<HelpCenterModel>?> getHelpCenters() async {
    try {
      Response? response;
      response = await Api.instance.getRequest(
        ApiConstant.baseUrl,
        ApiConstant.helpCenters,
      );
      if (response.statusCode == 200) {
        List<HelpCenterModel> result = <HelpCenterModel>[];
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);

        Map<String, dynamic> map = responseModel.data;
        map.forEach((key, value) {
          result.add(HelpCenterModel.fromJson(value));
        });
        return result;
      } else {
        debugPrint("Response failed${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<HelpCenterModel?> createHelpCenter(CreateHelpCenter bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstant.baseUrl,
          ApiConstant.helpCenters, jsonEncode(bodyModel.toJson()));
      print(response);
      if (response.statusCode == 200) {
        HelpCenterModel result = json.decode(response.body);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

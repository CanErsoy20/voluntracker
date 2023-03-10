import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../api.dart';
import '../models/help_center/help_center_model.dart';

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
        List<dynamic> values = json.decode(response.body);
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            result.add(HelpCenterModel.fromJson(map));
          }
        }
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
}

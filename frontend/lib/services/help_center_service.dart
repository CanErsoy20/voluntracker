import 'dart:convert';

import 'package:voluntracker/constants/api_constants.dart';
import 'package:voluntracker/models/help_center/create_help_center_model.dart';
import 'package:voluntracker/models/needed_supply/create_needed_supply_model.dart';
import 'package:voluntracker/models/needed_volunteer/create_needed_volunteer_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../api.dart';
import '../models/assign_volunteer_model.dart';
import '../models/help_center/help_center_model.dart';
import '../models/response_model.dart';
import '../models/types/supply_types_model.dart';
import '../models/types/volunteer_types_model.dart';
import '../models/user/user_info.dart';

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

        List<dynamic> list = responseModel.data;
        for (int i = 0; i < list.length; i++) {
          result.add(HelpCenterModel.fromJson(list[i]));
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

  Future<HelpCenterModel?> getMyCenter() async {
    try {
      Response? response;
      response = await Api.instance.getRequest(ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}${UserInfo.loggedUser!.volunteer!.helpCenterId}");
      dynamic body = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(body);
      return HelpCenterModel.fromJson(responseModel.data);
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> createHelpCenter(CreateHelpCenter bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(ApiConstant.baseUrl,
          ApiConstant.helpCenters, jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> createNeededVolunteer(
    CreateNeededVolunteer bodyModel,
    int helpCenterID,
  ) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterID/${ApiConstant.neededVolunteers}",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> updateNeededVolunteer(
      CreateNeededVolunteer bodyModel,
      int helpCenterID,
      int neededVolunteerID) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterID/${ApiConstant.neededVolunteers}$neededVolunteerID",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> createNeededSupply(
      CreateNeededSupply bodyModel, int helpCenterID) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterID/${ApiConstant.neededSupply}",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> updateNeededSupply(CreateNeededSupply bodyModel,
      int helpCenterID, int neededSupplyID) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterID/${ApiConstant.neededSupply}$neededSupplyID",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> updateOtherDetails(
      CreateHelpCenter bodyModel, int helpCenterID) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterID",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<SupplyTypeModel>?> getSupplyTypes() async {
    try {
      Response? response;
      response = await Api.instance
          .getRequest(ApiConstant.baseUrl, ApiConstant.supplyTypes);
      if (response.statusCode == 200) {
        List<SupplyTypeModel> result = <SupplyTypeModel>[];
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);

        List<dynamic> list = responseModel.data;
        for (int i = 0; i < list.length; i++) {
          result.add(SupplyTypeModel.fromJson(list[i]));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<VolunteerTypeModel>?> getVolunteerTypes() async {
    try {
      Response? response;
      response = await Api.instance
          .getRequest(ApiConstant.baseUrl, ApiConstant.volunteerTypes);
      if (response.statusCode == 200) {
        List<VolunteerTypeModel> result = <VolunteerTypeModel>[];
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);

        List<dynamic> list = responseModel.data;
        for (int i = 0; i < list.length; i++) {
          result.add(VolunteerTypeModel.fromJson(list[i]));
        }
        return result;
      }
    } catch (e) {
      return null;
    }
  }

  Future<HelpCenterModel?> assignVolunteer(
      AssignVolunteerModel bodyModel) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}${ApiConstant.assignVolunteer}",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return HelpCenterModel.fromJson(responseModel.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

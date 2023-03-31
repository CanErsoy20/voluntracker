import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:afet_takip/models/add_volunteer_response_model.dart';
import 'package:afet_takip/models/create_team_model.dart';
import 'package:afet_takip/models/response_model.dart';
import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:http/http.dart';

import '../api.dart';

class TeamService {
  TeamService();

  Future<List<VolunteerTeam>?> createNewTeam(
      CreateTeamModel bodyModel, int helpCenterId) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterId${ApiConstant.volunteerTeam}",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        List<VolunteerTeam> result = <VolunteerTeam>[];
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        List<dynamic> list = responseModel.data;
        for (int i = 0; i < list.length; i++) {
          result.add(VolunteerTeam.fromJson(list[i]));
        }
        return result;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<AddVolunteerResponseModel?> addVolunteers(
      int helpCenterId, int volunteerTeamId, List<int> requestBody) async {
    try {
      Response? response;
      response = await Api.instance.patchRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterId${ApiConstant.volunteerTeam}$volunteerTeamId${ApiConstant.volunteer}",
          jsonEncode(requestBody));
      dynamic body = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(body);
      AddVolunteerResponseModel addVolunteerResponseModel =
          AddVolunteerResponseModel.fromJson(responseModel.data);
      return addVolunteerResponseModel;
    } catch (e) {
      return null;
    }
  }
}

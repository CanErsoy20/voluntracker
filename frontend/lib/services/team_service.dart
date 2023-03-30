import 'dart:convert';

import 'package:afet_takip/constants/api_constants.dart';
import 'package:afet_takip/models/create_team_model.dart';
import 'package:afet_takip/models/response_model.dart';
import 'package:http/http.dart';

import '../api.dart';

class TeamService {
  TeamService();

  //TODO: response modelini ayarla
  Future<bool> createNewTeam(
      CreateTeamModel bodyModel, int helpCenterId) async {
    try {
      Response? response;
      response = await Api.instance.postRequest(
          ApiConstant.baseUrl,
          "${ApiConstant.helpCenters}$helpCenterId${ApiConstant.volunteerTeam}",
          jsonEncode(bodyModel.toJson()));
      if (response.statusCode == 201) {
        dynamic body = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(body);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

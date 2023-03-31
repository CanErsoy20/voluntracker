import 'add_volunteer_valid_model.dart';

class AddVolunteerResponseModel {
  List<AddVolunteerValidModel>? validRequests;
  List<AddVolunteerValidModel>? invalidRequests;

  AddVolunteerResponseModel({this.validRequests, this.invalidRequests});

  AddVolunteerResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['validRequests'] != null) {
      validRequests = <AddVolunteerValidModel>[];
      json['validRequests'].forEach((v) {
        validRequests!.add(AddVolunteerValidModel.fromJson(v));
      });
    }
    if (json['invalidRequests'] != null) {
      invalidRequests = <AddVolunteerValidModel>[];
      json['invalidRequests'].forEach((v) {
        invalidRequests!.add(AddVolunteerValidModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (validRequests != null) {
      data['validRequests'] = validRequests!.map((v) => v.toJson()).toList();
    }
    if (invalidRequests != null) {
      data['invalidRequests'] =
          invalidRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

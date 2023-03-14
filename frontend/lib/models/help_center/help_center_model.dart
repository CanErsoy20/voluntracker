import 'package:afet_takip/models/help_center/busiest_hours_model.dart';

import '../needed_supply/needed_supply_model.dart';
import '../needed_volunteer/needed_volunteer_model.dart';
import 'contact_info_model.dart';
import 'location_model.dart';
import 'open_close_info_model.dart';

class HelpCenterModel {
  int? id;
  String? name;
  String? additionalInfo;
  int? volunteerCapacity;
  String? createdAt;
  String? updatedAt;
  ContactInfo? contactInfo;
  Location? location;
  BusiestHours? busiestHours;
  OpenCloseInfo? openCloseInfo;
  List<NeededVolunteer>? neededVolunteerList;
  List<NeededSupply>? neededSupplyList;

  HelpCenterModel(
      {this.id,
      this.name,
      this.additionalInfo,
      this.volunteerCapacity,
      this.createdAt,
      this.updatedAt,
      this.contactInfo,
      this.location,
      this.busiestHours,
      this.openCloseInfo,
      this.neededVolunteerList,
      this.neededSupplyList});

  HelpCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    volunteerCapacity = json['volunteerCapacity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    contactInfo = ContactInfo.fromJson(json['contactInfo']);
    location = Location.fromJson(json['location']);
    busiestHours = BusiestHours.fromJson(json['busiestHours']);
    openCloseInfo = OpenCloseInfo.fromJson(json['openCloseInfo']);
    neededVolunteerList = List<NeededVolunteer>.from(
        json['neededVolunteers'].map((x) => NeededVolunteer.fromJson(x)));
    neededSupplyList = List<NeededSupply>.from(
        json['neededSupply'].map((x) => NeededSupply.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['additionalInfo'] = additionalInfo;
    data['volunteerCapacity'] = volunteerCapacity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['contactInfo'] = contactInfo!.toJson();
    data['location'] = location!.toJson();
    data['busiestHours'] = busiestHours!.toJson();
    data['openCloseInfo'] = openCloseInfo!.toJson();
    data['neededVolunteers'] =
        List<NeededVolunteer>.from(neededVolunteerList!.map((x) => x.toJson()));
    data['neededSupply'] =
        List<NeededSupply>.from(neededSupplyList!.map((x) => x.toJson()));
    return data;
  }
}

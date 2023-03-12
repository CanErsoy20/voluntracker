import 'package:afet_takip/models/help_center/open_close_info_model.dart';

import 'busiest_hours_model.dart';
import 'contact_info_model.dart';
import 'location_model.dart';

class CreateHelpCenter {
  String? name;
  Location? location;
  BusiestHours? busiestHours;
  OpenCloseInfo? openCloseInfo;
  ContactInfo? contactInfo;
  String? additionalInfo;
  int? volunteerCapacity;

  CreateHelpCenter(
      {this.name,
      this.location,
      this.busiestHours,
      this.openCloseInfo,
      this.contactInfo,
      this.additionalInfo,
      this.volunteerCapacity});

  CreateHelpCenter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = Location.fromJson(json['location']);
    busiestHours = BusiestHours.fromJson(json['busiestHours']);
    openCloseInfo = OpenCloseInfo.fromJson(json['openCloseInfo']);
    contactInfo = ContactInfo.fromJson(json['contactInfo']);
    additionalInfo = json['additionalInfo'];
    volunteerCapacity = json['volunteerCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location!.toJson();
    data['busiestHours'] = busiestHours!.toJson();
    data['openCloseInfo'] = openCloseInfo!.toJson();
    data['contactInfo'] = contactInfo!.toJson();
    data['additionalInfo'] = additionalInfo;
    data['volunteerCapacity'] = volunteerCapacity;
    return data;
  }
}

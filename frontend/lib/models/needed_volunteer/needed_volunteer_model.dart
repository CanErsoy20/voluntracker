import 'create_needed_volunteer_model.dart';

class NeededVolunteer extends CreateNeededVolunteer {
  int? id;
  String? createdAt;
  String? updatedAt;

  NeededVolunteer({this.id, this.createdAt, this.updatedAt});

  NeededVolunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    urgency = json['urgency'];
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

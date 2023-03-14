class NeededVolunteer {
  int? id;
  int? quantity;
  int? urgency;
  String? volunteerTypeName;
  String? volunteerTypeCategory;
  int? helpCenterId;
  String? createdAt;
  String? updatedAt;

  NeededVolunteer(
      {this.id,
      this.quantity,
      this.urgency,
      this.volunteerTypeName,
      this.volunteerTypeCategory,
      this.helpCenterId,
      this.createdAt,
      this.updatedAt});

  NeededVolunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    urgency = json['urgency'];
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
    helpCenterId = json['helpCenterId'];
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
    data['helpCenterId'] = helpCenterId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

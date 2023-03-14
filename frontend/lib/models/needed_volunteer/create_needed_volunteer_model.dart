class CreateNeededVolunteer {
  int? quantity;
  String? urgency;
  String? volunteerTypeName;
  String? volunteerTypeCategory;
  int? helpCenterId;

  CreateNeededVolunteer({
    this.quantity,
    this.urgency,
    this.volunteerTypeName,
    this.volunteerTypeCategory,
    this.helpCenterId,
  });

  CreateNeededVolunteer.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    urgency = json['urgency'];
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
    helpCenterId = json['helpCenterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    data['helpCenterId'] = helpCenterId;
    return data;
  }
}

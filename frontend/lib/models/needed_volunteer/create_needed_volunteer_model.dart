class CreateNeededVolunteer {
  int? quantity;
  String? urgency;
  String? volunteerTypeName;
  String? volunteerTypeCategory;

  CreateNeededVolunteer({
    this.quantity,
    this.urgency,
    this.volunteerTypeName,
    this.volunteerTypeCategory,
  });

  CreateNeededVolunteer.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    urgency = json['urgency'];
    volunteerTypeName = json['volunteerTypeName'];
    volunteerTypeCategory = json['volunteerTypeCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['volunteerTypeName'] = volunteerTypeName;
    data['volunteerTypeCategory'] = volunteerTypeCategory;
    return data;
  }
}

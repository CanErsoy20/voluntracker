class CreateNeededSupply {
  int? quantity;
  String? urgency;
  String? supplyTypeName;
  String? supplyTypeCategory;

  CreateNeededSupply({
    this.quantity,
    this.urgency,
    this.supplyTypeName,
    this.supplyTypeCategory,
  });

  CreateNeededSupply.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    urgency = json['urgency'];
    supplyTypeName = json['supplyTypeName'];
    supplyTypeCategory = json['supplyTypeCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['supplyTypeName'] = supplyTypeName;
    data['supplyTypeCategory'] = supplyTypeCategory;
    return data;
  }
}

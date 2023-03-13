class CreateNeededSupply {
  int? quantity;
  int? urgency;
  String? supplyTypeName;
  String? supplyTypeCategory;
  int? helpCenterId;

  CreateNeededSupply({
    this.quantity,
    this.urgency,
    this.supplyTypeName,
    this.supplyTypeCategory,
    this.helpCenterId,
  });

  CreateNeededSupply.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    urgency = json['urgency'];
    supplyTypeName = json['supplyTypeName'];
    supplyTypeCategory = json['supplyTypeCategory'];
    helpCenterId = json['helpCenterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['supplyTypeName'] = supplyTypeName;
    data['supplyTypeCategory'] = supplyTypeCategory;
    data['helpCenterId'] = helpCenterId;
    return data;
  }
}

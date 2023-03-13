class NeededSupply {
  int? id;
  int? quantity;
  int? urgency;
  String? supplyTypeName;
  String? supplyTypeCategory;
  int? helpCenterId;
  String? createdAt;
  String? updatedAt;

  NeededSupply(
      {this.id,
      this.quantity,
      this.urgency,
      this.supplyTypeName,
      this.supplyTypeCategory,
      this.helpCenterId,
      this.createdAt,
      this.updatedAt});

  NeededSupply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    urgency = json['urgency'];
    supplyTypeName = json['supplyTypeName'];
    supplyTypeCategory = json['supplyTypeCategory'];
    helpCenterId = json['helpCenterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['urgency'] = urgency;
    data['supplyTypeName'] = supplyTypeName;
    data['supplyTypeCategory'] = supplyTypeCategory;
    data['helpCenterId'] = helpCenterId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

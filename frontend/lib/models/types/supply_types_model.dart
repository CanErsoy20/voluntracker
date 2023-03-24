class SupplyTypeModel {
  String? typeName;
  String? category;

  SupplyTypeModel({this.typeName, this.category});

  SupplyTypeModel.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeName'] = typeName;
    data['category'] = category;
    return data;
  }
}

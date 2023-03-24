class VolunteerTypeModel {
  String? typeName;
  String? category;

  VolunteerTypeModel({this.typeName, this.category});

  VolunteerTypeModel.fromJson(Map<String, dynamic> json) {
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
